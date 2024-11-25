import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_iwara/app/services/user_service.dart';
import 'package:i_iwara/app/ui/pages/gallery_detail/gallery_detail_page.dart';
import 'package:i_iwara/utils/widget_extensions.dart';

import '../../../services/app_service.dart';
import '../../widgets/title_bar_height_widget.dart';

class SubscriptionsPage extends StatefulWidget {
  const SubscriptionsPage({super.key});

  @override
  _SubscriptionsPageState createState() => _SubscriptionsPageState();
}

class _SubscriptionsPageState extends State<SubscriptionsPage> {
  final UserService userService = Get.find<UserService>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (userService.isLogin) {
        return _buildLoggedInView();
      } else {
        return _buildNotLoggedIn();
      }
    });
  }

  // 已登录时显示的视图
  Widget _buildLoggedInView() {
    return Scaffold(
      //SliverAppBar
      body: ExtendedNestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              TopPaddingHeightWidget().toSliver(),
              Row(
                children: [
                  // 用户头像
                  IconButton(
                    icon: const Icon(Icons.account_circle),
                    onPressed: () {
                      AppService.homeNavigatorKey.currentState!.push(
                        MaterialPageRoute(builder: (context) {
                          return const Center(child: Text('用户中心'));
                        }),
                      );
                    },
                  ),
                  // 搜索框
                  const Text('订阅')
                ],
              ).toSliver()
            ];
          },
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 20,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('订阅 $index'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 未登录时显示的视图，引导用户登录
  Widget _buildNotLoggedIn() {
    return Scaffold(
      body: Column(
        children: [
          TopPaddingHeightWidget(),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.lock_outline,
                    size: 80,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    '您尚未登录',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '请登录以查看您的订阅内容。',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      // 导航到登录页面
                      Get.toNamed('/login');
                    },
                    child: const Text('前往登录'),
                    style: ElevatedButton.styleFrom(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
