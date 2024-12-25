import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_iwara/app/ui/pages/follows/controllers/follows_controller.dart';
import 'package:i_iwara/app/ui/pages/follows/widgets/followers_list.dart';
import 'package:i_iwara/app/ui/pages/follows/widgets/following_list.dart';
import 'package:i_iwara/i18n/strings.g.dart' as slang;

class FollowsPage extends StatefulWidget {
  final String userId;
  final bool initIsFollowing;

  const FollowsPage({
    super.key,
    required this.userId,
    required this.initIsFollowing,
  });

  @override
  State<FollowsPage> createState() => _FollowsPageState();
}

class _FollowsPageState extends State<FollowsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late FollowsController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(FollowsController(
      userId: widget.userId,
      initIsFollowing: widget.initIsFollowing,
    ), tag: widget.userId);
    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: widget.initIsFollowing ? 0 : 1,
    );
    _tabController.addListener(() {
      controller.refreshCurrentTab(_tabController.index);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    Get.delete<FollowsController>(tag: widget.userId);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = slang.Translations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(t.common.followsAndFans),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: t.common.following),
            Tab(text: t.common.fans),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          FollowingList(
            scrollController: controller.followingListScrollController,
          ),
          FollowersList(
            scrollController: controller.followersListScrollController,
          ),
        ],
      ),
    );
  }
} 