package io.material.plugins.dynamic_colors

import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import android.content.res.Resources
import android.os.Build
import androidx.annotation.RequiresApi
import io.flutter.embedding.engine.plugins.FlutterPlugin.FlutterPluginBinding

class DynamicColorsPlugin : FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel: MethodChannel

  private lateinit var binding: FlutterPluginBinding

  override fun onAttachedToEngine(
    @NonNull flutterPluginBinding: FlutterPluginBinding
  ) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "io.material.plugins/dynamic_colors")
    channel.setMethodCallHandler(this)
    this.binding = flutterPluginBinding
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method.equals("getDynamicColors")) {
      // Dynamic colors are only available on Android S and up.
      if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
        val resources: Resources = binding.applicationContext.resources
        result.success(getTonalPalette(resources))
      } else {
        result.success(null)
      }
    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  @RequiresApi(Build.VERSION_CODES.S)
  private fun getTonalPalette(resources: Resources): IntArray {
    return intArrayOf(
      // Neutral tonal range.
      resources.getColor(android.R.color.system_neutral1_0, null),
      resources.getColor(android.R.color.system_neutral1_10, null),
      resources.getColor(android.R.color.system_neutral1_50, null),
      resources.getColor(android.R.color.system_neutral1_100, null),
      resources.getColor(android.R.color.system_neutral1_200, null),
      resources.getColor(android.R.color.system_neutral1_300, null),
      resources.getColor(android.R.color.system_neutral1_400, null),
      resources.getColor(android.R.color.system_neutral1_500, null),
      resources.getColor(android.R.color.system_neutral1_600, null),
      resources.getColor(android.R.color.system_neutral1_700, null),
      resources.getColor(android.R.color.system_neutral1_800, null),
      resources.getColor(android.R.color.system_neutral1_900, null),
      resources.getColor(android.R.color.system_neutral1_1000, null),
      // Neutral variant tonal range.
      resources.getColor(android.R.color.system_neutral2_0, null),
      resources.getColor(android.R.color.system_neutral2_10, null),
      resources.getColor(android.R.color.system_neutral2_50, null),
      resources.getColor(android.R.color.system_neutral2_100, null),
      resources.getColor(android.R.color.system_neutral2_200, null),
      resources.getColor(android.R.color.system_neutral2_300, null),
      resources.getColor(android.R.color.system_neutral2_400, null),
      resources.getColor(android.R.color.system_neutral2_500, null),
      resources.getColor(android.R.color.system_neutral2_600, null),
      resources.getColor(android.R.color.system_neutral2_700, null),
      resources.getColor(android.R.color.system_neutral2_800, null),
      resources.getColor(android.R.color.system_neutral2_900, null),
      resources.getColor(android.R.color.system_neutral2_1000, null),
      // Primary tonal range.
      resources.getColor(android.R.color.system_accent1_0, null),
      resources.getColor(android.R.color.system_accent1_10, null),
      resources.getColor(android.R.color.system_accent1_50, null),
      resources.getColor(android.R.color.system_accent1_100, null),
      resources.getColor(android.R.color.system_accent1_200, null),
      resources.getColor(android.R.color.system_accent1_300, null),
      resources.getColor(android.R.color.system_accent1_400, null),
      resources.getColor(android.R.color.system_accent1_500, null),
      resources.getColor(android.R.color.system_accent1_600, null),
      resources.getColor(android.R.color.system_accent1_700, null),
      resources.getColor(android.R.color.system_accent1_800, null),
      resources.getColor(android.R.color.system_accent1_900, null),
      resources.getColor(android.R.color.system_accent1_1000, null),
      // Secondary tonal range.
      resources.getColor(android.R.color.system_accent2_0, null),
      resources.getColor(android.R.color.system_accent2_10, null),
      resources.getColor(android.R.color.system_accent2_50, null),
      resources.getColor(android.R.color.system_accent2_100, null),
      resources.getColor(android.R.color.system_accent2_200, null),
      resources.getColor(android.R.color.system_accent2_300, null),
      resources.getColor(android.R.color.system_accent2_400, null),
      resources.getColor(android.R.color.system_accent2_500, null),
      resources.getColor(android.R.color.system_accent2_600, null),
      resources.getColor(android.R.color.system_accent2_700, null),
      resources.getColor(android.R.color.system_accent2_800, null),
      resources.getColor(android.R.color.system_accent2_900, null),
      resources.getColor(android.R.color.system_accent2_1000, null),
      // Tertiary tonal range.
      resources.getColor(android.R.color.system_accent3_0, null),
      resources.getColor(android.R.color.system_accent3_10, null),
      resources.getColor(android.R.color.system_accent3_50, null),
      resources.getColor(android.R.color.system_accent3_100, null),
      resources.getColor(android.R.color.system_accent3_200, null),
      resources.getColor(android.R.color.system_accent3_300, null),
      resources.getColor(android.R.color.system_accent3_400, null),
      resources.getColor(android.R.color.system_accent3_500, null),
      resources.getColor(android.R.color.system_accent3_600, null),
      resources.getColor(android.R.color.system_accent3_700, null),
      resources.getColor(android.R.color.system_accent3_800, null),
      resources.getColor(android.R.color.system_accent3_900, null),
      resources.getColor(android.R.color.system_accent3_1000, null)
    )
  }
}
