import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_iwara/app/services/config_service.dart';
import 'package:i_iwara/app/services/version_service.dart';
import 'package:i_iwara/app/ui/pages/settings/widgets/settings_app_bar.dart';
import 'package:i_iwara/common/constants.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:i_iwara/i18n/strings.g.dart' as slang;

class AboutPage extends StatefulWidget {
  final bool isWideScreen;

  const AboutPage({super.key, this.isWideScreen = false});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  final VersionService _versionService = Get.find();
  final ConfigService _configService = Get.find();

  @override
  void initState() {
    super.initState();
    _checkUpdate();
  }

  Future<void> _checkUpdate() async {
    await _versionService.checkUpdate();
  }

  Future<void> _openReleaseUrl() async {
    final url = Uri.parse(_configService[ConfigService.REMOTE_REPO_RELEASE_URL]);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  void _showLicenses() {
    showLicensePage(
      context: context,
      applicationVersion: _versionService.currentVersion.value,
      applicationIcon: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(
          CommonConstants.launcherIconPath,
          width: 48,
          height: 48,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = slang.Translations.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: SettingsAppBar(
        title: t.settings.about,
        isWideScreen: widget.isWideScreen,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              child: Column(
                children: [
                  // App Logo
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      CommonConstants.launcherIconPath,
                      width: 80,
                      height: 80,
                    )
                  ),
                  const SizedBox(height: 24),

                  // 当前版本
                  Obx(() => Text(
                    '${t.settings.currentVersion} ${_versionService.currentVersion.value}',
                    style: theme.textTheme.titleMedium,
                  )),
                  const SizedBox(height: 24),

                  // 版本检查区域
                  Obx(() {
                    if (_versionService.isChecking.value) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (_versionService.errorMessage.value.isNotEmpty) {
                      return Column(
                        children: [
                          Text(
                            _versionService.errorMessage.value,
                            style: TextStyle(
                              color: theme.colorScheme.error,
                            ),
                          ),
                          const SizedBox(height: 8),
                          OutlinedButton.icon(
                            onPressed: _checkUpdate,
                            icon: const Icon(Icons.refresh),
                            label: Text(t.common.retry),
                          ),
                        ],
                      );
                    }

                    if (_versionService.hasUpdate.value) {
                      return Column(
                        children: [
                          Text(
                            '${t.settings.newVersionAvailable} ${_versionService.latestVersion.value}',
                            style: TextStyle(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton.icon(
                            onPressed: _openReleaseUrl,
                            icon: const Icon(Icons.system_update, color: Colors.white),
                            label: Text(t.settings.update),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: theme.colorScheme.primary,
                              foregroundColor: theme.colorScheme.onPrimary,
                            ),
                          ),
                        ],
                      );
                    }

                    return OutlinedButton.icon(
                      onPressed: _checkUpdate,
                      icon: const Icon(Icons.update),
                      label: Text(t.settings.checkForUpdates),
                    );
                  }),
                ],
              ),
            ),
          ),

          // 其他信息卡片
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Card(
              elevation: 2,
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  ListTile(
                    leading: const Icon(Icons.code),
                    title: Text(t.settings.projectHome),
                    subtitle: const Text('GitHub'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => launchUrl(
                      Uri.parse(_configService[ConfigService.REMOTE_REPO_URL]),
                    ),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.new_releases),
                    title: Text(t.settings.release),
                    subtitle: const Text('Releases'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => launchUrl(
                      Uri.parse(_configService[ConfigService.REMOTE_REPO_RELEASE_URL]),
                    ),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.bug_report),
                    title: Text(t.settings.issueReport),
                    subtitle: const Text('Issues'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => launchUrl(
                      Uri.parse('${_configService[ConfigService.REMOTE_REPO_URL]}/issues'),
                    ),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.description),
                    title: Text(t.settings.openSourceLicense),
                    subtitle: const Text('Licenses'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: _showLicenses,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: Get.context != null ? MediaQuery.of(Get.context!).padding.bottom : 0),
        ],
      ),
    );
  }
}