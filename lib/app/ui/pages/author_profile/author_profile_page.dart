import 'package:cached_network_image/cached_network_image.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_iwara/app/models/dto/user_dto.dart';
import 'package:i_iwara/app/services/user_preference_service.dart';
import 'package:i_iwara/app/ui/pages/author_profile/widgets/author_profile_skeleton_widget.dart';
import 'package:i_iwara/app/ui/pages/author_profile/widgets/profile_image_model_tab_list_widget.dart';
import 'package:i_iwara/app/ui/pages/author_profile/widgets/profile_video_tab_list_widget.dart';
import 'package:i_iwara/app/ui/pages/author_profile/widgets/profile_playlist_tab_list_widget.dart';
import 'package:i_iwara/app/ui/pages/comment/widgets/comment_input_dialog.dart';
import 'package:i_iwara/app/ui/widgets/top_padding_height_widget.dart';
import 'package:i_iwara/utils/date_time_extension.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../common/constants.dart';
import '../../../services/user_service.dart';
import '../../widgets/sliding_card_widget.dart';
import '../comment/widgets/comment_entry_area_widget.dart';
import '../comment/widgets/comment_section_widget.dart';
import '../popular_media_list/widgets/media_description_widget.dart';
import 'controllers/authro_profile_controller.dart';

class AuthorProfilePage extends StatefulWidget {
  final String username;
  final String uniqueTag = DateTime.now().millisecondsSinceEpoch.toString();

  AuthorProfilePage({super.key, required this.username});

  @override
  _AuthorProfilePageState createState() => _AuthorProfilePageState();
}

class _AuthorProfilePageState extends State<AuthorProfilePage>
    with TickerProviderStateMixin {
  late final AuthorProfileController profileController;
  final UserService userService = Get.find<UserService>();
  final UserPreferenceService userPreferenceService =
      Get.find<UserPreferenceService>();
  late TabController primaryTC;
  late TabController videoSecondaryTC;
  late TabController imageSecondaryTC;
  late TabController playlistSecondaryTC;
  late String username;

  final GlobalKey<ExtendedNestedScrollViewState> _key =
      GlobalKey<ExtendedNestedScrollViewState>();
  late String uniqueTag;
  late ScrollController _tabBarScrollController;

  @override
  void initState() {
    super.initState();
    uniqueTag = widget.uniqueTag;
    username = widget.username;
    profileController =
        Get.put(AuthorProfileController(username: username), tag: uniqueTag);
    primaryTC = TabController(length: 3, vsync: this);
    videoSecondaryTC = TabController(length: 5, vsync: this);
    imageSecondaryTC = TabController(length: 5, vsync: this);
    playlistSecondaryTC = TabController(length: 5, vsync: this);
    _tabBarScrollController = ScrollController();
  }

  @override
  void dispose() {
    profileController.dispose();
    primaryTC.dispose();
    videoSecondaryTC.dispose();
    imageSecondaryTC.dispose();
    playlistSecondaryTC.dispose();
    _tabBarScrollController.dispose();
    super.dispose();
  }

  void _handleScroll(double delta) {
    if (_tabBarScrollController.hasClients) {
      final double newOffset = _tabBarScrollController.offset + delta;
      if (newOffset < 0) {
        _tabBarScrollController.jumpTo(0);
      } else if (newOffset > _tabBarScrollController.position.maxScrollExtent) {
        _tabBarScrollController.jumpTo(_tabBarScrollController.position.maxScrollExtent);
      } else {
        _tabBarScrollController.jumpTo(newOffset);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (username.isEmpty) {
      return const Center(child: Text('用户名不能为空'));
    }

    return Obx(() {
      if (profileController.errorWidget.value != null) {
        return _buildErrorWidget();
      } else if (profileController.isProfileLoading.value) {
        return const AuthorProfileSkeleton();
      } else if (!profileController.isProfileLoading.value &&
          profileController.author.value == null) {
        return const Center(child: Text('未找到用户'));
      }
      
      return _buildMainContent();
    });
  }

  Widget _buildMainContent() {
    // 判断是否为宽屏 (>= 800px)
    bool isWideScreen = MediaQuery.of(context).size.width >= 800;

    if (!isWideScreen) {
      return Stack(
        children: [
          Scaffold(
            floatingActionButton: _buildScrollToTopButton(),
            body: ExtendedNestedScrollView(
              key: _key,
              headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) => 
                  _buildHeaderSliver(context, innerBoxIsScrolled),
              onlyOneScrollInBody: true,
              pinnedHeaderSliverHeightBuilder: () => _calculatePinnedHeaderHeight(),
              body: _buildTabBarView(),
            ),
          ),
          _buildCommentSheet(),
        ],
      );
    }

    // 宽屏布局 - 移除了 floatingActionButton
    return Stack(
      children: [
        Scaffold(
          body: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 左侧区域 - 基本信息
              Container(
                width: 400, // 固定宽度
                child: CustomScrollView(
                  slivers: _buildHeaderSliver(context, false),
                ),
              ),
              // 分隔线
              const VerticalDivider(width: 1),
              // 右侧区域 - Tab内容
              Expanded(
                child: _buildTabBarView(),
              ),
            ],
          ),
        ),
        _buildCommentSheet(),
      ],
    );
  }

  Widget _buildErrorWidget() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('用户资料'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 16),
          profileController.errorWidget.value!,
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              profileController.fetchAuthorDescription();
            },
            child: const Text('重试'),
          )
        ],
      ),
    );
  }

  Widget _buildScrollToTopButton() {
    return FloatingActionButton(
      child: const Icon(Icons.file_upload),
      onPressed: () {
        _key.currentState?.outerController.animateTo(
          0.0,
          duration: const Duration(seconds: 1),
          curve: Curves.easeIn,
        );
      },
    );
  }

  List<Widget> _buildHeaderSliver(BuildContext context, bool innerBoxIsScrolled) {
    return <Widget>[
      // header背景图
      SliverAppBar(
        expandedHeight: context.width * 43 / 150 > 300
            ? 300
            : context.width * 43 / 150,
        pinned: true,
        flexibleSpace: FlexibleSpaceBar(
            background: CachedNetworkImage(
          imageUrl: profileController.headerBackgroundUrl.value ??
              CommonConstants.defaultProfileHeaderUrl,
          fit: BoxFit.cover,
        )),
      ),
      // 用户信息
      SliverToBoxAdapter(
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Obx(() {
                  bool isPremium =
                      profileController.author.value?.premium ?? false;
                  // 头像
                  Widget avatar = CircleAvatar(
                    radius: 40,
                    backgroundImage: CachedNetworkImageProvider(
                      profileController.author.value?.avatar?.avatarUrl ??
                          CommonConstants.defaultAvatarUrl,
                      headers: const {
                        'referer': CommonConstants.iwaraBaseUrl,
                      },
                    ),
                  );

                  if (isPremium) {
                    return Container(
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
                    );
                  }

                  return avatar;
                }),
                const SizedBox(width: 16),
                // 用户名、粉丝数、关注数
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          // 修改名称样式，使用主题色并加粗
                          Obx(() {
                            bool isPremium = profileController.author.value?.premium == true;
                            if (!isPremium) {
                              return SelectableText(
                                profileController.author.value?.name ?? '',
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              );
                            }

                            return ShaderMask(
                              shaderCallback: (bounds) => LinearGradient(
                                colors: [
                                  Colors.purple.shade300,
                                  Colors.blue.shade300,
                                  Colors.pink.shade300,
                                ],
                              ).createShader(bounds),
                              child: SelectableText(
                                profileController.author.value?.name ?? '',
                                style: const TextStyle(
                                  fontSize: 32,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          }),
                          SizedBox(width: 8),
                          Obx(() {
                            bool isPremium = profileController
                                    .author.value?.premium == true;
                            return isPremium
                                ? Tooltip(
                                    triggerMode: TooltipTriggerMode.tap,
                                    message: '高级会员',
                                    preferBelow: false,
                                    child: Icon(
                                      Icons.verified,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary,
                                    ),
                                  )
                                : SizedBox.shrink();
                          }),
                          Obx(() {
                            // 是粉丝
                            bool isFollower = profileController
                                    .author.value?.followedBy ?? false;
                            return isFollower
                                ? Tooltip(
                                    triggerMode: TooltipTriggerMode.tap,
                                    message: '粉丝',
                                    preferBelow: false,
                                    child: Icon(
                                      Icons.favorite,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary,
                                    ),
                                  )
                                : SizedBox.shrink();
                          }),
                          Obx(() {
                            // 是朋友
                            bool isFriend = profileController
                                    .author.value?.friend ?? false;
                            return isFriend
                                ? Tooltip(
                                    triggerMode: TooltipTriggerMode.tap,
                                    message: '朋友',
                                    preferBelow: false,
                                    child: Icon(
                                      Icons.people,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary,
                                    ),
                                  )
                                : SizedBox.shrink();
                          })
                        ],
                      ),
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 8.0,
                        runSpacing: 4.0,
                        children: [
                          // 用户名
                          Obx(() {
                            final username = profileController
                                .author.value?.username;
                            if (username != null && username.isNotEmpty) {
                              return SelectableText(
                                '@$username',
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 16),
                              );
                            } else {
                              return SizedBox.shrink();
                            }
                          }),
                          Obx(() {
                            final followerCount =
                                profileController.followerCounts.value
                                    .customFormat();
                            return Text(
                              '$followerCount 粉丝',
                              style: TextStyle(
                                  color: Colors.grey, fontSize: 16),
                            );
                          }),

                          Obx(() {
                            final followingCount =
                                profileController.followingCounts.value
                                    .customFormat();
                            return Text(
                              '$followingCount 关注',
                              style: TextStyle(
                                  color: Colors.grey, fontSize: 16),
                            );
                          }),

                          // 视频数
                          Obx(() {
                            final videoCount = profileController
                                .videoCounts.value
                                ?.customFormat();
                            if (videoCount == null) {
                              return SizedBox.shrink();
                            }
                            return Text(
                              '$videoCount 视频',
                              style: TextStyle(
                                  color: Colors.grey, fontSize: 16),
                            );
                          }),
                        ],
                      ),
                      SizedBox(height: 8),
                      Wrap(
                        spacing: 16.0,
                        runSpacing: 8.0,
                        children: [
                          // 朋友
                          Obx(() {
                            // 如果是本人，则不显示按钮
                            if (userService
                                    .currentUser.value?.id ==
                                profileController
                                    .author.value?.id) {
                              return SizedBox.shrink();
                            }

                            // 处于代办状态
                            if (profileController
                                .isFriendRequestPending.value) {
                              return ElevatedButton(
                                onPressed: () {
                                  // 取消朋友申请
                                  profileController
                                      .cancelFriendRequest();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.orange,
                                ),
                                child: Text('取消申请'),
                              );
                              // 加载中
                            } else if (profileController
                                .isFriendLoading.value) {
                              return Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  child: Text('加载中'),
                                ),
                              );
                              // 是朋友
                            } else if (profileController
                                        .author.value?.friend ==
                                    true &&
                                userService
                                        .currentUser.value?.id !=
                                    profileController
                                        .author.value?.id) {
                              return ElevatedButton(
                                onPressed: () {
                                  // 取消朋友
                                  profileController
                                      .cancelFriendRequest();
                                },
                                child: Text('解除朋友'),
                              );
                            } else {
                              return ElevatedButton(
                                onPressed: () {
                                  // 发送朋友申请
                                  profileController
                                      .sendFriendRequest();
                                },
                                child: Text('添加朋友'),
                              );
                            }
                          }),
                          // 关注
                          Obx(() {
                            // 如果是本人，则不显示按钮
                            if (userService
                                    .currentUser.value?.id ==
                                profileController
                                    .author.value?.id) {
                              return const SizedBox.shrink();
                            }

                            // 处于代办状态
                            if (profileController
                                .isFollowLoading.value) {
                              return Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  child: const Text('加载中'),
                                ),
                              );
                            } else if (profileController
                                    .author.value?.following ==
                                true) {
                              return ElevatedButton(
                                onPressed: () {
                                  // 取消关注
                                  profileController
                                      .unfollowAuthor();
                                },
                                child: Text('已关注'),
                              );
                            } else {
                              return ElevatedButton(
                                onPressed: () {
                                  // 关注
                                  profileController
                                      .followAuthor();
                                },
                                child: Text('关注'),
                              );
                            }
                          }),
                          // 特别关注
                          Obx(() {
                            // 如果是本人，则不显示按钮
                            if (userService
                                    .currentUser.value?.id ==
                                profileController
                                    .author.value?.id) {
                              return const SizedBox.shrink();
                            }

                            // 判断author是否存在
                            if (profileController.author.value == null) {
                              return const SizedBox.shrink();
                            }

                            UserDTO? likedUser =
                                userPreferenceService
                                    .getLikedUser(
                                        profileController.author
                                                .value?.id ?? '');

                            if (likedUser != null) {
                              return ElevatedButton(
                                onPressed: () {
                                  // 取消特别关注
                                  userPreferenceService
                                      .removeLikedUser(UserDTO(
                                    id: profileController
                                            .author.value?.id ??
                                        '',
                                    name: profileController
                                            .author.value?.name ??
                                        '',
                                    username: profileController
                                            .author
                                            .value
                                            ?.username ??
                                        '',
                                    avatarUrl: profileController
                                            .author
                                            .value
                                            ?.avatar
                                            ?.avatarUrl ??
                                        '',
                                  ));
                                },
                                child: const Text('已特别关注'),
                              );
                            } else {
                              return ElevatedButton(
                                onPressed: () {
                                  // 特别关注
                                  userPreferenceService
                                      .addLikedUser(UserDTO(
                                    id: profileController
                                            .author.value?.id ??
                                        '',
                                    name: profileController
                                            .author.value?.name ??
                                        '',
                                    username: profileController
                                            .author
                                            .value
                                            ?.username ??
                                        '',
                                    avatarUrl: profileController
                                            .author
                                            .value
                                            ?.avatar
                                            ?.avatarUrl ??
                                        '',
                                  ));
                                },
                                child: const Text('特别关注'),
                              );
                            }
                          })
                        ],
                      )
                    ],
                  ),
                ),
              ],
            )),
      ),
      // 个人简介
      SliverToBoxAdapter(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: MediaDescriptionWidget(
              defaultMaxLines: 1,
              description: profileController.authorDescription.value,
              isDescriptionExpanded: profileController.isDescriptionExpanded,
            )),
      ),
      SliverToBoxAdapter(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: CommentEntryAreaButtonWidget(
              commentController: profileController.commentController,
              onClickButton: () {
                profileController.isCommentSheetVisible.toggle();
              }),
        ),
      ),
      // TabBar
    ];
  }

  Widget _buildTabBarView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TopPaddingHeightWidget(),
        MouseRegion(
          child: Listener(
            onPointerSignal: (pointerSignal) {
              if (pointerSignal is PointerScrollEvent) {
                _handleScroll(pointerSignal.scrollDelta.dy);
              }
            },
            child: SingleChildScrollView(
              controller: _tabBarScrollController,
              scrollDirection: Axis.horizontal,
              physics: const ClampingScrollPhysics(),
              child: TabBar(
                isScrollable: true,
                physics: const NeverScrollableScrollPhysics(),
                overlayColor: WidgetStateProperty.all(Colors.transparent),
                tabAlignment: TabAlignment.start,
                dividerColor: Colors.transparent,
                controller: primaryTC,
                tabs: const [
                  Tab(
                    child: Row(
                      children: [
                        Icon(Icons.video_collection),
                        SizedBox(width: 8),
                        Text("视频"),
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      children: [
                        Icon(Icons.image),
                        SizedBox(width: 8),
                        Text("图库"),
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      children: [
                        Icon(Icons.playlist_play),
                        SizedBox(width: 8), 
                        Text("播放列表"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: primaryTC,
            children: <Widget>[
              Obx(() => profileController.author.value?.id != null
                  ? ProfileVideoTabListWidget(
                      key: const Key('video'),
                      userId: profileController.author.value!.id,
                      tabKey: '视频',
                      tc: videoSecondaryTC,
                      onFetchFinished: ({int? count}) {
                        profileController.videoCounts.value = count;
                      })
                  : const SizedBox.shrink()),
              Obx(() => profileController.author.value?.id != null
                  ? ProfileImageModelTabListWidget(
                      key: const Key('image'),
                      userId: profileController.author.value!.id,
                      tabKey: '图库',
                      tc: imageSecondaryTC,
                      onFetchFinished: ({int? count}) {})
                  : const SizedBox.shrink()),
              Obx(() => profileController.author.value?.id != null
                  ? ProfilePlaylistTabListWidget(
                      key: const Key('playlist'),
                      userId: profileController.author.value!.id,
                      tabKey: '播放列表',
                      tc: playlistSecondaryTC,
                      onFetchFinished: ({int? count}) {})
                  : const SizedBox.shrink()),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildCommentSheet() {
    return Obx(() => SlidingCard(
      isVisible: profileController.isCommentSheetVisible.value,
      onDismiss: () => profileController.isCommentSheetVisible.toggle(),
      title: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            const Text(
              '评论列表',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            // 添加发表评论按钮
            TextButton.icon(
              onPressed: () {
                Get.dialog(
                  CommentInputDialog(
                    title: '发表评论',
                    submitText: '发表',
                    onSubmit: (text) async {
                      if (text.trim().isEmpty) {
                        Get.snackbar('错误', '评论内容不能为空');
                        return;
                      }
                      await profileController.commentController.postComment(text);
                    },
                  ),
                  barrierDismissible: true,
                );
              },
              icon: const Icon(Icons.add_comment),
              label: const Text('发表评论'),
            ),
            // 关闭按钮
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => profileController.isCommentSheetVisible.toggle(),
            ),
          ],
        ),
      ),
      child: Obx(() => CommentSection(
        controller: profileController.commentController,
        authorUserId: profileController.author.value?.id,
      )),
    ));
  }

  double _calculatePinnedHeaderHeight() {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final double pinnedHeaderHeight =
        //statusBar height
        statusBarHeight +
            //pinned SliverAppBar height in header
            kToolbarHeight;
    return pinnedHeaderHeight;
  }
}
