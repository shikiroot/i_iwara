import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:i_iwara/utils/logger_utils.dart';

import '../../../routes/app_routes.dart';
import '../../../services/app_service.dart';
import '../popular_media_list/popular_gallery_list_page.dart';
import '../popular_media_list/popular_video_list_page.dart';
import '../subscriptions/subscriptions_page.dart';

/// 侧边栏、底部导航栏、主要内容
class HomeNavigationLayout extends StatelessWidget {
  HomeNavigationLayout({super.key});

  final AppService appService = Get.find<AppService>();
  final HomeNavigatorObserver homeNavigatorObserver = HomeNavigatorObserver();

  @override
  Widget build(BuildContext context) {
    return _NaviPopScope(
      action: () {
        // TODO 还需要完整的验证Pop逻辑
        if (AppService.homeNavigatorKey.currentState!.canPop()) {
          AppService.homeNavigatorKey.currentState!.pop();
        } else {
          SystemNavigator.pop();
        }

        // AppService.tryPop();
      },
      popGesture: GetPlatform.isIOS,
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth > 600;
            return Row(
              children: [
                // 侧边栏
                Obx(() {
                  if (!appService.showRailNavi) return const SizedBox.shrink();
                  if (!isWide) return const SizedBox.shrink();

                  return NavigationRail(
                    labelType: NavigationRailLabelType.all,
                    selectedIndex: appService.currentIndex,
                    onDestinationSelected: (value) {
                      if (appService.currentIndex == value) return;
                      appService.currentIndex = value;
                      final routes = [
                        Routes.POPULAR_VIDEOS,
                        Routes.GALLERY,
                        Routes.SUBSCRIPTIONS,
                      ];
                      AppService.homeNavigatorKey.currentState!
                          .pushNamedAndRemoveUntil(
                        routes[value],
                        (route) => false,
                      );
                    },
                    destinations: const [
                      NavigationRailDestination(
                        icon: Icon(Icons.video_library),
                        label: Text('热门视频'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.photo),
                        label: Text('图库'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.subscriptions),
                        label: Text('订阅'),
                      ),
                    ],
                  );
                }),
                // 主要内容
                Expanded(
                  child: Scaffold(
                    body: Navigator(
                      key: AppService.homeNavigatorKey,
                      observers: [
                        homeNavigatorObserver,
                      ],
                      onGenerateRoute: (RouteSettings settings) {
                        WidgetBuilder builder;
                        Route<dynamic> route;

                        switch (settings.name) {
                          case Routes.ROOT:
                          case Routes.POPULAR_VIDEOS:
                            builder = (BuildContext context) =>
                                const PopularVideoListPage();
                            route = PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      builder(context),
                              settings: settings,
                              transitionDuration: Duration.zero,
                            );
                            break;
                          case Routes.GALLERY:
                            builder = (BuildContext context) =>
                                const PopularGalleryListPage();
                            route = PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      builder(context),
                              settings: settings,
                              transitionDuration: Duration.zero,
                            );
                            break;
                          case Routes.SUBSCRIPTIONS:
                            builder = (BuildContext context) =>
                                const SubscriptionsPage();
                            route = PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      builder(context),
                              settings: settings,
                              transitionDuration: Duration.zero,
                            );
                            break;
                          default:
                            builder = (BuildContext context) =>
                                const Center(child: Text('404'));
                            route = PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      builder(context),
                              settings: settings,
                              transitionDuration: Duration.zero,
                            );
                        }

                        return route;
                      },
                    ),
                    // 底部导航栏
                    bottomNavigationBar: Obx(() {
                      if (!appService.showBottomNavi) {
                        return const SizedBox.shrink();
                      }
                      if (isWide) return const SizedBox.shrink();

                      final index = appService.currentIndex;
                      final routes = [
                        Routes.POPULAR_VIDEOS,
                        Routes.GALLERY,
                        Routes.SUBSCRIPTIONS,
                      ];

                      return BottomNavigationBar(
                        currentIndex: index,
                        onTap: (value) {
                          appService.currentIndex = value;
                          AppService.homeNavigatorKey.currentState
                              ?.pushNamedAndRemoveUntil(
                            routes[value],
                            (route) => false,
                          );
                        },
                        items: const [
                          BottomNavigationBarItem(
                            icon: Icon(Icons.video_library),
                            label: '热门视频',
                          ),
                          BottomNavigationBarItem(
                            icon: Icon(Icons.photo),
                            label: '图库',
                          ),
                          BottomNavigationBarItem(
                            icon: Icon(Icons.subscriptions),
                            label: '订阅',
                          ),
                        ],
                      );
                    }),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

class HomeNavigatorObserver extends NavigatorObserver {
  final AppService appService = Get.find<AppService>();
  var routes = Queue<Route>();

  HomeNavigatorObserver() {
    print('[导航栏] 初始化');
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    print('[导航栏] didPop ${route.settings.name}');
    routes.removeLast();
    _tryHideBottomNavi();
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    print(
        '[导航栏] didPush ${route.settings.name}， 当前的路由数量: ${routes.length}, 当前的routes: $routes');
    routes.addLast(route);
    _tryHideBottomNavi();
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    print('[导航栏] didRemove ${route.settings.name}');
    routes.remove(route);
    _tryHideBottomNavi();
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    print(
        '[导航栏] didReplace ${oldRoute?.settings.name} -> ${newRoute?.settings.name}');
    routes.remove(oldRoute);
    if (newRoute != null) {
      routes.add(newRoute);
    }
    _tryHideBottomNavi();
  }

  void _tryHideBottomNavi() {
    print('[导航栏] 当前的routes.length: ${routes.length}');
    if (routes.length > 1 && appService.showBottomNavi) {
      appService.showBottomNavi = false;
    } else if (routes.length <= 1 && !appService.showBottomNavi) {
      appService.showBottomNavi = true;
    }
  }
}

class _NaviPopScope extends StatelessWidget {
  const _NaviPopScope(
      {required this.child, this.popGesture = false, required this.action});

  final Widget child;
  final bool popGesture;
  final VoidCallback action;

  static bool panStartAtEdge = false;

  @override
  Widget build(BuildContext context) {
    Widget res = GetPlatform.isIOS
        ? child
        : PopScope(
            canPop: GetPlatform.isAndroid ? false : true,
            onPopInvokedWithResult: (value, result) {
              LogUtils.i('[顶层Popscope结果, value: $value, result: $result]',
                  'PopScope');
              action();
            },
            child: child,
          );
    if (popGesture) {
      res = GestureDetector(
          onPanStart: (details) {
            if (details.globalPosition.dx < 64) {
              panStartAtEdge = true;
            }
          },
          onPanEnd: (details) {
            if (details.velocity.pixelsPerSecond.dx < 0 ||
                details.velocity.pixelsPerSecond.dx > 0) {
              if (panStartAtEdge) {
                action();
              }
            }
            panStartAtEdge = false;
          },
          child: res);
    }
    return res;
  }
}
