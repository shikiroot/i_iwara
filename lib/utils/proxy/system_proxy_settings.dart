/// 代理设置模型类
class ProxySettings {
  final bool enabled;
  final String? server;
  final String? autoConfigUrl;
  final String? proxyOverride;

  ProxySettings({
    required this.enabled,
    this.server,
    this.autoConfigUrl,
    this.proxyOverride,
  });

  @override
  String toString() {
    return 'ProxySettings{enabled: $enabled, server: $server, autoConfigUrl: $autoConfigUrl, proxyOverride: $proxyOverride}';
  }
}
