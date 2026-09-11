#include "xdg_accent_color.h"
#include <flutter_linux/flutter_linux.h>
#include <glib.h>
#include <gtk/gtk.h>
#include <math.h>

struct SubscriptionContext {
  OnAccentColorChanged callback;
  gpointer user_data;
};

static int double_tuple_variant_to_argb(GVariant *gvariant) {
  double r, g, b;
  g_variant_get(gvariant, "(ddd)", &r, &g, &b);
  return (255 << 24) | (lround(r * 255) << 16) | (lround(g * 255) << 8) |
         lround(b * 255);
}

static void on_xdg_portal_setting_changed(
    GDBusConnection *connection, const gchar *sender_name,
    const gchar *object_path, const gchar *interface_name,
    const gchar *signal_name, GVariant *parameters, gpointer user_data) {
  const gchar *namespace_str = nullptr;
  const gchar *key_str = nullptr;
  g_autoptr(GVariant) value = nullptr;

  g_variant_get(parameters, "(&s&sv)", &namespace_str, &key_str, &value);
  if (g_strcmp0(namespace_str, "org.freedesktop.appearance") != 0 ||
      g_strcmp0(key_str, "accent-color") != 0) {
    return;
  }

  if (!value || !g_variant_is_of_type(value, G_VARIANT_TYPE("(ddd)"))) {
    return;
  }

  int argb = double_tuple_variant_to_argb(value);

  SubscriptionContext *ctx = static_cast<SubscriptionContext *>(user_data);
  if (!ctx || !ctx->callback) {
    g_warning("user data is not a context or has no callback");
    return;
  }

  ctx->callback(argb, ctx->user_data);
}

static void on_subscription_context_free(gpointer data) {
  SubscriptionContext *ctx = static_cast<SubscriptionContext *>(data);
  delete ctx;
}

gboolean unsubscribe_xdg_portal_setting_changed(guint subscription_id) {
  g_autoptr(GDBusConnection) connection =
      g_bus_get_sync(G_BUS_TYPE_SESSION, nullptr, nullptr);
  if (!connection) {
    return FALSE;
  }

  g_dbus_connection_signal_unsubscribe(connection, subscription_id);

  return TRUE;
}

guint subscribe_xdg_portal_setting_changed(OnAccentColorChanged callback,
                                           gpointer user_data) {
  g_autoptr(GDBusConnection) connection =
      g_bus_get_sync(G_BUS_TYPE_SESSION, nullptr, nullptr);

  if (!connection) {
    return FALSE;
  }

  SubscriptionContext *ctx = new SubscriptionContext{callback, user_data};

  guint subscription_id = g_dbus_connection_signal_subscribe(
      connection, NULL, "org.freedesktop.portal.Settings", "SettingChanged",
      "/org/freedesktop/portal/desktop", NULL, G_DBUS_SIGNAL_FLAGS_NONE,
      on_xdg_portal_setting_changed, ctx, on_subscription_context_free);

  // subscription failed
  if (subscription_id == 0) {
    delete ctx;
  }

  return subscription_id;
}

gboolean get_xdg_portal_accent_color(int *out_argb) {
  g_autoptr(GDBusConnection) connection =
      g_bus_get_sync(G_BUS_TYPE_SESSION, nullptr, nullptr);
  if (!connection) {
    return FALSE;
  }

  g_autoptr(GVariant) result = g_dbus_connection_call_sync(
      connection, "org.freedesktop.portal.Desktop",
      "/org/freedesktop/portal/desktop", "org.freedesktop.portal.Settings",
      "Read",
      g_variant_new("(ss)", "org.freedesktop.appearance", "accent-color"),
      G_VARIANT_TYPE("(v)"), G_DBUS_CALL_FLAGS_NONE, -1, nullptr, nullptr);

  if (!result) {
    return FALSE;
  }

  g_autoptr(GVariant) inner = nullptr;
  g_variant_get(result, "(v)", &inner);
  if (!inner) {
    return FALSE;
  }

  g_autoptr(GVariant) actual_value = g_variant_get_variant(inner);
  if (actual_value &&
      g_variant_is_of_type(actual_value, G_VARIANT_TYPE("(ddd)"))) {
    *out_argb = double_tuple_variant_to_argb(actual_value);
    return TRUE;
  }

  return FALSE;
}
