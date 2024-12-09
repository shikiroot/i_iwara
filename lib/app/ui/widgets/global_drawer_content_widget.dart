import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_iwara/app/services/app_service.dart';

import '../../../common/constants.dart';
import '../../routes/app_routes.dart';
import '../../services/auth_service.dart';
import '../../services/user_service.dart';

class GlobalDrawerColumns extends StatelessWidget {
  GlobalDrawerColumns({super.key});

  final UserService userService = Get.find();
  final AuthService authService = Get.find();
  final AppService appService = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() => _buildHeader(context, appService)),
        Expanded(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              // 历史记录
              _buildMenuItem(Icons.history, '历史记录', () {
                NaviService.navigateToHistoryListPage();
                AppService.switchGlobalDrawer();
              }),
              // 最爱
              _buildMenuItem(Icons.favorite, '最爱', () {
                if (userService.isLogin) {
                  NaviService.navigateToFavoritePage();
                  AppService.switchGlobalDrawer();
                } else {
                  Get.snackbar('错误', '请先登录');
                }
              }),
              // 好友
              _buildMenuItem(Icons.people, '好友', () {
                if (userService.isLogin) {
                  NaviService.navigateToFriendsPage();
                  AppService.switchGlobalDrawer();
                } else {
                  Get.snackbar('错误', '请先登录');
                }
              }),
              // 播放列表
              _buildMenuItem(Icons.playlist_play, '播放列表', () {
                if (userService.isLogin) {
                  NaviService.navigateToPlayListPage(
                      userService.currentUser.value!.id,
                      isMine: true);
                  AppService.switchGlobalDrawer();
                } else {
                  Get.snackbar('错误', '请先登录');
                }
              }),
              // 戒律签到
              _buildMenuItem(Icons.calendar_today, '戒律签到', () {
                NaviService.navigateToSignInPage();
                AppService.switchGlobalDrawer();
              }),
              // 设置
              _buildMenuItem(Icons.settings, '设置', () {
                AppService.switchGlobalDrawer();
                Get.toNamed(Routes.SETTINGS_PAGE);
              }),
              // 关于
              _buildMenuItem(Icons.info, '关于', () {
                userService.fetchUserProfile();
                Get.snackbar('操作', '你点击了关于');
              }),
              // 查看许可
              _buildMenuItem(Icons.code, '查看许可', () {
                AppService.switchGlobalDrawer();
                showLicensePage(
                  context: Get.context!,
                );
              }),
              Obx(() => userService.isLogin
                  ? Column(
                      children: [
                        const Divider(),
                        _buildMenuItem(Icons.exit_to_app, '退出',
                            () => _showLogoutDialog(appService)),
                      ],
                    )
                  : const SizedBox.shrink()),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context, AppService globalDrawerService) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          if (!userService.isLogin) {
            AppService.switchGlobalDrawer();
            Get.toNamed(
              Routes.LOGIN,
            );
          } else {
            AppService.switchGlobalDrawer();
            NaviService.navigateToAuthorProfilePage(
                userService.currentUser.value!.username);
          }
        },
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(
              16, MediaQuery.paddingOf(context).top + 16, 16, 16),
          decoration: BoxDecoration(
            color: Get.theme.primaryColor,
            image: DecorationImage(
              image: const CachedNetworkImageProvider(
                CommonConstants.defaultAvatarUrl,
                headers: {'referer': CommonConstants.iwaraBaseUrl},
              ),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.5),
                BlendMode.darken,
              ),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildAvatar(),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (userService.isLogin &&
                      userService.currentUser.value?.premium == true)
                    ShaderMask(
                      shaderCallback: (bounds) => LinearGradient(
                        colors: [
                          Colors.purple.shade300,
                          Colors.blue.shade300,
                          Colors.pink.shade300,
                        ],
                      ).createShader(bounds),
                      child: Text(
                        userService.currentUser.value!.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  else
                    Text(
                      userService.isLogin
                          ? userService.currentUser.value!.name
                          : '未登录',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  const SizedBox(height: 4),
                  Text(
                    userService.isLogin
                        ? '@${userService.currentUser.value!.username}'
                        : '点击此处登录',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    Widget avatar = MouseRegion(
      cursor: SystemMouseCursors.click,
      child: ClipOval(
        child: CachedNetworkImage(
          imageUrl: userService.userAvatar,
          httpHeaders: const {'referer': CommonConstants.iwaraBaseUrl},
          width: 80,
          height: 80,
          fit: BoxFit.cover,
          placeholder: (context, url) => const CircularProgressIndicator(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );

    if (userService.isLogin && userService.currentUser.value?.premium == true) {
      return MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                Colors.purple.shade200,
                Colors.blue.shade200,
                Colors.pink.shade200,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: avatar,
          ),
        ),
      );
    }

    return avatar;
  }

  Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: ListTile(
        leading: Icon(icon, color: Get.theme.primaryColor),
        title: Text(title, style: const TextStyle(fontSize: 16)),
        onTap: onTap,
      ),
    );
  }

  void _showLogoutDialog(AppService globalDrawerService) {
    AppService.switchGlobalDrawer();
    showDialog(
      context: Get.context!,
      builder: (context) => LogoutDialog(userService: userService),
    );
  }
}

class LogoutDialog extends StatelessWidget {
  final UserService userService;

  const LogoutDialog({required this.userService, super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('退出登录'),
      content: const Text('你确定要退出登录吗？'),
      actions: [
        TextButton(
          child: const Text('取消'),
          onPressed: () => Navigator.pop(context),
        ),
        ElevatedButton(
          child: const Text('确定'),
          onPressed: () async {
            Navigator.pop(context);
            try {
              await userService.logout();
              Get.snackbar('操作', '你已退出登录');
            } catch (e) {
              Get.snackbar('错误', '退出登录失败: $e');
            }
          },
        ),
      ],
    );
  }
}
