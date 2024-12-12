import 'package:flutter/material.dart';
import 'package:i_iwara/app/ui/pages/settings/widgets/settings_app_bar.dart';

// TODO: 动态主题设置页面
class ThemeSettingsPage extends StatelessWidget {
  final bool isWideScreen;

  const ThemeSettingsPage({super.key, this.isWideScreen = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SettingsAppBar(
        title: '主题设置',
        isWideScreen: isWideScreen,
      ),
      body: Center(
        child: Text('这里是主题设置页面', style: Theme.of(context).textTheme.headlineSmall),
      ),
    );
  }
}