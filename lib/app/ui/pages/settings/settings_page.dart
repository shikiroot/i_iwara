import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/proxy/proxy_util.dart';
import '../../../routes/app_routes.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 获取屏幕宽度
    final double screenWidth = MediaQuery.of(context).size.width;
    // 定义内容的最大宽度
    const double maxContentWidth = 1000;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '设置',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 2,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth:
              screenWidth > maxContentWidth ? maxContentWidth : screenWidth,
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                // 定义在不同屏幕宽度下的列数
                int columns = 1;
                if (constraints.maxWidth > 1200) {
                  columns = 3;
                } else if (constraints.maxWidth > 800) {
                  columns = 2;
                }

                // 生成设置项列表
                List<Widget> settingsTiles = [
                  if (ProxyUtil.isSupportedPlatform())
                    _buildSettingsTile(
                      context,
                      '网络代理设置',
                      '配置您的代理服务器',
                      Icons.wifi,
                          () => Get.toNamed(Routes.PROXY_SETTINGS_PAGE),
                    ),
                  _buildSettingsTile(
                    context,
                    '播放器设置',
                    '自定义您的播放体验',
                    Icons.play_circle_outline,
                        () => Get.toNamed(Routes.PLAYER_SETTINGS_PAGE),
                  ),
                  _buildSettingsTile(
                    context,
                    '主题设置',
                    '选择您喜欢的应用外观',
                    Icons.color_lens,
                        () => Get.toNamed(Routes.THEME_SETTINGS_PAGE),
                  ),
                  // 您可以在这里添加更多设置项
                ];

                if (columns == 1) {
                  // 小屏幕：使用垂直列表
                  return Column(
                    children: settingsTiles
                        .map((tile) => Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: tile,
                    ))
                        .toList(),
                  );
                } else {
                  // 大屏幕：使用网格布局
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: columns,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 4, // 根据需要调整比例
                    ),
                    itemCount: settingsTiles.length,
                    itemBuilder: (context, index) {
                      return settingsTiles[index];
                    },
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsTile(BuildContext context, String title, String subtitle,
      IconData icon, VoidCallback onTap) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      clipBehavior: Clip.antiAlias, // 确保圆角效果
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).cardColor,
                Theme.of(context).cardColor.withOpacity(0.95),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child:
                    Icon(icon, color: Theme.of(context).primaryColor, size: 28),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey[600],
                            fontSize: 14,
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
