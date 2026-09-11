#pragma once

#include <glib.h>
#include <gtk/gtk.h>

typedef void (*OnAccentColorChanged)(int argb, gpointer user_data);

// Subscribes to the XDG portal settings changed signal.
// Returns non-null on success.
guint subscribe_xdg_portal_setting_changed(OnAccentColorChanged callback, gpointer user_data);

// Unsubscribes from the XDG portal settings changed signal.
// Returns TRUE on success.
gboolean unsubscribe_xdg_portal_setting_changed(guint subscription_id);

// Reads the current XDG portal accent color into out_argb.
// Returns TRUE if successfully read and parsed.
gboolean get_xdg_portal_accent_color(int* out_argb);