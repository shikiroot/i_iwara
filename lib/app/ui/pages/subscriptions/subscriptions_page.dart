import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_iwara/app/routes/app_routes.dart';
import 'package:i_iwara/app/services/user_preference_service.dart';
import 'package:i_iwara/app/services/user_service.dart';
import 'package:i_iwara/app/ui/pages/subscriptions/controllers/subscription_image_controller.dart';
import 'package:i_iwara/app/ui/pages/subscriptions/controllers/subscription_video_controller.dart';
import 'package:i_iwara/app/ui/pages/subscriptions/widgets/subscription_image_list.dart';
import 'package:i_iwara/app/ui/pages/subscriptions/widgets/subscription_select_list_widget.dart';
import 'package:i_iwara/app/ui/pages/subscriptions/widgets/subscription_video_list.dart';
import 'package:i_iwara/i18n/strings.g.dart' as slang;
import '../../../models/dto/user_dto.dart';
import '../../../services/app_service.dart';
import '../../widgets/top_padding_height_widget.dart';
import 'package:i_iwara/app/ui/pages/subscriptions/controllers/subscription_post_controller.dart';
import 'package:i_iwara/app/ui/pages/subscriptions/widgets/subscription_post_list.dart';
import 'package:i_iwara/app/ui/widgets/avatar_widget.dart';
import 'package:i_iwara/common/constants.dart';

class SubscriptionsPage extends StatefulWidget {
  const SubscriptionsPage({super.key});

  @override
  _SubscriptionsPageState createState() => _SubscriptionsPageState();
}

class _SubscriptionsPageState extends State<SubscriptionsPage>
    with TickerProviderStateMixin {
  final UserService userService = Get.find<UserService>();
  final UserPreferenceService userPreferenceService =
      Get.find<UserPreferenceService>();
  late SubscriptionVideoController videoController;
  late SubscriptionImageController imageController;
  late SubscriptionPostController postController;

  late TabController _tabController;
  String selectedId = '';

  final ScrollController _scrollController = ScrollController();
  bool _showBackToTop = false;
  late AnimationController _refreshIconController;

  @override
  void initState() {
    super.initState();
    videoController = Get.put(SubscriptionVideoController());
    imageController = Get.put(SubscriptionImageController());
    postController = Get.put(SubscriptionPostController());
    _tabController = TabController(length: 3, vsync: this);
    _scrollController.addListener(_scrollListener);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {});
      }
    });
    _refreshIconController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
  }

  void _scrollListener() {
    // 返回顶部按钮逻辑
    bool shouldShow =
        _scrollController.hasClients && _scrollController.offset > 200;
    if (shouldShow != _showBackToTop) {
      setState(() {
        _showBackToTop = shouldShow;
      });
    }

    // 检查是否需要加载更多
    if (!_scrollController.hasClients ||
        _scrollController.position.outOfRange ||
        _scrollController.position.pixels <
            _scrollController.position.maxScrollExtent - 500) {
      return;
    }

    // 直接触发加载
    if (_tabController.index == 0) {
      videoController.loadVideos();
    } else if (_tabController.index == 1) {
      imageController.loadImages();
    } else {
      postController.loadPosts();
    }
  }

  void _onIdSelected(String id) {
    selectedId = id;
    setState(() {});
    videoController.updateSelectedUserId(id);
    imageController.updateSelectedUserId(id);
    postController.updateSelectedUserId(id);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    Get.delete<SubscriptionVideoController>();
    Get.delete<SubscriptionImageController>();
    Get.delete<SubscriptionPostController>();
    _refreshIconController.dispose();
    super.dispose();
  }

  void _scrollToTop() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (userService.isLogin) {
        return _buildLoggedInView(context);
      } else {
        return _buildNotLoggedIn(context);
      }
    });
  }

  Widget _buildContent(BuildContext context) {
    final t = slang.Translations.of(context);
    return NestedScrollView(
      controller: _scrollController,
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        SliverToBoxAdapter(
          child: Column(
            children: [
              TopPaddingHeightWidget(),
              Row(
                children: [
                  Obx(() {
                    if (userService.isLogin) {
                      return IconButton(
                        icon: AvatarWidget(
                          avatarUrl: userService.userAvatar,
                          radius: 14,
                          defaultAvatarUrl: CommonConstants.defaultAvatarUrl,
                          isPremium: userService.currentUser.value?.premium ?? false,
                          isAdmin: userService.currentUser.value?.isAdmin ?? false,
                        ),
                        onPressed: () {
                          AppService.switchGlobalDrawer();
                        },
                      );
                    } else {
                      return IconButton(
                        icon: const Icon(Icons.account_circle),
                        onPressed: () {
                          AppService.switchGlobalDrawer();
                        },
                      );
                    }
                  }),
                  Expanded(
                    child: Text(
                      t.common.subscriptions,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Obx(() {
                RxSet<UserDTO> likedUsers = userPreferenceService.likedUsers;
                List<SubscriptionSelectItem> selectionList = likedUsers
                    .map((userDto) => SubscriptionSelectItem(
                          id: userDto.id,
                          label: userDto.name,
                          avatarUrl: userDto.avatarUrl,
                        ))
                    .toList();
                return SubscriptionSelectList(
                  selectionList: selectionList,
                  selectedId: selectedId,
                  onIdSelected: _onIdSelected,
                );
              }),
              Row(
                children: [
                  TabBar(
                    isScrollable: true,
                    physics: const NeverScrollableScrollPhysics(),
                    overlayColor: WidgetStateProperty.all(Colors.transparent),
                    tabAlignment: TabAlignment.start,
                    dividerColor: Colors.transparent,
                    controller: _tabController,
                    labelStyle: const TextStyle(
                      fontSize: 14, // 设置你想要的字体大小
                      fontWeight: FontWeight.w500, // 设置字重
                    ),
                    unselectedLabelStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    tabs: [
                      Tab(text: t.common.video),
                      Tab(text: t.common.gallery),
                      Tab(text: t.common.post),
                    ],
                  ),
                  const Spacer(),
                  _buildRefreshButton(),
                  const SizedBox(width: 16),
                ],
              )
            ],
          ),
        ),
      ],
      body: TabBarView(
        controller: _tabController,
        children: [
          SubscriptionVideoList(controller: videoController),
          SubscriptionImageList(controller: imageController),
          SubscriptionPostList(controller: postController),
        ],
      ),
    );
  }

  Widget _buildLoggedInView(BuildContext context) {
    return Scaffold(
      body: _buildContent(context),
      floatingActionButton: AnimatedSlide(
        duration: const Duration(milliseconds: 200),
        offset: _showBackToTop ? Offset.zero : const Offset(0, 2),
        child: AnimatedOpacity(
          opacity: _showBackToTop ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 200),
          child: FloatingActionButton.small(
            onPressed: _scrollToTop,
            child: const Icon(Icons.arrow_upward),
          ),
        ),
      ),
    );
  }

  Widget _buildNotLoggedIn(BuildContext context) {
    final t = slang.Translations.of(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TopPaddingHeightWidget(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.lock_outline,
                        size: 80,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: 20),
                      Text(
                        t.signIn.pleaseLoginFirst,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        t.subscriptions.pleaseLoginFirstToViewYourSubscriptions,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () => Get.toNamed(Routes.LOGIN),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 15,
                          ),
                          minimumSize: const Size(200, 0),
                        ),
                        child: Text(
                          t.auth.login,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRefreshButton() {
    return Obx(() {
      if (_tabController.index == 0) {
        if (videoController.isLoading.value) {
          _refreshIconController.repeat();
        } else {
          _refreshIconController.stop();
          _refreshIconController.reset();
        }
      } else if (_tabController.index == 1) {
        if (imageController.isLoading.value) {
          _refreshIconController.repeat();
        } else {
          _refreshIconController.stop();
          _refreshIconController.reset();
        }
      } else {
        if (postController.isLoading.value) {
          _refreshIconController.repeat();
        } else {
          _refreshIconController.stop();
          _refreshIconController.reset();
        }
      }

      return IconButton(
        icon: RotationTransition(
          turns: _refreshIconController,
          child: const Icon(Icons.refresh),
        ),
        onPressed: () {
          if (_tabController.index == 0) {
            videoController.loadVideos(refresh: true);
          } else if (_tabController.index == 1) {
            imageController.loadImages(refresh: true);
          } else {
            postController.loadPosts(refresh: true);
          }
        },
      );
    });
  }
}
