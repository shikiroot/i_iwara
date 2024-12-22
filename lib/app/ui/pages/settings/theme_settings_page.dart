import 'package:flutter/material.dart';
import 'package:i_iwara/app/ui/pages/settings/widgets/settings_app_bar.dart';
import 'package:i_iwara/i18n/strings.g.dart' as slang;
// TODO: 动态主题设置页面
class ThemeSettingsPage extends StatelessWidget {
  final bool isWideScreen;

  const ThemeSettingsPage({super.key, this.isWideScreen = false});

  @override
  Widget build(BuildContext context) {
    final t = slang.Translations.of(context);
    return Scaffold(
      appBar: SettingsAppBar(
        title: t.settings.themeSettings,
        isWideScreen: isWideScreen,
      ),
      body: Center(
        child: Text(t.common.comingSoon, style: Theme.of(context).textTheme.headlineSmall),
      ),
    );
  }
}