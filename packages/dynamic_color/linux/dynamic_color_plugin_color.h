#ifndef DYNAMIC_COLOR_PLUGIN_COLOR_H_
#define DYNAMIC_COLOR_PLUGIN_COLOR_H_

#include <gtk/gtk.h>

// Converts a GNOME accent-color enum to its corresponding default palette
// color. Returns FALSE for values that are not part of that palette.
gboolean dynamic_color_plugin_get_gnome_accent_color(const gchar* accent,
                                                     GdkRGBA* color);

#endif  // DYNAMIC_COLOR_PLUGIN_COLOR_H_
