import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routes/app_routes.dart';
import '../ui/pages/author_profile/author_profile_page.dart';
import '../ui/pages/gallery_detail/gallery_detail_page.dart';

class AppService extends GetxService {
  // 默认标题栏高度
  static const double titleBarHeight = 26.0;

  final RxBool _showTitleBar = false.obs; // 是否显示标题栏 [ 全局使用 ]
  final RxBool _showRailNavi = true.obs; // 是否显示侧边栏 [ Home路由下使用 ]
  final RxBool _showBottomNavi = true.obs; // 是否显示底部导航栏 [ Home路由下使用 ]
  final RxInt _currentIndex = 0.obs; // 当前底部/侧边导航栏索引

  static final GlobalKey<ScaffoldState> globalDrawerKey =
      GlobalKey<ScaffoldState>();

  // 获取navigatorKey
  static final GlobalKey<NavigatorState> globalNavigatorKey = Get.key;

  // 获取Home页面的navigatorKey
  static final GlobalKey<NavigatorState> homeNavigatorKey =
      Get.nestedKey(Routes.HOME)!.navigatorKey;

  AppService() {
    if (GetPlatform.isDesktop && !GetPlatform.isWeb) {
      _showTitleBar.value = true;
    }
  }

  bool get showTitleBar => _showTitleBar.value;

  set showTitleBar(bool value) => _showTitleBar.value = value;

  bool get showRailNavi => _showRailNavi.value;

  set showBottomNavi(bool value) => _showBottomNavi.value = value;

  bool get showBottomNavi => _showBottomNavi.value;

  set showRailNavi(bool value) => _showRailNavi.value = value;

  int get currentIndex => _currentIndex.value;

  set currentIndex(int value) => _currentIndex.value = value;

  void openGlobalDrawer() {
    globalDrawerKey.currentState?.openDrawer();
  }

  void closeDrawer() {
    globalDrawerKey.currentState?.openEndDrawer();
  }

  void toggleTitleBar() {
    _showTitleBar.value = !_showTitleBar.value;
  }

  updateIndex(int value) {
    _currentIndex.value = value;
  }
}

class NaviService {
  /// 跳转到作者个人主页
  static void navigateToAuthorProfilePage(String username) {
    AppService.homeNavigatorKey.currentState?.push(PageRouteBuilder(
      settings: RouteSettings(name: Routes.AUTHOR_PROFILE(username)),
      pageBuilder: (context, animation, secondaryAnimation) {
        return AuthorProfilePage(
          username: username,
        );
      },
      transitionDuration: const Duration(milliseconds: 200),
      // 从右到左的原生动画
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      },
    ));
  }

  /// 跳转到图库详情页
  static void navigateToGalleryDetailPage(String id) {
    AppService.homeNavigatorKey.currentState?.push(PageRouteBuilder(
      settings: RouteSettings(name: Routes.GALLERY_DETAIL(id)),
      pageBuilder: (context, animation, secondaryAnimation) {
        return GalleryDetailPage(
          imageModelId: id,
        );
      },
      transitionDuration: const Duration(milliseconds: 200),
      // 从右到左的原生动画
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      },
    ));
  }
}