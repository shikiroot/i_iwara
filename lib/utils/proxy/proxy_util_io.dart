import 'dart:io';
import 'package:i_iwara/utils/proxy/system_proxy_settings.dart';
import 'package:win32/win32.dart';

import '../platforms/microsoft_windows_registry_utils.dart';

ProxySettings getPlatformProxySettings() {
  if (Platform.isWindows) {
    return getWindowsProxySettings();
  } else {
    // 返回其他平台的默认设置或抛出异常
    return ProxySettings(enabled: false);
  }
}

ProxySettings getWindowsProxySettings() {
  final hKey = RegistryUtil.openKey(HKEY_CURRENT_USER, internetSettingsKey);

  try {
    final proxyEnable = RegistryUtil.queryValue(hKey, 'ProxyEnable') as int?;
    final proxyServer = RegistryUtil.queryValue(hKey, 'ProxyServer') as String?;
    final autoConfigUrl =
        RegistryUtil.queryValue(hKey, 'AutoConfigURL') as String?;
    final proxyOverride =
        RegistryUtil.queryValue(hKey, 'ProxyOverride') as String?;

    return ProxySettings(
      enabled: proxyEnable == 1,
      server: proxyServer,
      autoConfigUrl: autoConfigUrl,
      proxyOverride: proxyOverride,
    );
  } finally {
    RegistryUtil.closeKey(hKey);
  }
}
