#include "dynamic_color_plugin_color.h"

gboolean dynamic_color_plugin_get_gnome_accent_color(const gchar* accent,
                                                     GdkRGBA* color) {
  struct Accent {
    const char* name;
    const char* value;
  };
  static constexpr Accent accents[] = {
      {"blue", "#3584e4"},   {"teal", "#2190a4"},
      {"green", "#3a944a"},  {"yellow", "#c88800"},
      {"orange", "#ed5b00"}, {"red", "#e62d42"},
      {"pink", "#d56199"},   {"purple", "#9141ac"},
      {"slate", "#6f8396"},
  };

  for (const Accent& option : accents) {
    if (g_strcmp0(accent, option.name) == 0) {
      return gdk_rgba_parse(color, option.value);
    }
  }
  return FALSE;
}
