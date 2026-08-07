#include "dynamic_color_plugin_color.h"

#include <glib.h>

static void test_known_accent_color() {
  GdkRGBA color;
  g_assert_true(
      dynamic_color_plugin_get_gnome_accent_color("orange", &color));
  g_assert_cmpfloat(color.red, ==, 0xed / 255.0);
  g_assert_cmpfloat(color.green, ==, 0x5b / 255.0);
  g_assert_cmpfloat(color.blue, ==, 0x00 / 255.0);
  g_assert_cmpfloat(color.alpha, ==, 1.0);
}

static void test_unknown_accent_color() {
  GdkRGBA color;
  g_assert_false(
      dynamic_color_plugin_get_gnome_accent_color("not-a-color", &color));
}

int main(int argc, char** argv) {
  g_test_init(&argc, &argv, nullptr);
  g_test_add_func("/dynamic_color/known_accent_color",
                  test_known_accent_color);
  g_test_add_func("/dynamic_color/unknown_accent_color",
                  test_unknown_accent_color);
  return g_test_run();
}
