
import 'package:flutter/material.dart';

// TODO: 动态主题设置页面
class ThemeSettingsPage extends StatelessWidget {
  const ThemeSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('主题设置'),
        centerTitle: true,
        elevation: 2,
      ),
      body: Center(
        child: Text('这里是主题设置页面', style: Theme.of(context).textTheme.headlineSmall),
      ),
    );
  }
}