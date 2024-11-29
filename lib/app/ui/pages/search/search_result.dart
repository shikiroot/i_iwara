import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_iwara/app/services/app_service.dart';
import 'package:i_iwara/app/services/global_search_service.dart';
import 'package:i_iwara/app/ui/pages/popular_media_list/widgets/image_model_card_list_item_widget.dart';
import 'package:i_iwara/app/ui/pages/popular_media_list/widgets/video_card_list_item_widget.dart';
import 'package:i_iwara/app/ui/pages/video_detail/widgets/media_tile_list_loading_widget.dart';
import 'package:i_iwara/app/ui/widgets/empty_widget.dart';
import 'package:i_iwara/app/ui/widgets/user_card.dart';

import 'search_dialog.dart';

class SearchResult extends StatefulWidget {
  const SearchResult({super.key});

  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  final GlobalSearchService globalSearchService =
      Get.find<GlobalSearchService>();

  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    globalSearchService.fetchSearchResult(refresh: true);
    _searchController.text = globalSearchService.currentSearch.value;

    // 监听输入框变化并更新 observable
    _searchController.addListener(() {
      globalSearchService.currentSearch.value = _searchController.text;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose(); // Dispose scroll controller
    globalSearchService.resetAll();
    super.dispose();
  }

  void _safeScrollToTop() {
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(0);
    }
  }

  Widget _buildSearchResult() {
    return Obx(() {
      if (globalSearchService.errorWidget.value != null) {
        return globalSearchService.errorWidget.value!;
      }

      if (globalSearchService.isLoading.value &&
          globalSearchService.isCurrentResultEmpty) {
        return const Center(child: MediaTileListSkeletonWidget());
      }

      if (globalSearchService.isResultEmpty) {
        return const Center(child: EmptyWidget());
      }

      Widget child;
      switch (globalSearchService.selectedSegment.value) {
        case 'video':
          child = _buildVideoResult();
          break;
        case 'image':
          child = _buildImageResult(); // New case for image results
          break;
        case 'user':
          child = _buildUserResult(); // Add user case
          break;
        default:
          child = Text(
              '暂未实现当前搜索类型 ${globalSearchService.selectedSegment.value}，敬请期待');
      }

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: child,
      );
    });
  }

  Widget _buildVideoResult() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final int columns = _calculateColumns(constraints.maxWidth);
        final itemCount =
            (globalSearchService.searchVideoResult.length / columns).ceil() + 1;

        return NotificationListener<ScrollNotification>(
          onNotification: (scrollInfo) {
            if (!globalSearchService.isLoading.value &&
                scrollInfo.metrics.pixels >=
                    scrollInfo.metrics.maxScrollExtent - 100 &&
                globalSearchService.hasMore) {
              globalSearchService.fetchSearchResult();
            }
            return false;
          },
          child: ListView.builder(
            controller: _scrollController, // Add controller here
            padding: EdgeInsets.zero,
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: itemCount,
            itemBuilder: (context, index) {
              if (index < itemCount - 1) {
                return _buildRow(index, columns, constraints.maxWidth);
              } else {
                return _buildLoadMoreIndicator();
              }
            },
          ),
        );
      },
    );
  }

  Widget _buildRow(int index, int columns, double maxWidth) {
    return Obx(() {
      final startIndex = index * columns;
      final endIndex = (startIndex + columns)
          .clamp(0, globalSearchService.searchVideoResult.length);
      final rowItems =
          globalSearchService.searchVideoResult.sublist(startIndex, endIndex);
      final remainingColumns = columns - rowItems.length;

      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ...rowItems.map((video) => Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: VideoCardListItemWidget(
                      video: video,
                      width: maxWidth / columns - 8,
                    ),
                  ),
                )),
            // 添加空的占位 Expanded 来填充剩余空间
            ...List.generate(
              remainingColumns,
              (index) => Expanded(child: Container()),
            ),
          ],
        ),
      );
    });
  }

  int _calculateColumns(double availableWidth) {
    if (availableWidth > 1200) return 5;
    if (availableWidth > 900) return 4;
    if (availableWidth > 600) return 3;
    if (availableWidth > 300) return 2;
    return 1;
  }

  Widget _buildLoadMoreIndicator() {
    return Obx(() => globalSearchService.hasMore
        ? const Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : const Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Center(
              child: Text(
                '没有更多内容了',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ));
  }

  Widget _buildImageResult() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final int columns = _calculateColumns(constraints.maxWidth);
        final itemCount =
            (globalSearchService.searchImageResult.length / columns).ceil() + 1;

        return NotificationListener<ScrollNotification>(
          onNotification: (scrollInfo) {
            if (!globalSearchService.isLoading.value &&
                scrollInfo.metrics.pixels >=
                    scrollInfo.metrics.maxScrollExtent - 100 &&
                globalSearchService.hasMore) {
              globalSearchService.fetchSearchResult();
            }
            return false;
          },
          child: ListView.builder(
            controller: _scrollController, // Add controller here
            padding: EdgeInsets.zero,
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: itemCount,
            itemBuilder: (context, index) {
              if (index < itemCount - 1) {
                return _buildImageRow(index, columns, constraints.maxWidth);
              } else {
                return _buildLoadMoreIndicator();
              }
            },
          ),
        );
      },
    );
  }

  Widget _buildImageRow(int index, int columns, double maxWidth) {
    return Obx(() {
      final startIndex = index * columns;
      final endIndex = (startIndex + columns)
          .clamp(0, globalSearchService.searchImageResult.length);
      final rowItems =
          globalSearchService.searchImageResult.sublist(startIndex, endIndex);
      final remainingColumns = columns - rowItems.length;

      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ...rowItems.map((image) => Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: ImageModelCardListItemWidget(
                      imageModel: image,
                      width: maxWidth / columns - 8,
                    ),
                  ),
                )),
            // 添加空的占位 Expanded 来填充剩余空间
            ...List.generate(
              remainingColumns,
              (index) => Expanded(child: Container()),
            ),
          ],
        ),
      );
    });
  }

  // Add new method for user results
  Widget _buildUserResult() {
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollInfo) {
        if (!globalSearchService.isLoading.value &&
            scrollInfo.metrics.pixels >= scrollInfo.metrics.maxScrollExtent - 100 &&
            globalSearchService.hasMore) {
          globalSearchService.fetchSearchResult();
        }
        return false;
      },
      child: ListView.builder(
        controller: _scrollController,
        padding: EdgeInsets.zero,
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: globalSearchService.searchUserResult.length + 1,
        itemBuilder: (context, index) {
          if (index < globalSearchService.searchUserResult.length) {
            final user = globalSearchService.searchUserResult[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
              child: UserCard(
                user: user,
                onTap: () => NaviService.navigateToAuthorProfilePage(user.username),
              ),
            );
          } else {
            return _buildLoadMoreIndicator();
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('搜索结果'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // 输入框
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Material(
              elevation: 2,
              borderRadius: BorderRadius.circular(8),
              child: TextField(
                controller: _searchController,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
                decoration: InputDecoration(
                  hintText: globalSearchService.searchPlaceholder.value.isEmpty
                      ? '请填写搜索内容'
                      : globalSearchService.searchPlaceholder.value,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 2,
                    ),
                  ),
                ),
                onTap: () {
                  Get.dialog(SearchDialog(
                    initialSearch: globalSearchService.currentSearch.value,
                    initialSegment: SearchSegment.fromValue(
                        globalSearchService.selectedSegment.value),
                    onSearch: (searchInfo, segment) {
                      // 更新搜索关键词和片段
                      globalSearchService.currentSearch.value = searchInfo;
                      globalSearchService.selectedSegment.value = segment;
                      globalSearchService.fetchSearchResult(refresh: true);
                      // 关闭对话框
                      Get.back();
                    },
                  ));
                },
                // 不再需要 onChanged，因为已通过控制器监听
              ),
            ),
          ),
          const SizedBox(height: 16),
          // SegmentedButton
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Obx(() => Row(
                  children: [
                    SegmentedButton<String>(
                      segments: [
                        ButtonSegment(
                          value: 'video',
                          label: globalSearchService.selectedSegment.value ==
                                  'video'
                              ? const Text('视频')
                              : null,
                          icon: const Icon(Icons.video_library),
                        ),
                        ButtonSegment(
                          value: 'image',
                          label: globalSearchService.selectedSegment.value ==
                                  'image'
                              ? const Text('图片')
                              : null,
                          icon: const Icon(Icons.image),
                        ),
                        ButtonSegment(
                          value: 'post',
                          label: globalSearchService.selectedSegment.value ==
                                  'post'
                              ? const Text('帖子')
                              : null,
                          icon: const Icon(Icons.article),
                        ),
                        ButtonSegment(
                          value: 'user',
                          label: globalSearchService.selectedSegment.value ==
                                  'user'
                              ? const Text('用户')
                              : null,
                          icon: const Icon(Icons.person),
                        ),
                      ],
                      selected: {globalSearchService.selectedSegment.value},
                      onSelectionChanged: (Set<String> selection) {
                        if (selection.isNotEmpty) {
                          globalSearchService.selectedSegment.value =
                              selection.first;
                          _safeScrollToTop();
                          if (!globalSearchService.isCurrentResultInitialized) {
                            globalSearchService.fetchSearchResult();
                          }
                        }
                      },
                      multiSelectionEnabled: false,
                      style: const ButtonStyle(
                        visualDensity: VisualDensity.compact,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.refresh),
                      onPressed: () {
                        globalSearchService.fetchSearchResult(refresh: true);
                      },
                    ),
                  ],
                )),
          ),
          const SizedBox(height: 20),
          // 搜索结果
          Expanded(
            child: _buildSearchResult(),
          ),
        ],
      ),
    );
  }
}
