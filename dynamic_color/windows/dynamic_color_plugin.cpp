#include "dynamic_color_plugin.h"

// This must be included before many other Windows headers.
#include <windows.h>

// For getPlatformVersion; remove unless needed for your plugin implementation.
#include <VersionHelpers.h>

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>
#include <flutter/standard_method_codec.h>

#include <memory>
#include <sstream>

namespace dynamic_color {

// static
void DynamicColorPlugin::RegisterWithRegistrar(
    flutter::PluginRegistrarWindows *registrar) {
  auto channel =
      std::make_unique<flutter::MethodChannel<flutter::EncodableValue>>(
          registrar->messenger(), "io.material.plugins/dynamic_color",
          &flutter::StandardMethodCodec::GetInstance());

  auto plugin = std::make_unique<DynamicColorPlugin>();

  channel->SetMethodCallHandler(
      [plugin_pointer = plugin.get()](const auto &call, auto result) {
        plugin_pointer->HandleMethodCall(call, std::move(result));
      });

  registrar->AddPlugin(std::move(plugin));
}

DynamicColorPlugin::DynamicColorPlugin() {}

DynamicColorPlugin::~DynamicColorPlugin() {}

void DynamicColorPlugin::HandleMethodCall(
    const flutter::MethodCall<flutter::EncodableValue> &method_call,
    std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result) {
  if (!method_call.method_name().compare("getAccentColor")) {
    int64_t argbColor = 0;
    DWORD abgr = 0;
    DWORD resultSize = sizeof (abgr);
    if (
      RegGetValue(
        HKEY_CURRENT_USER,
        L"Software\\Microsoft\\Windows\\CurrentVersion\\Explorer\\Accent",
        L"AccentColorMenu",
        RRF_RT_REG_DWORD,
        nullptr,
        &abgr,
        &resultSize
      ) == S_OK
    ) {
      argbColor = (abgr & 0xFF00FF00) + ((abgr & 0xFF) << 16) + ((abgr & 0xFF0000) >> 16);
      result->Success(flutter::EncodableValue(argbColor));
    } else result->Success(nullptr);
  } else {
    result->NotImplemented();
  }
}

}  // namespace dynamic_color
