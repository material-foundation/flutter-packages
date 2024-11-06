package io.material.plugins.dynamic_color

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import android.content.res.Resources
import android.os.Build
import androidx.annotation.RequiresApi
import com.google.android.material.color.DynamicColors
import io.flutter.embedding.engine.plugins.FlutterPlugin.FlutterPluginBinding

class DynamicColorPlugin : FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel: MethodChannel

  private lateinit var binding: FlutterPluginBinding

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "io.material.plugins/dynamic_color")
    channel.setMethodCallHandler(this)
    this.binding = flutterPluginBinding
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    when (call.method) {
      "getCorePalette" -> {
        if (DynamicColors.isDynamicColorAvailable()) {
          val resources: Resources = binding.applicationContext.resources
          result.success(getCorePalette(resources))
        } else {
          result.success(null)
        }
      }

      "getColorSchemes" -> {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.UPSIDE_DOWN_CAKE) {
          val resources: Resources = binding.applicationContext.resources
          result.success(getColorScheme(resources))
        } else {
          result.success(null)
        }
      }

      else -> result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  @RequiresApi(Build.VERSION_CODES.S)
  private fun getCorePalette(resources: Resources): IntArray {
    return intArrayOf(
      // Primary tonal palette.
      resources.getColor(android.R.color.system_accent1_1000, null),
      resources.getColor(android.R.color.system_accent1_900, null),
      resources.getColor(android.R.color.system_accent1_800, null),
      resources.getColor(android.R.color.system_accent1_700, null),
      resources.getColor(android.R.color.system_accent1_600, null),
      resources.getColor(android.R.color.system_accent1_500, null),
      resources.getColor(android.R.color.system_accent1_400, null),
      resources.getColor(android.R.color.system_accent1_300, null),
      resources.getColor(android.R.color.system_accent1_200, null),
      resources.getColor(android.R.color.system_accent1_100, null),
      resources.getColor(android.R.color.system_accent1_50, null),
      resources.getColor(android.R.color.system_accent1_10, null),
      resources.getColor(android.R.color.system_accent1_0, null),
      // Secondary tonal palette.
      resources.getColor(android.R.color.system_accent2_1000, null),
      resources.getColor(android.R.color.system_accent2_900, null),
      resources.getColor(android.R.color.system_accent2_800, null),
      resources.getColor(android.R.color.system_accent2_700, null),
      resources.getColor(android.R.color.system_accent2_600, null),
      resources.getColor(android.R.color.system_accent2_500, null),
      resources.getColor(android.R.color.system_accent2_400, null),
      resources.getColor(android.R.color.system_accent2_300, null),
      resources.getColor(android.R.color.system_accent2_200, null),
      resources.getColor(android.R.color.system_accent2_100, null),
      resources.getColor(android.R.color.system_accent2_50, null),
      resources.getColor(android.R.color.system_accent2_10, null),
      resources.getColor(android.R.color.system_accent2_0, null),
      // Tertiary tonal palette.
      resources.getColor(android.R.color.system_accent3_1000, null),
      resources.getColor(android.R.color.system_accent3_900, null),
      resources.getColor(android.R.color.system_accent3_800, null),
      resources.getColor(android.R.color.system_accent3_700, null),
      resources.getColor(android.R.color.system_accent3_600, null),
      resources.getColor(android.R.color.system_accent3_500, null),
      resources.getColor(android.R.color.system_accent3_400, null),
      resources.getColor(android.R.color.system_accent3_300, null),
      resources.getColor(android.R.color.system_accent3_200, null),
      resources.getColor(android.R.color.system_accent3_100, null),
      resources.getColor(android.R.color.system_accent3_50, null),
      resources.getColor(android.R.color.system_accent3_10, null),
      resources.getColor(android.R.color.system_accent3_0, null),
      // Neutral tonal palette.
      resources.getColor(android.R.color.system_neutral1_1000, null),
      resources.getColor(android.R.color.system_neutral1_900, null),
      resources.getColor(android.R.color.system_neutral1_800, null),
      resources.getColor(android.R.color.system_neutral1_700, null),
      resources.getColor(android.R.color.system_neutral1_600, null),
      resources.getColor(android.R.color.system_neutral1_500, null),
      resources.getColor(android.R.color.system_neutral1_400, null),
      resources.getColor(android.R.color.system_neutral1_300, null),
      resources.getColor(android.R.color.system_neutral1_200, null),
      resources.getColor(android.R.color.system_neutral1_100, null),
      resources.getColor(android.R.color.system_neutral1_50, null),
      resources.getColor(android.R.color.system_neutral1_10, null),
      resources.getColor(android.R.color.system_neutral1_0, null),
      // Neutral variant tonal palette.
      resources.getColor(android.R.color.system_neutral2_1000, null),
      resources.getColor(android.R.color.system_neutral2_900, null),
      resources.getColor(android.R.color.system_neutral2_800, null),
      resources.getColor(android.R.color.system_neutral2_700, null),
      resources.getColor(android.R.color.system_neutral2_600, null),
      resources.getColor(android.R.color.system_neutral2_500, null),
      resources.getColor(android.R.color.system_neutral2_400, null),
      resources.getColor(android.R.color.system_neutral2_300, null),
      resources.getColor(android.R.color.system_neutral2_200, null),
      resources.getColor(android.R.color.system_neutral2_100, null),
      resources.getColor(android.R.color.system_neutral2_50, null),
      resources.getColor(android.R.color.system_neutral2_10, null),
      resources.getColor(android.R.color.system_neutral2_0, null),
    );
  }

  @RequiresApi(Build.VERSION_CODES.UPSIDE_DOWN_CAKE)
  private fun getColorScheme(resources: Resources): IntArray {
    return intArrayOf(
      // light
      resources.getColor(android.R.color.system_primary_light, null),
      resources.getColor(android.R.color.system_on_primary_light, null),
      resources.getColor(android.R.color.system_primary_container_light, null),
      resources.getColor(android.R.color.system_on_primary_container_light, null),
      resources.getColor(android.R.color.system_primary_fixed, null),
      resources.getColor(android.R.color.system_primary_fixed_dim, null),
      resources.getColor(android.R.color.system_on_primary_fixed, null),
      resources.getColor(android.R.color.system_on_primary_fixed_variant, null),
      resources.getColor(android.R.color.system_secondary_light, null),
      resources.getColor(android.R.color.system_on_secondary_light, null),
      resources.getColor(android.R.color.system_secondary_container_light, null),
      resources.getColor(android.R.color.system_on_secondary_container_light, null),
      resources.getColor(android.R.color.system_secondary_fixed, null),
      resources.getColor(android.R.color.system_secondary_fixed_dim, null),
      resources.getColor(android.R.color.system_on_secondary_fixed, null),
      resources.getColor(android.R.color.system_on_secondary_fixed_variant, null),
      resources.getColor(android.R.color.system_tertiary_light, null),
      resources.getColor(android.R.color.system_on_tertiary_light, null),
      resources.getColor(android.R.color.system_tertiary_container_light, null),
      resources.getColor(android.R.color.system_on_tertiary_container_light, null),
      resources.getColor(android.R.color.system_tertiary_fixed, null),
      resources.getColor(android.R.color.system_tertiary_fixed_dim, null),
      resources.getColor(android.R.color.system_on_tertiary_fixed, null),
      resources.getColor(android.R.color.system_on_tertiary_fixed_variant, null),
      resources.getColor(android.R.color.system_error_light, null),
      resources.getColor(android.R.color.system_on_error_light, null),
      resources.getColor(android.R.color.system_error_container_light, null),
      resources.getColor(android.R.color.system_on_error_container_light, null),
      resources.getColor(android.R.color.system_surface_light, null),
      resources.getColor(android.R.color.system_on_surface_light, null),
      resources.getColor(android.R.color.system_surface_dim_light, null),
      resources.getColor(android.R.color.system_surface_bright_light, null),
      resources.getColor(android.R.color.system_on_surface_variant_light, null),
      resources.getColor(android.R.color.system_surface_container_lowest_light, null),
      resources.getColor(android.R.color.system_surface_container_low_light, null),
      resources.getColor(android.R.color.system_surface_container_light, null),
      resources.getColor(android.R.color.system_surface_container_high_light, null),
      resources.getColor(android.R.color.system_surface_container_highest_light, null),
      resources.getColor(android.R.color.system_surface_dark, null),
      resources.getColor(android.R.color.system_on_surface_dark, null),
      resources.getColor(android.R.color.system_primary_dark, null),
      resources.getColor(android.R.color.system_outline_light, null),
      resources.getColor(android.R.color.system_outline_variant_light, null),
      // dark
      resources.getColor(android.R.color.system_primary_dark, null),
      resources.getColor(android.R.color.system_on_primary_dark, null),
      resources.getColor(android.R.color.system_primary_container_dark, null),
      resources.getColor(android.R.color.system_on_primary_container_dark, null),
      resources.getColor(android.R.color.system_primary_fixed, null),
      resources.getColor(android.R.color.system_primary_fixed_dim, null),
      resources.getColor(android.R.color.system_on_primary_fixed, null),
      resources.getColor(android.R.color.system_on_primary_fixed_variant, null),
      resources.getColor(android.R.color.system_secondary_dark, null),
      resources.getColor(android.R.color.system_on_secondary_dark, null),
      resources.getColor(android.R.color.system_secondary_container_dark, null),
      resources.getColor(android.R.color.system_on_secondary_container_dark, null),
      resources.getColor(android.R.color.system_secondary_fixed, null),
      resources.getColor(android.R.color.system_secondary_fixed_dim, null),
      resources.getColor(android.R.color.system_on_secondary_fixed, null),
      resources.getColor(android.R.color.system_on_secondary_fixed_variant, null),
      resources.getColor(android.R.color.system_tertiary_dark, null),
      resources.getColor(android.R.color.system_on_tertiary_dark, null),
      resources.getColor(android.R.color.system_tertiary_container_dark, null),
      resources.getColor(android.R.color.system_on_tertiary_container_dark, null),
      resources.getColor(android.R.color.system_tertiary_fixed, null),
      resources.getColor(android.R.color.system_tertiary_fixed_dim, null),
      resources.getColor(android.R.color.system_on_tertiary_fixed, null),
      resources.getColor(android.R.color.system_on_tertiary_fixed_variant, null),
      resources.getColor(android.R.color.system_error_dark, null),
      resources.getColor(android.R.color.system_on_error_dark, null),
      resources.getColor(android.R.color.system_error_container_dark, null),
      resources.getColor(android.R.color.system_on_error_container_dark, null),
      resources.getColor(android.R.color.system_surface_dark, null),
      resources.getColor(android.R.color.system_on_surface_dark, null),
      resources.getColor(android.R.color.system_surface_dim_dark, null),
      resources.getColor(android.R.color.system_surface_bright_dark, null),
      resources.getColor(android.R.color.system_on_surface_variant_dark, null),
      resources.getColor(android.R.color.system_surface_container_lowest_dark, null),
      resources.getColor(android.R.color.system_surface_container_low_dark, null),
      resources.getColor(android.R.color.system_surface_container_dark, null),
      resources.getColor(android.R.color.system_surface_container_high_dark, null),
      resources.getColor(android.R.color.system_surface_container_highest_dark, null),
      resources.getColor(android.R.color.system_surface_light, null),
      resources.getColor(android.R.color.system_on_surface_light, null),
      resources.getColor(android.R.color.system_primary_light, null),
      resources.getColor(android.R.color.system_outline_dark, null),
      resources.getColor(android.R.color.system_outline_variant_dark, null),
    )
  }
}
