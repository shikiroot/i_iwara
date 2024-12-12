import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/proxy/proxy_util.dart';
import '../../../routes/app_routes.dart';
import 'player_settings_page.dart';
import 'proxy_settings_page.dart';
import 'theme_settings_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 获取屏幕宽度
    final double screenWidth = MediaQuery.of(context).size.width;
    // 定义宽屏的阈值
    const double wideScreenThreshold = 800;
    // 是否是宽屏
    final bool isWideScreen = screenWidth >= wideScreenThreshold;

    // 定义设置项列表
    final List<SettingItem> settingItems = [
      if (ProxyUtil.isSupportedPlatform())
        SettingItem(
          title: '网络代理设置',
          subtitle: '配置您的代理服务器',
          icon: Icons.wifi,
          page: ProxySettingsPage(isWideScreen: isWideScreen),
          route: Routes.PROXY_SETTINGS_PAGE,
        ),
      SettingItem(
        title: '播放器设置',
        subtitle: '自定义您的播放体验',
        icon: Icons.play_circle_outline,
        page: PlayerSettingsPage(isWideScreen: isWideScreen),
        route: Routes.PLAYER_SETTINGS_PAGE,
      ),
      SettingItem(
        title: '主题设置',
        subtitle: '选择您喜欢的应用外观',
        icon: Icons.color_lens,
        page: ThemeSettingsPage(isWideScreen: isWideScreen),
        route: Routes.THEME_SETTINGS_PAGE,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('设置', style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 2,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
      ),
      body: isWideScreen
          ? _buildWideScreenLayout(context, settingItems)
          : _buildNarrowScreenLayout(context, settingItems),
    );
  }

  Widget _buildWideScreenLayout(
      BuildContext context, List<SettingItem> settingItems) {
    // 使用 GetX 管理当前选中的设置项
    final selectedIndex = 0.obs;

    return Row(
      children: [
        // 左侧菜单
        SizedBox(
          width: 300,
          child: Card(
            margin: const EdgeInsets.all(16),
            elevation: 4,
            // color: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: settingItems.length,
              itemBuilder: (context, index) {
                final item = settingItems[index];
                return Obx(() => _buildSettingsListTile(
                      context,
                      item,
                      isSelected: selectedIndex.value == index,
                      onTap: () => selectedIndex.value = index,
                    ));
              },
            ),
          ),
        ),
        // 右侧内容区域
        Expanded(
          child: Card(
            margin: const EdgeInsets.fromLTRB(0, 16, 16, 16),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            clipBehavior: Clip.antiAlias,
            child: Obx(() => settingItems[selectedIndex.value].page),
          ),
        ),
      ],
    );
  }

  Widget _buildNarrowScreenLayout(
      BuildContext context, List<SettingItem> settingItems) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: settingItems.length,
      itemBuilder: (context, index) {
        final item = settingItems[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: _buildSettingsCard(context, item),
        );
      },
    );
  }

  Widget _buildSettingsListTile(
    BuildContext context,
    SettingItem item, {
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return ListTile(
      selected: isSelected,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).primaryColor
              : Theme.of(context).primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          item.icon,
          color: isSelected ? Colors.white : Theme.of(context).primaryColor,
        ),
      ),
      title: Text(
        item.title,
        style: TextStyle(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      subtitle: Text(item.subtitle),
      onTap: onTap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  Widget _buildSettingsCard(BuildContext context, SettingItem item) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => Get.toNamed(item.route),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(item.icon, color: Theme.of(context).primaryColor),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.subtitle,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey[600],
                          ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}

// 设置项数据模型
class SettingItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final Widget page;
  final String route;

  SettingItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.page,
    required this.route,
  });
}
