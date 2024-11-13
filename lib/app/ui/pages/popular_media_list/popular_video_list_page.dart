import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_iwara/app/services/app_service.dart';
import 'package:i_iwara/app/ui/pages/popular_media_list/widgets/popular_media_search_config_widget.dart';
import 'package:i_iwara/utils/constants.dart';

import '../../../models/sort.model.dart';
import '../../../models/tag.model.dart';
import '../../widgets/title_bar_height_widget.dart';
import 'controllers/popular_video_controller.dart';
import 'widgets/video_card_list_item_widget.dart';

class PopularVideoListPage extends StatefulWidget {
  final List<Sort> sorts = CommonConstants.mediaSorts;

  const PopularVideoListPage({super.key});

  @override
  _PopularVideoListPageState createState() => _PopularVideoListPageState();
}

class _PopularVideoListPageState extends State<PopularVideoListPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late ScrollController _tabBarScrollController;
  final List<GlobalKey> _tabKeys = [];

  // 查询参数
  List<Tag> tags = [];
  String year = '';
  String rating = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: widget.sorts.length, vsync: this);
    _tabBarScrollController = ScrollController();

    for (var sort in widget.sorts) {
      _tabKeys.add(GlobalKey());
      Get.put(PopularVideoController(sortId: sort.id.name), tag: sort.id.name);
    }

    // 取出初始标签页的controller
    var initialSortId = widget.sorts[_tabController.index].id;
    var initialController =
        Get.find<PopularVideoController>(tag: initialSortId.name);
    initialController.fetchVideos();

    // 添加切换标签页的监听器
    _tabController.addListener(_onTabChange);
  }

  // 设置查询参数
  void setParams({List<Tag> tags = const [], String year = '', String rating = ''}) {
    this.tags = tags;
    this.year = year;
    this.rating = rating;

    // 设置每个controller的查询参数
    for (var sort in widget.sorts) {
      var controller = Get.find<PopularVideoController>(tag: sort.id.name);
      controller.searchTagIds = tags.map((e) => e.id).toList();
      controller.searchDate = year;
      controller.searchRating = rating;
    }
  }

  void _onTabChange() {
    // 加载数据
    var sortId = widget.sorts[_tabController.index].id;
    var controller = Get.find<PopularVideoController>(tag: sortId.name);
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

  @override
  void dispose() {
    super.dispose();
    print('[热门视频列表] dispose');
    _tabController.removeListener(_onTabChange);
    _tabController.dispose();
    _tabBarScrollController.dispose();
    // 清理所有的controller
    for (var sort in widget.sorts) {
      Get.delete<PopularVideoController>(tag: sort.id.name);
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
    return Scaffold(
      body: Column(
        children: [
          TitleBarHeightWidget(),
          // 一行，显示用户头像和搜索框
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
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: '搜索',
                    prefixIcon: Icon(Icons.search),
                  ),
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
              IconButton(
                icon: const Icon(Icons.filter_list),
                onPressed: _openParamsModal,
              ),
            ],
          ),
          // 使用 Expanded 包裹 EasyRefresh
          Expanded(
            child: EasyRefresh(
              onRefresh: () async {
                var sortId = widget.sorts[_tabController.index].id;
                var controller =
                    Get.find<PopularVideoController>(tag: sortId.name);
                await controller.fetchVideos(refresh: true);
              },
              onLoad: () async {
                var sortId = widget.sorts[_tabController.index].id;
                var controller =
                    Get.find<PopularVideoController>(tag: sortId.name);
                await controller.fetchVideos();
              },
              child: TabBarView(
                controller: _tabController,
                children: widget.sorts.map((sort) {
                  return KeepAliveTabView(
                    controller:
                        Get.find<PopularVideoController>(tag: sort.id.name),
                  );
                }).toList(),
              ),
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

        return Obx(
          () {
            if (widget.controller.errorWidget.value != null) {
              return widget.controller.errorWidget.value!;
            } else if (widget.controller.isLoading.value &&
                widget.controller.videos.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            } else if (!widget.controller.isInit.value &&
                widget.controller.videos.isEmpty) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.videocam_off,
                    size: 80,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    '没有内容哦',
                    style: TextStyle(
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
                    label: const Text('刷新'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              );
            } else {
              return CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return _buildRow(index, columns, constraints.maxWidth,
                            widget.controller);
                      },
                      childCount:
                          (widget.controller.videos.length / columns).ceil(),
                    ),
                  ),
                ],
              );
            }
          },
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
}
