import 'package:flutter/material.dart';
import 'package:i_iwara/app/ui/pages/settings/widgets/proxy_setting_widget.dart';
import 'package:i_iwara/app/ui/pages/settings/widgets/settings_app_bar.dart';


class ProxySettingsPage extends StatelessWidget {
  final bool isWideScreen;

  const ProxySettingsPage({super.key, this.isWideScreen = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SettingsAppBar(
        title: '网络代理设置',
        isWideScreen: isWideScreen,
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
