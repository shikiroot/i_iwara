import 'package:flutter/material.dart';
import 'package:i_iwara/app/ui/pages/settings/widgets/proxy_setting_widget.dart';


class ProxySettingsPage extends StatelessWidget {
  const ProxySettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('网络代理设置'),
        elevation: 2,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProxySettingsWidget(),
          ],
        ),
      ),
    );
  }
}
