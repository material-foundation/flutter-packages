#include "include/dynamic_color/dynamic_color_plugin.h"

#include <flutter_linux/flutter_linux.h>
#include <gtk/gtk.h>
#include <math.h>

#define DYNAMIC_COLOR_PLUGIN(obj)                                     \
  (G_TYPE_CHECK_INSTANCE_CAST((obj), dynamic_color_plugin_get_type(), \
                              DynamicColorPlugin))

struct _DynamicColorPlugin {
  GObject parent_instance;
  FlPluginRegistrar* registrar;
  FlEventChannel* accent_color_channel;
  GDBusConnection* portal_connection;
  guint portal_subscription_id;
};

G_DEFINE_TYPE(DynamicColorPlugin, dynamic_color_plugin, g_object_get_type())

// How long the portal may take to answer before the GTK theme color is used.
static const gint kPortalTimeoutMs = 2000;

// Returns FALSE when the view is gone or the GTK theme does not define the
// color.
static gboolean get_theme_accent_color(DynamicColorPlugin* self,
                                       int* out_argb) {
  FlView* view = fl_plugin_registrar_get_view(self->registrar);
  if (view == nullptr) {
    return FALSE;
  }
  GdkRGBA color;
  GtkStyleContext* context = gtk_widget_get_style_context(GTK_WIDGET(view));
  if (!gtk_style_context_lookup_color(context, "theme_selected_bg_color",
                                      &color)) {
    return FALSE;
  }
  *out_argb = lround(color.alpha * 255) << 24 | lround(color.red * 255) << 16 |
              lround(color.green * 255) << 8 | lround(color.blue * 255);
  return TRUE;
}

static gboolean is_color_channel(double value) {
  return value >= 0 && value <= 1;
}

// Reads an accent-color value, which older portals wrap in more than one
// variant.
static gboolean portal_value_to_argb(GVariant* value, int* out_argb) {
  g_autoptr(GVariant) color = g_variant_ref(value);
  while (g_variant_is_of_type(color, G_VARIANT_TYPE_VARIANT)) {
    GVariant* inner = g_variant_get_variant(color);
    g_variant_unref(color);
    color = inner;
  }
  if (!g_variant_is_of_type(color, G_VARIANT_TYPE("(ddd)"))) {
    return FALSE;
  }
  double r, g, b;
  g_variant_get(color, "(ddd)", &r, &g, &b);
  // The portal reports an unset accent color with out-of-range values.
  if (!is_color_channel(r) || !is_color_channel(g) || !is_color_channel(b)) {
    return FALSE;
  }
  *out_argb = (255 << 24) | (lround(r * 255) << 16) | (lround(g * 255) << 8) |
              lround(b * 255);
  return TRUE;
}

// A getAccentColor call waiting for the portal.
typedef struct {
  DynamicColorPlugin* plugin;
  FlMethodCall* method_call;
} AccentColorRequest;

// Answers [request] with the portal's accent color in [result], or with the
// GTK theme color when [result] is null or holds no usable color, or with null
// when there is no GTK theme color either, and frees [request].
static void respond_accent_color(AccentColorRequest* request,
                                 GVariant* result) {
  int argb;
  const gboolean has_color =
      (result != nullptr && portal_value_to_argb(result, &argb)) ||
      get_theme_accent_color(request->plugin, &argb);
  g_autoptr(FlValue) value =
      has_color ? fl_value_new_int(argb) : fl_value_new_null();
  g_autoptr(FlMethodResponse) response =
      FL_METHOD_RESPONSE(fl_method_success_response_new(value));
  fl_method_call_respond(request->method_call, response, nullptr);
  g_object_unref(request->method_call);
  g_object_unref(request->plugin);
  g_free(request);
}

static void portal_read_cb(GObject* source, GAsyncResult* result,
                           gpointer user_data) {
  g_autoptr(GVariant) reply = g_dbus_connection_call_finish(
      G_DBUS_CONNECTION(source), result, nullptr);
  g_autoptr(GVariant) value = nullptr;
  if (reply != nullptr) {
    g_variant_get(reply, "(v)", &value);
  }
  respond_accent_color(static_cast<AccentColorRequest*>(user_data), value);
}

static void session_bus_cb(GObject* source, GAsyncResult* result,
                           gpointer user_data) {
  g_autoptr(GDBusConnection) connection = g_bus_get_finish(result, nullptr);
  if (connection == nullptr) {
    respond_accent_color(static_cast<AccentColorRequest*>(user_data), nullptr);
    return;
  }
  g_dbus_connection_call(
      connection, "org.freedesktop.portal.Desktop",
      "/org/freedesktop/portal/desktop", "org.freedesktop.portal.Settings",
      "Read",
      g_variant_new("(ss)", "org.freedesktop.appearance", "accent-color"),
      G_VARIANT_TYPE("(v)"), G_DBUS_CALL_FLAGS_NONE, kPortalTimeoutMs, nullptr,
      portal_read_cb, user_data);
}

// Reads the accent color from the XDG portal without blocking the platform
// thread, and answers [method_call] once it has it.
static void read_accent_color(DynamicColorPlugin* self,
                              FlMethodCall* method_call) {
  AccentColorRequest* request = g_new0(AccentColorRequest, 1);
  request->plugin = DYNAMIC_COLOR_PLUGIN(g_object_ref(self));
  request->method_call = FL_METHOD_CALL(g_object_ref(method_call));
  g_bus_get(G_BUS_TYPE_SESSION, nullptr, session_bus_cb, request);
}

static void portal_setting_changed_cb(GDBusConnection* connection,
                                      const gchar* sender_name,
                                      const gchar* object_path,
                                      const gchar* interface_name,
                                      const gchar* signal_name,
                                      GVariant* parameters,
                                      gpointer user_data) {
  DynamicColorPlugin* self = DYNAMIC_COLOR_PLUGIN(user_data);

  if (!g_variant_is_of_type(parameters, G_VARIANT_TYPE("(ssv)"))) {
    return;
  }
  const gchar* setting_namespace = nullptr;
  const gchar* key = nullptr;
  g_autoptr(GVariant) value = nullptr;
  g_variant_get(parameters, "(&s&sv)", &setting_namespace, &key, &value);
  if (g_strcmp0(setting_namespace, "org.freedesktop.appearance") != 0 ||
      g_strcmp0(key, "accent-color") != 0) {
    return;
  }

  int argb;
  if (!portal_value_to_argb(value, &argb) &&
      !get_theme_accent_color(self, &argb)) {
    return;
  }
  g_autoptr(FlValue) event = fl_value_new_int(argb);
  fl_event_channel_send(self->accent_color_channel, event, nullptr, nullptr);
}

static void unsubscribe_from_portal(DynamicColorPlugin* self) {
  if (self->portal_subscription_id != 0) {
    g_dbus_connection_signal_unsubscribe(self->portal_connection,
                                         self->portal_subscription_id);
    self->portal_subscription_id = 0;
  }
  g_clear_object(&self->portal_connection);
}

static FlMethodErrorResponse* accent_color_listen_cb(FlEventChannel* channel,
                                                     FlValue* args,
                                                     gpointer user_data) {
  DynamicColorPlugin* self = DYNAMIC_COLOR_PLUGIN(user_data);

  unsubscribe_from_portal(self);
  g_set_object(&self->accent_color_channel, channel);
  self->portal_connection =
      g_bus_get_sync(G_BUS_TYPE_SESSION, nullptr, nullptr);
  if (self->portal_connection) {
    self->portal_subscription_id = g_dbus_connection_signal_subscribe(
        self->portal_connection, "org.freedesktop.portal.Desktop",
        "org.freedesktop.portal.Settings", "SettingChanged",
        "/org/freedesktop/portal/desktop", nullptr, G_DBUS_SIGNAL_FLAGS_NONE,
        portal_setting_changed_cb, self, nullptr);
  }
  return nullptr;
}

static FlMethodErrorResponse* accent_color_cancel_cb(FlEventChannel* channel,
                                                     FlValue* args,
                                                     gpointer user_data) {
  unsubscribe_from_portal(DYNAMIC_COLOR_PLUGIN(user_data));
  return nullptr;
}

static void dynamic_color_plugin_handle_method_call(DynamicColorPlugin* self,
                                                    FlMethodCall* method_call) {
  const gchar* method = fl_method_call_get_name(method_call);
  if (strcmp(method, "getAccentColor") == 0) {
    read_accent_color(self, method_call);
    return;
  }

  g_autoptr(FlMethodResponse) response =
      FL_METHOD_RESPONSE(fl_method_not_implemented_response_new());
  fl_method_call_respond(method_call, response, nullptr);
}

static void dynamic_color_plugin_dispose(GObject* object) {
  unsubscribe_from_portal(DYNAMIC_COLOR_PLUGIN(object));
  g_clear_object(&DYNAMIC_COLOR_PLUGIN(object)->accent_color_channel);
  g_object_unref(DYNAMIC_COLOR_PLUGIN(object)->registrar);
  G_OBJECT_CLASS(dynamic_color_plugin_parent_class)->dispose(object);
}

static void dynamic_color_plugin_class_init(DynamicColorPluginClass* klass) {
  G_OBJECT_CLASS(klass)->dispose = dynamic_color_plugin_dispose;
}

static void dynamic_color_plugin_init(DynamicColorPlugin* self) {}

static void method_call_cb(FlMethodChannel* channel, FlMethodCall* method_call,
                           gpointer user_data) {
  DynamicColorPlugin* plugin = DYNAMIC_COLOR_PLUGIN(user_data);
  dynamic_color_plugin_handle_method_call(plugin, method_call);
}

void dynamic_color_plugin_register_with_registrar(
    FlPluginRegistrar* registrar) {
  DynamicColorPlugin* plugin = DYNAMIC_COLOR_PLUGIN(
      g_object_new(dynamic_color_plugin_get_type(), nullptr));
  plugin->registrar = FL_PLUGIN_REGISTRAR(g_object_ref(registrar));

  g_autoptr(FlStandardMethodCodec) codec = fl_standard_method_codec_new();
  FlBinaryMessenger* messenger = fl_plugin_registrar_get_messenger(registrar);
  g_autoptr(FlMethodChannel) channel = fl_method_channel_new(
      messenger, "io.material.plugins/dynamic_color", FL_METHOD_CODEC(codec));
  fl_method_channel_set_method_call_handler(
      channel, method_call_cb, g_object_ref(plugin), g_object_unref);

  g_autoptr(FlEventChannel) accent_color_channel = fl_event_channel_new(
      messenger, "io.material.plugins/dynamic_color/accent_color",
      FL_METHOD_CODEC(codec));
  fl_event_channel_set_stream_handlers(
      accent_color_channel, accent_color_listen_cb, accent_color_cancel_cb,
      g_object_ref(plugin), g_object_unref);

  g_object_unref(plugin);
}
