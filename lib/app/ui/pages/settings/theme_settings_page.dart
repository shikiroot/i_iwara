import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_iwara/app/models/theme_mode.model.dart';
import 'package:i_iwara/app/services/theme_service.dart';
import 'package:i_iwara/app/ui/pages/settings/widgets/settings_app_bar.dart';
import 'package:i_iwara/i18n/strings.g.dart' as slang;
class ThemeSettingsPage extends StatelessWidget {
  final bool isWideScreen;

  const ThemeSettingsPage({super.key, this.isWideScreen = false});

  @override
  Widget build(BuildContext context) {
    final t = slang.Translations.of(context);
    final themeService = Get.find<ThemeService>();
    
    return Scaffold(
      appBar: SettingsAppBar(
        title: t.settings.themeSettings,
        isWideScreen: isWideScreen,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildNeedRestartSection(context, t),
          _buildBasicThemeSection(context, t, themeService),
          const SizedBox(height: 16),
          _buildPresetThemesSection(context, t, themeService),
        ],
      ),
    );
  }

  Widget _buildNeedRestartSection(BuildContext context, slang.Translations t) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              t.settings.needRestartToApply,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(t.settings.themeNeedRestartDescription),
          ),
        ],
      ),
    );
  }

  Widget _buildBasicThemeSection(BuildContext context, slang.Translations t, ThemeService themeService) {
    final t = slang.Translations.of(context);
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              t.settings.basicTheme,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Obx(() => RadioListTile<AppThemeMode>(
            title: Text(t.settings.followSystem),
            value: AppThemeMode.system,
            groupValue: themeService.themeMode,
            onChanged: (value) => themeService.setThemeMode(value!),
          )),
          Obx(() => RadioListTile<AppThemeMode>(
            title: Text(t.settings.lightMode),
            value: AppThemeMode.light,
            groupValue: themeService.themeMode,
            onChanged: (value) => themeService.setThemeMode(value!),
          )),
          Obx(() => RadioListTile<AppThemeMode>(
            title: Text(t.settings.darkMode),
            value: AppThemeMode.dark,
            groupValue: themeService.themeMode,
            onChanged: (value) => themeService.setThemeMode(value!),
          )),
        ],
      ),
    );
  }

  Widget _buildPresetThemesSection(BuildContext context, slang.Translations t, ThemeService themeService) {
    final int presetCount = AppThemeMode.values.length - AppThemeMode.preset1.index;
    final int availablePresets = presetCount.clamp(0, ThemeService.presetColors.length);
    final t = slang.Translations.of(context);

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              t.settings.presetTheme,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                for (int i = 0; i < availablePresets; i++)
                  _buildColorOption(
                    context,
                    ThemeService.presetColors[i],
                    '${t.settings.presetTheme} ${i + 1}',
                    AppThemeMode.values[i + AppThemeMode.preset1.index],
                    themeService,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildColorOption(
    BuildContext context,
    Color color,
    String label,
    AppThemeMode mode,
    ThemeService themeService,
  ) {
    return Obx(() {
      final isSelected = themeService.themeMode == mode;
      return InkWell(
        onTap: () => themeService.setThemeMode(mode),
        child: Column(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? Theme.of(context).primaryColor : Colors.transparent,
                  width: 3,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      );
    });
  }
}