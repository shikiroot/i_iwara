import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:i_iwara/utils/logger_utils.dart';

import '../routes/app_routes.dart';
import '../ui/pages/author_profile/author_profile_page.dart';
import '../ui/pages/gallery_detail/gallery_detail_page.dart';
import '../ui/pages/search/search_result.dart';

class AppService extends GetxService {
  // 默认标题栏高度
  static const double titleBarHeight = 26.0;

  final RxBool _showTitleBar = false.obs; // 是否显示标题栏 [ 全局使用 ]
  final RxBool _showRailNavi = true.obs; // 是否显示侧边栏 [ Home路由下使用 ]
  final RxBool _showBottomNavi = true.obs; // 是否显示底部导航栏 [ Home路由下使用 ]
  final RxInt _currentIndex = 0.obs; // 当前底部/侧边导航栏索引

  static final GlobalKey<ScaffoldState> globalDrawerKey =
      GlobalKey<ScaffoldState>();

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

  static void switchGlobalDrawer() {

    if (globalDrawerKey.currentState!.isDrawerOpen) {
      globalDrawerKey.currentState!.openEndDrawer();
      LogUtils.d('关闭Drawer', 'AppService');
    } else {
      globalDrawerKey.currentState!.openDrawer();
      LogUtils.d('打开Drawer', 'AppService');
    }
  }

  void toggleTitleBar() {
    _showTitleBar.value = !_showTitleBar.value;
  }

  updateIndex(int value) {
    _currentIndex.value = value;
  }

  static void tryPop() {
    LogUtils.d('tryPop', 'AppService');
    if (AppService.globalDrawerKey.currentState!.isDrawerOpen) {
      AppService.globalDrawerKey.currentState!.openEndDrawer();
      LogUtils.d('关闭Drawer', 'AppService');
    } else {
      // 先判断是否有打开的对话框或底部表单
      if (Get.isDialogOpen ?? false) {
        Get.closeAllDialogs();
        LogUtils.d('关闭Get.isDialogOpen', 'AppService');
      } else if (Get.isBottomSheetOpen ?? false) {
        Get.closeAllBottomSheets();
        LogUtils.d('关闭Get.isBottomSheetOpen', 'AppService');
      } else {
        GetDelegate? homeDele = Get.nestedKey(Routes.HOME);
        GetDelegate? rootDele = Get.nestedKey(null);

        if (homeDele?.canBack ?? false) {
          homeDele?.back();
          LogUtils.d('关闭homeDele?.canBack', 'AppService');
        } else if (homeDele?.navigatorKey.currentState?.canPop() ?? false) {
          homeDele?.navigatorKey.currentState?.pop();
          LogUtils.d(
              '关闭homeDele?.navigatorKey.currentState?.canPop()', 'AppService');
        } else if (rootDele?.canBack ?? false) {
          rootDele?.back();
          LogUtils.d('关闭rootDele?.canBack', 'AppService');
        } else {
          // 退出应用
          SystemNavigator.pop();
          LogUtils.d('关闭Get.back()', 'AppService');
        }
      }
    }
  }

  void hideSystemUI({hideTitleBar = true, hideRailNavi = true}) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    showTitleBar = !hideTitleBar;
    showRailNavi = !hideRailNavi;
  }

  void showSystemUI() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    showTitleBar = true;
    showRailNavi = true;
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

  // SignInPage()
  static void navigateToSignInPage() {
    Get.toNamed(Routes.SIGN_IN);
  }

  static void toSearchPage({required String searchInfo, required String segment}) {
    AppService.homeNavigatorKey.currentState?.push(
      PageRouteBuilder(
        settings: const RouteSettings(name: Routes.SEARCH_RESULT),
        pageBuilder: (context, animation, secondaryAnimation) {
          return SearchResult();
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
      )
    );
  }
}
