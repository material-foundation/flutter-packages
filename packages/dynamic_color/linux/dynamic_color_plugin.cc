#include "include/dynamic_color/dynamic_color_plugin.h"
#include "xdg_accent_color.h"

#include <flutter_linux/flutter_linux.h>
#include <glibconfig.h>
#include <gtk/gtk.h>
#include <math.h>

#define DYNAMIC_COLOR_PLUGIN(obj)                                              \
  (G_TYPE_CHECK_INSTANCE_CAST((obj), dynamic_color_plugin_get_type(),          \
                              DynamicColorPlugin))

struct _DynamicColorPlugin {
  GObject parent_instance;
  FlPluginRegistrar *registrar;
  guint xdg_subscription_id;
  FlEventChannel *fl_accent_color_channel;
};

G_DEFINE_TYPE(DynamicColorPlugin, dynamic_color_plugin, g_object_get_type())

static int get_accent_color(GtkWidget *widget) {
  GdkRGBA color;
  GtkStyleContext *context = gtk_widget_get_style_context(widget);
  gtk_style_context_lookup_color(context, "theme_selected_bg_color", &color);
  return lround(color.alpha * 255) << 24 | lround(color.red * 255) << 16 |
         lround(color.green * 255) << 8 | lround(color.blue * 255);
}

static void dynamic_color_plugin_handle_method_call(DynamicColorPlugin *self,
                                                    FlMethodCall *method_call) {
  g_autoptr(FlMethodResponse) response = nullptr;

  const gchar *method = fl_method_call_get_name(method_call);
  if (strcmp(method, "getAccentColor") == 0) {
    int argb;
    if (!get_xdg_portal_accent_color(&argb)) {
      FlView *view = fl_plugin_registrar_get_view(self->registrar);
      argb = get_accent_color(GTK_WIDGET(view));
    }
    g_autoptr(FlValue) result = fl_value_new_int(argb);
    response = FL_METHOD_RESPONSE(fl_method_success_response_new(result));
  } else {
    response = FL_METHOD_RESPONSE(fl_method_not_implemented_response_new());
  }

  fl_method_call_respond(method_call, response, nullptr);
}

static void dynamic_color_plugin_dispose(GObject *object) {
  DynamicColorPlugin *plugin = DYNAMIC_COLOR_PLUGIN(object);

  if (plugin->xdg_subscription_id != 0) {
    unsubscribe_xdg_portal_setting_changed(plugin->xdg_subscription_id);
    plugin->xdg_subscription_id = 0;
  }

  g_object_unref(DYNAMIC_COLOR_PLUGIN(object)->registrar);
  G_OBJECT_CLASS(dynamic_color_plugin_parent_class)->dispose(object);
}

static void dynamic_color_plugin_class_init(DynamicColorPluginClass *klass) {
  G_OBJECT_CLASS(klass)->dispose = dynamic_color_plugin_dispose;
}

static void dynamic_color_plugin_init(DynamicColorPlugin *self) {}

static void method_call_cb(FlMethodChannel *channel, FlMethodCall *method_call,
                           gpointer user_data) {
  DynamicColorPlugin *plugin = DYNAMIC_COLOR_PLUGIN(user_data);
  dynamic_color_plugin_handle_method_call(plugin, method_call);
}

static void accent_color_changed_cb(int argb, gpointer user_data) {
  DynamicColorPlugin *plugin = DYNAMIC_COLOR_PLUGIN(user_data);

  if (plugin->fl_accent_color_channel == 0) {
    return;
  }

  g_autoptr(FlValue) event = fl_value_new_int(argb);
  fl_event_channel_send(plugin->fl_accent_color_channel, event, nullptr,
                        nullptr);
}

static FlMethodErrorResponse *accent_color_listen_cb(FlEventChannel *channel,
                                                     FlValue *args,
                                                     gpointer user_data) {
  DynamicColorPlugin *plugin = DYNAMIC_COLOR_PLUGIN(user_data);

  // For some reason we are being asked to init the stream again, but we can
  // just assume we already set it up and continue sending events as usual.
  if (plugin->xdg_subscription_id) {
    return nullptr;
  }

  plugin->fl_accent_color_channel = channel;
  plugin->xdg_subscription_id =
      subscribe_xdg_portal_setting_changed(accent_color_changed_cb, plugin);

  return nullptr;
}

static FlMethodErrorResponse *accent_color_cancel_cb(FlEventChannel *channel,
                                                     FlValue *args,
                                                     gpointer user_data) {
  DynamicColorPlugin *plugin = DYNAMIC_COLOR_PLUGIN(user_data);
  unsubscribe_xdg_portal_setting_changed(plugin->xdg_subscription_id);

  plugin->xdg_subscription_id = 0;
  plugin->fl_accent_color_channel = nullptr;

  return nullptr;
}

void dynamic_color_plugin_register_with_registrar(
    FlPluginRegistrar *registrar) {
  DynamicColorPlugin *plugin = DYNAMIC_COLOR_PLUGIN(
      g_object_new(dynamic_color_plugin_get_type(), nullptr));
  plugin->registrar = FL_PLUGIN_REGISTRAR(g_object_ref(registrar));

  g_autoptr(FlStandardMethodCodec) codec = fl_standard_method_codec_new();

  FlBinaryMessenger *messenger = fl_plugin_registrar_get_messenger(registrar);

  // set up method channel handler
  g_autoptr(FlMethodChannel) method_channel = fl_method_channel_new(
      messenger, "io.material.plugins/dynamic_color", FL_METHOD_CODEC(codec));

  fl_method_channel_set_method_call_handler(
      method_channel, method_call_cb, g_object_ref(plugin), g_object_unref);

  // set up accent color event channel handler
  g_autoptr(FlEventChannel) accent_color_channel = fl_event_channel_new(
      messenger, "io.material.plugins/dynamic_color/accent_color",
      FL_METHOD_CODEC(codec));

  fl_event_channel_set_stream_handlers(
      accent_color_channel, accent_color_listen_cb, accent_color_cancel_cb,
      g_object_ref(plugin), g_object_unref);

  g_object_unref(plugin);
}
