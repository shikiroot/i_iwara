import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:i_iwara/app/routes/app_routes.dart';
import 'package:i_iwara/app/services/app_service.dart';
import 'package:i_iwara/app/ui/pages/home/home_navigation_layout.dart';
import 'package:i_iwara/app/ui/pages/login/login_page.dart';
import 'package:i_iwara/app/ui/pages/settings/player_settings_page.dart';
import 'package:i_iwara/app/ui/pages/settings/proxy_settings_page.dart';
import 'package:i_iwara/app/ui/pages/settings/settings_page.dart';
import 'package:i_iwara/app/ui/pages/settings/theme_settings_page.dart';
import 'package:i_iwara/app/ui/widgets/global_drawer_content_widget.dart';
import 'package:i_iwara/app/ui/widgets/window_layout_widget.dart';

import '../utils/proxy/proxy_util.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "❤️ iwara",
      getPages: [
        GetPage(
            name: Routes.HOME,
            page: () => HomeNavigationLayout(),
        ),
        GetPage(
            name: Routes.SETTINGS_PAGE,
            page: () => const SettingsPage(),
            transition: Transition.rightToLeft),
        GetPage(
            name: Routes.PLAYER_SETTINGS_PAGE,
            page: () => const PlayerSettingsPage(),
            transition: Transition.rightToLeft),
        if (ProxyUtil.isSupportedPlatform())
          GetPage(
              name: Routes.PROXY_SETTINGS_PAGE,
              page: () => const ProxySettingsPage(),
              transition: Transition.rightToLeft),
        GetPage(
            name: Routes.THEME_SETTINGS_PAGE,
            page: () => const ThemeSettingsPage(),
            transition: Transition.rightToLeft),
        GetPage(
          name: Routes.LOGIN,
          page: () => const LoginPage(),
          transition: Transition.cupertino,
        ),
      ],
      initialRoute: Routes.HOME,
      builder: (context, child) {
        if (null == child) {
          return const SizedBox.shrink();
        }
        return MyAppLayout(child: child);
      },
    );
  }
}

class MyAppLayout extends StatelessWidget {
  final Widget child;

  const MyAppLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _shortCutsWrapper(context, _windowTitleBarFrame(context, child)),
    );
  }

  Widget _shortCutsWrapper(BuildContext context, Widget child) {
    return Shortcuts(
      shortcuts: {
        LogicalKeySet(LogicalKeyboardKey.escape): VoidCallbackIntent(
          () {
            if (AppService.globalDrawerKey.currentState!.isDrawerOpen) {
              AppService.globalDrawerKey.currentState!.openEndDrawer();
            } else {
              GetDelegate? homeDele = Get.nestedKey(Routes.HOME);
              GetDelegate? rootDele = Get.nestedKey(null);

              if (homeDele?.canBack ?? false) {
                print('[HomeDelegate 的返回]');
                homeDele?.back();
              } else if (homeDele?.navigatorKey.currentState?.canPop() ??
                  false) {
                print('[HomeDelegate 的naavigatorKey.currentState?.pop()返回]');
                homeDele?.navigatorKey.currentState?.pop();
              } else if (rootDele?.canBack ?? false) {
                print('[RootDelegate 的返回]');
                rootDele?.back();
              } else if (Get.isDialogOpen ?? false) {
                Get.back();
              } else {
                print('[Get.back()返回]');
                Get.back();
              }
            }
          },
        ),
      },
      child: child,
    );
  }

  Widget _windowTitleBarFrame(BuildContext context, Widget child) {
    return Scaffold(
        key: AppService.globalDrawerKey,
        drawer: _buildDrawer(),
        body: WindowTitleBarLayout(child));
  }

  Widget _buildDrawer() {
    return Drawer(child: GlobalDrawerColumns());
  }
}
