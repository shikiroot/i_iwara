import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_iwara/app/models/history_record.dart';
import 'package:i_iwara/app/repositories/history_repository.dart';
import 'package:i_iwara/app/services/app_service.dart';
import 'package:i_iwara/app/ui/pages/popular_media_list/widgets/image_model_card_list_item_widget.dart';
import 'package:i_iwara/app/ui/pages/popular_media_list/widgets/video_card_list_item_widget.dart';
import 'package:i_iwara/app/ui/widgets/my_loading_more_indicator_widget.dart';
import 'package:loading_more_list/loading_more_list.dart';
import 'controllers/history_list_controller.dart';

class HistoryListPage extends StatefulWidget {
  const HistoryListPage({super.key});

  @override
  State<HistoryListPage> createState() => _HistoryListPageState();
}

class _HistoryListPageState extends State<HistoryListPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late HistoryListController allController;
  late HistoryListController videoController;
  late HistoryListController imageController;
  
  final ScrollController _allScrollController = ScrollController();
  final ScrollController _videoScrollController = ScrollController();
  final ScrollController _imageScrollController = ScrollController();
  
  int _lastTappedIndex = 0;
  final RxBool isLoading = false.obs;

  @override
  void initState() {
    super.initState();
    final historyRepo = HistoryRepository();
    
    allController = Get.put(
      HistoryListController(
        historyRepository: historyRepo,
        itemType: 'all',
      ),
      tag: 'all',
    );
    
    videoController = Get.put(
      HistoryListController(
        historyRepository: historyRepo,
        itemType: 'video',
      ),
      tag: 'video',
    );
    
    imageController = Get.put(
      HistoryListController(
        historyRepository: historyRepo,
        itemType: 'image',
      ),
      tag: 'image',
    );

    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabChange);
    
    _setupScrollControllers();
  }

  void _setupScrollControllers() {
    for (final controller in [
      _allScrollController,
      _videoScrollController,
      _imageScrollController
    ]) {
      controller.addListener(() {
        if (controller.offset >= 1000) {
          allController.showBackToTop.value = true;
        } else {
          allController.showBackToTop.value = false;
        }
      });
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose();
    _disposeScrollControllers();
    Get.delete<HistoryListController>(tag: 'all');
    Get.delete<HistoryListController>(tag: 'video');
    Get.delete<HistoryListController>(tag: 'image');
    super.dispose();
  }

  void _disposeScrollControllers() {
    _allScrollController.dispose();
    _videoScrollController.dispose();
    _imageScrollController.dispose();
  }

  void _handleTabChange() {
    if (!_tabController.indexIsChanging) {
      final previousController = _getControllerForIndex(_lastTappedIndex);
      if (previousController.isMultiSelect.value) {
        previousController.toggleMultiSelect();
      }
      _lastTappedIndex = _tabController.index;
    }
  }

  void _handleTabTap(int index) async {
    if (index == _lastTappedIndex) {
      final controller = _getControllerForIndex(index);
      final scrollController = _getScrollControllerForIndex(index);
      await _scrollToTopAndRefresh(controller.repository, scrollController);
    }
  }

  HistoryListController _getControllerForIndex(int index) {
    switch (index) {
      case 0:
        return allController;
      case 1:
        return videoController;
      case 2:
        return imageController;
      default:
        return allController;
    }
  }

  ScrollController _getScrollControllerForIndex(int index) {
    switch (index) {
      case 0:
        return _allScrollController;
      case 1:
        return _videoScrollController;
      case 2:
        return _imageScrollController;
      default:
        return _allScrollController;
    }
  }

  Future<void> _scrollToTopAndRefresh(
    LoadingMoreBase repository,
    ScrollController scrollController,
  ) async {
    if (!scrollController.hasClients) {
      isLoading.value = true;
      await repository.refresh();
      isLoading.value = false;
      return;
    }

    if (scrollController.position.pixels == 0.0) {
      isLoading.value = true;
      await repository.refresh();
      isLoading.value = false;
    } else {
      await scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
      isLoading.value = true;
      await repository.refresh();
      isLoading.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('历史记录'),
        actions: [
          Obx(() => AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: isLoading.value
                    ? Container(
                        margin: const EdgeInsets.only(right: 16),
                        width: 20,
                        height: 20,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      )
                    : const SizedBox.shrink(),
              )),
          IconButton(
            onPressed: () {
              final controller = _getControllerForIndex(_tabController.index);
              controller.toggleMultiSelect();
            },
            icon: const Icon(Icons.edit),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: _buildTabBar(),
        ),
      ),
      body: Stack(
        children: [
          TabBarView(
            controller: _tabController,
            children: [
              _buildHistoryList(allController, _allScrollController),
              _buildHistoryList(videoController, _videoScrollController),
              _buildHistoryList(imageController, _imageScrollController),
            ],
          ),
          // 第一个tab的底部多选栏
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _buildMultiSelectBar(allController),
          ),
          // 第二个tab的底部多选栏
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _buildMultiSelectBar(videoController),
          ),
          // 第三个tab的底部多选栏
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _buildMultiSelectBar(imageController),
          ),
        ],
      ),
      floatingActionButton: Obx(() => allController.showBackToTop.value
          ? FloatingActionButton(
              onPressed: () {
                final scrollController =
                    _getScrollControllerForIndex(_tabController.index);
                scrollController.animateTo(
                  0,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              },
              child: const Icon(Icons.arrow_upward),
            )
          : const SizedBox()),
    );
  }

  Widget _buildTabBar() {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 600;

    return Container(
      width: isMobile ? screenWidth : 400,
      margin: EdgeInsets.symmetric(
        horizontal: isMobile ? 0 : (screenWidth - 400) / 2,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context)
            .colorScheme
            .surfaceContainerHighest
            .withOpacity(0.3),
        borderRadius: BorderRadius.circular(isMobile ? 0 : 25),
      ),
      child: TabBar(
        controller: _tabController,
        onTap: _handleTabTap,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(isMobile ? 0 : 25),
          color: Theme.of(context).colorScheme.primary,
        ),
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        labelColor: Theme.of(context).colorScheme.onPrimary,
        unselectedLabelColor: Theme.of(context).colorScheme.onSurfaceVariant,
        labelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
        padding: EdgeInsets.zero,
        tabs: const [
          Tab(text: '全部'),
          Tab(text: '视频'),
          Tab(text: '图片'),
        ],
      ),
    );
  }

  Widget _buildHistoryList(
    HistoryListController controller,
    ScrollController scrollController,
  ) {
    return LoadingMoreCustomScrollView(
      controller: scrollController,
      slivers: [
        LoadingMoreSliverList<HistoryRecord>(
          SliverListConfig<HistoryRecord>(
            extendedListDelegate:
                const SliverWaterfallFlowDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 300,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
            ),
            itemBuilder: (context, record, index) =>
                _buildHistoryItem(context, record, controller),
            sourceList: controller.repository,
            padding: const EdgeInsets.all(5.0),
            lastChildLayoutType: LastChildLayoutType.foot,
            indicatorBuilder: (context, status) => myLoadingMoreIndicator(
              context,
              status,
              isSliver: true,
              loadingMoreBase: controller.repository,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHistoryItem(
    BuildContext context,
    HistoryRecord record,
    HistoryListController controller,
  ) {
    return Obx(() {
      final bool isSelected = controller.selectedRecords.contains(record.id);
      final bool isMultiSelect = controller.isMultiSelect.value;
      final dynamic originalData = record.getOriginalData();

      return Stack(
        children: [
          if (record.itemType == 'video')
            VideoCardListItemWidget(
              video: originalData,
              width: 300,
            )
          else
            ImageModelCardListItemWidget(
              imageModel: originalData,
              width: 300,
            ),
          if (isMultiSelect)
            Positioned.fill(
              child: Material(
                color: Colors.black26,
                child: InkWell(
                  onTap: () => controller.toggleSelection(record.id),
                  child: Center(
                    child: Icon(
                      isSelected ? Icons.check_circle : Icons.circle_outlined,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ),
              ),
            ),
        ],
      );
    });
  }

  Widget _buildMultiSelectBar(HistoryListController controller) {
    return Obx(() => controller.isMultiSelect.value
        ? BottomAppBar(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '已选择 ${controller.selectedRecords.length} 条记录',
                    style: const TextStyle(fontSize: 16),
                  ),
                  Row(
                    children: [
                      TextButton(
                        onPressed: controller.selectAll,
                        child:
                            Text(controller.isAllSelected ? '取消全选' : '全选'),
                      ),
                      const SizedBox(width: 16),
                      TextButton(
                        onPressed: controller.toggleMultiSelect,
                        child: const Text('退出编辑模式'),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: () => _showDeleteConfirmDialog(controller),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        child: const Text('删除'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        : const SizedBox());
  }

  void _showDeleteConfirmDialog(HistoryListController controller) {
    Get.dialog(
      AlertDialog(
        title: const Text('确认删除'),
        content: Text('确定要删除选中的 ${controller.selectedRecords.length} 条记录吗？'),
        actions: [
          TextButton(
            onPressed: () => AppService.tryPop(),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              AppService.tryPop();
              controller.deleteSelected();
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            child: const Text('删除'),
          ),
        ],
      ),
    );
  }
} 