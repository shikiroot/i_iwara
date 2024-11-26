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
import 'package:i_iwara/app/ui/pages/sign_in/sing_in_page.dart';
import 'package:i_iwara/app/ui/widgets/global_drawer_content_widget.dart';
import 'package:i_iwara/app/ui/widgets/window_layout_widget.dart';
import 'package:i_iwara/utils/logger_utils.dart';

import '../utils/proxy/proxy_util.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    var brightness = Theme.of(context).brightness;
    SystemUiOverlayStyle systemUiStyle;
    if (brightness == Brightness.light) {
      systemUiStyle = SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
      );
    } else {
      systemUiStyle = SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
      );
    }

    SystemChrome.setSystemUIOverlayStyle(systemUiStyle);

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
        GetPage(
          name: Routes.SIGN_IN,
          page: () => const SignInPage(),
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

class PrivacyOverlay extends StatelessWidget {
  const PrivacyOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.white, // 白色背景
        child: const Center(
          child: Text(
            '隐私内容，不予展示',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class MyAppLayout extends StatefulWidget {
  final Widget child;

  const MyAppLayout({super.key, required this.child});

  @override
  State<MyAppLayout> createState() => _MyAppLayoutState();
}

class _MyAppLayoutState extends State<MyAppLayout> with WidgetsBindingObserver {
  bool _showPrivacyOverlay = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        LogUtils.d('应用resumed', 'AppLifecycleState');
        setState(() {
          _showPrivacyOverlay = false;
        });
        break;
      case AppLifecycleState.inactive:
        LogUtils.d('应用inactive', 'AppLifecycleState');
        setState(() {
          _showPrivacyOverlay = true;
        });
        break;
      case AppLifecycleState.paused:
        LogUtils.d('应用paused', 'AppLifecycleState');
        break;
      case AppLifecycleState.hidden:
        LogUtils.d('应用hidden', 'AppLifecycleState');
        setState(() {
          _showPrivacyOverlay = true;
        });
        break;
      case AppLifecycleState.detached:
        LogUtils.d('应用detached', 'AppLifecycleState');
        break;
      default:
        LogUtils.d('应用default', 'AppLifecycleState');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: _shortCutsWrapper(
              context, _windowTitleBarFrame(context, widget.child)),
        ),
        if (_showPrivacyOverlay) const PrivacyOverlay(),
      ],
    );
  }

  Widget _shortCutsWrapper(BuildContext context, Widget child) {
    return Shortcuts(
      shortcuts: {
        LogicalKeySet(LogicalKeyboardKey.escape): VoidCallbackIntent(
          () {
            AppService.tryPop();
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
