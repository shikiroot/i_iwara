import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_iwara/app/services/app_service.dart';
import 'package:i_iwara/app/services/user_service.dart';
import 'package:i_iwara/app/ui/pages/popular_media_list/widgets/popular_media_search_config_widget.dart';
import 'package:i_iwara/app/ui/pages/search/search_dialog.dart';
import 'package:i_iwara/app/ui/widgets/avatar_widget.dart';
import 'package:i_iwara/common/constants.dart';
import 'package:i_iwara/utils/logger_utils.dart';
import 'package:shimmer/shimmer.dart';

import '../../../models/sort.model.dart';
import '../../../models/tag.model.dart';
import '../../widgets/top_padding_height_widget.dart';
import 'controllers/popular_video_controller.dart';
import 'widgets/video_card_list_item_widget.dart';
import 'package:i_iwara/i18n/strings.g.dart' as slang;

class PopularVideoListPage extends StatefulWidget {
  final List<Sort> sorts = CommonConstants.mediaSorts;

  PopularVideoListPage({super.key});

  @override
  _PopularVideoListPageState createState() => _PopularVideoListPageState();
}

class _PopularVideoListPageState extends State<PopularVideoListPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late ScrollController _tabBarScrollController;
  final List<GlobalKey> _tabKeys = [];

  final UserService userService = Get.find<UserService>();

  final Map<SortId, PopularVideoController> _controllers = {};

  // 查询参数
  List<Tag> tags = [];
  String year = '';
  String rating = '';

  @override
  void initState() {
    super.initState();
    for (var sort in widget.sorts) {
      _tabKeys.add(GlobalKey());
      _controllers[sort.id] = PopularVideoController(sortId: sort.id.name);
    }
    _tabController = TabController(length: widget.sorts.length, vsync: this);
    _tabBarScrollController = ScrollController();
    // 取出初始标签页的controller
    var initialSortId = widget.sorts[_tabController.index].id;
    var initialController = _controllers[initialSortId]!;
    initialController.fetchVideos();

    // 添加切换标签页的监听器
    _tabController.addListener(_onTabChange);
  }

  
  @override
  void dispose() {
    super.dispose();
    _tabController.removeListener(_onTabChange);
    _tabController.dispose();
    _tabBarScrollController.dispose();
    // 清理所有的PopularVideoController
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    _controllers.clear();
  }

  // 设置查询参数
  void setParams(
      {List<Tag> tags = const [], String year = '', String rating = ''}) {
    this.tags = tags;
    this.year = year;
    this.rating = rating;

    LogUtils.d('设置查询参数: tags: $tags, year: $year, rating: $rating', 'PopularVideoListPage');

    // 设置每个controller的查询参数并重置数据
    for (var sort in widget.sorts) {
      var controller = _controllers[sort.id]!;
      controller.searchTagIds = tags.map((e) => e.id).toList();
      controller.searchDate = year;
      controller.searchRating = rating;
      // 重置controller状态
      controller.reset();
      // 如果是当前显示的tab，则立即加载新数据
      if (sort.id == widget.sorts[_tabController.index].id) {
        controller.fetchVideos();
      }
    }
  }

  void _onTabChange() {
    // 加载数据
    var sortId = widget.sorts[_tabController.index].id;
    var controller = _controllers[sortId]!;
    // 如果是在初始化状态并且不是正在加载，则加载数据
    if (controller.isInit.value && !controller.isLoading.value) {
      controller.fetchVideos(refresh: true);
    }
    // 滚动到选中的Tab
    _scrollToSelectedTab();
  }

  void _scrollToSelectedTab() {
    // 获取当前选中的tab的GlobalKey
    final GlobalKey currentTabKey = _tabKeys[_tabController.index];

    // 获取tab的RenderBox
    final RenderBox? renderBox =
        currentTabKey.currentContext?.findRenderObject() as RenderBox?;

    if (renderBox != null) {
      // 获取tab在ScrollView中的位置
      final position = renderBox.localToGlobal(Offset.zero);

      // 计算需要滚动的位置
      final screenWidth = MediaQuery.of(context).size.width;
      final tabWidth = renderBox.size.width;

      // 计算目标滚动位置（使tab居中）
      final targetScroll = _tabBarScrollController.offset +
          position.dx -
          (screenWidth / 2) +
          (tabWidth / 2);

      // 确保滚动位置在有效范围内
      final double finalScroll = targetScroll.clamp(
        0.0,
        _tabBarScrollController.position.maxScrollExtent,
      );

      // 使用动画滚动到目标位置
      _tabBarScrollController.animateTo(
        finalScroll,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _handleScroll(double delta) {
    if (_tabBarScrollController.hasClients) {
      final double newOffset = _tabBarScrollController.offset + delta;
      if (newOffset < 0) {
        _tabBarScrollController.jumpTo(0);
      } else if (newOffset > _tabBarScrollController.position.maxScrollExtent) {
        _tabBarScrollController
            .jumpTo(_tabBarScrollController.position.maxScrollExtent);
      } else {
        _tabBarScrollController.jumpTo(newOffset);
      }
    }
  }

  // 打开搜索配置弹窗
  void _openParamsModal() {
    Get.dialog(PopularMediaSearchConfig(
      searchTags: tags,
      searchYear: year,
      searchRating: rating,
      onConfirm: (tags, year, rating) {
        setParams(tags: tags, year: year, rating: rating);
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    final t = slang.Translations.of(context);
    return Scaffold(
      body: Column(
        children: [
          TopPaddingHeightWidget(),
          // 一行，显示用户头像和搜索框
          Row(
            children: [
              // 用户头像
              Obx(() {
                    if (userService.isLogin) {
                      return Stack(
                        children: [
                          IconButton(
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
                          ),
                          Positioned(
                            right: 8,
                            top: 8,
                            child: Obx(() {
                              final count = userService.notificationCount.value + userService.messagesCount.value;
                              if (count > 0) {
                                return Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).colorScheme.error,
                                    shape: BoxShape.circle,
                                  ),
                                );
                              }
                              return const SizedBox.shrink();
                            }),
                          ),
                        ],
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
              // 搜索框
              Expanded(
                child: TextField(
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: t.common.search,
                    prefixIcon: const Icon(Icons.search),
                  ),
                  onTap: () {
                    Get.dialog(SearchDialog(
                      initialSearch: '',
                      initialSegment: SearchSegment.video,
                      onSearch: (searchInfo, segment) {
                        NaviService.toSearchPage(
                            searchInfo: searchInfo, segment: segment);
                      },
                    ));
                  },
                ),
              ),
            ],
          ),
          // 一行，显示TabBar和筛选按钮
          Row(
            children: [
              // TabBar
              Expanded(
                // 支持鼠标滚动 以及 tabbar 变动后位置调整
                child: MouseRegion(
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
                        overlayColor:
                            WidgetStateProperty.all(Colors.transparent),
                        tabAlignment: TabAlignment.start,
                        dividerColor: Colors.transparent,
                        padding: EdgeInsets.zero,
                        controller: _tabController,
                        tabs: widget.sorts.asMap().entries.map((entry) {
                          int index = entry.key;
                          Sort sort = entry.value;
                          return Container(
                            key: _tabKeys[index], // 使用GlobalKey
                            child: Tab(
                              child: Row(
                                children: [
                                  sort.icon ?? const SizedBox(),
                                  const SizedBox(width: 4),
                                  Text(sort.label),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ),
              // 添加刷新按钮
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () {
                  var sortId = widget.sorts[_tabController.index].id;
                  var controller = _controllers[sortId]!;
                  controller.fetchVideos(refresh: true);
                },
              ),
              IconButton(
                icon: const Icon(Icons.filter_list),
                onPressed: _openParamsModal,
              ),
            ],
          ),
          // 使用 Expanded 包裹 EasyRefresh
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: widget.sorts.map((sort) {
                return KeepAliveTabView(
                  controller: _controllers[sort.id]!,
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

// 单独抽取出来的TabView，用于保持 滚动状态
class KeepAliveTabView extends StatefulWidget {
  final PopularVideoController controller;

  const KeepAliveTabView({super.key, required this.controller});

  @override
  _KeepAliveTabViewState createState() => _KeepAliveTabViewState();
}

class _KeepAliveTabViewState extends State<KeepAliveTabView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final int columns = _calculateColumns(constraints.maxWidth);

        return NotificationListener<ScrollNotification>(
          onNotification: (scrollInfo) {
            if (!widget.controller.isLoading.value &&
                scrollInfo.metrics.pixels >=
                    scrollInfo.metrics.maxScrollExtent - 100 &&
                !widget.controller.isInit.value) {
              widget.controller.fetchVideos();
            }
            return false;
          },
          child: Obx(
            () {
              if (widget.controller.errorWidget.value != null) {
                return widget.controller.errorWidget.value!;
              } else if (widget.controller.isLoading.value &&
                  widget.controller.videos.isEmpty) {
                return _buildShimmerLoading(columns, constraints.maxWidth);
              } else if (!widget.controller.isInit.value &&
                  widget.controller.videos.isEmpty) {
                return _buildEmptyView(context);
              } else {
                final itemCount =
                    (widget.controller.videos.length / columns).ceil() + 1;

                return ListView.builder(
                  padding: EdgeInsets.zero,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: itemCount,
                  itemBuilder: (context, index) {
                    if (index < itemCount - 1) {
                      return _buildRow(index, columns, constraints.maxWidth,
                          widget.controller);
                    } else {
                      return _buildLoadMoreIndicator(context);
                    }
                  },
                );
              }
            },
          ),
        );
      },
    );
  }

  Widget _buildRow(int index, int columns, double maxWidth,
      PopularVideoController controller) {
    final startIndex = index * columns;
    final endIndex = (startIndex + columns).clamp(0, controller.videos.length);
    final rowItems = controller.videos.sublist(startIndex, endIndex);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: rowItems
            .map((video) => Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: VideoCardListItemWidget(
                      video: video,
                      width: maxWidth / columns - 8,
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }

  int _calculateColumns(double availableWidth) {
    if (availableWidth > 1200) return 5;
    if (availableWidth > 900) return 4;
    if (availableWidth > 600) return 3;
    if (availableWidth > 300) return 2;
    return 1;
  }

  // 添加加载更多指示器组件
  Widget _buildLoadMoreIndicator(BuildContext context) {
    final t = slang.Translations.of(context);
    return Obx(() => widget.controller.hasMore.value
        ? const Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Center(
              child: Text(
                t.common.noMoreDatas,
                style: const TextStyle(color: Colors.grey),
              ),
            ),
          ));
  }

  // 添加空视图组件
  Widget _buildEmptyView(BuildContext context) {
    final t = slang.Translations.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.videocam_off,
          size: 80,
          color: Colors.grey,
        ),
        const SizedBox(height: 16),
        Text(
          t.common.noContent,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton.icon(
          onPressed: () {
            widget.controller.fetchVideos(refresh: true);
          },
          icon: const Icon(Icons.refresh),
          label: Text(t.common.refresh),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            textStyle: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }

  // 添加shimmer加载效果组件
  Widget _buildShimmerLoading(int columns, double maxWidth) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: 3, // 显示3行shimmer效果
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              columns,
              (colIndex) => Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: _buildShimmerItem(maxWidth / columns - 8),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildShimmerItem(double width) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: SizedBox(
        width: width,
        height: width * 9 / 16 + 72, // 16:9的视频比例 + 标题和信息的高度
        child: Column(
          spacing: 8,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 缩略图区域
            Container(
              width: width,
              height: width * 9 / 16,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            // 标题区域
            Container(
              width: width * 0.8,
              height: 16,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            // 信息区域
            Container(
              width: width * 0.6,
              height: 12,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
