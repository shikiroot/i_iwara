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
import 'package:i_iwara/i18n/strings.g.dart' as slang;
import 'package:i_iwara/app/ui/pages/popular_media_list/widgets/post_card_list_item_widget.dart';

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
  late HistoryListController postController;

  final ScrollController _allScrollController = ScrollController();
  final ScrollController _videoScrollController = ScrollController();
  final ScrollController _imageScrollController = ScrollController();
  final ScrollController _postScrollController = ScrollController();

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

    postController = Get.put(
      HistoryListController(
        historyRepository: historyRepo,
        itemType: 'post',
      ),
      tag: 'post',
    );

    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(_handleTabChange);

    _setupScrollControllers();
  }

  void _setupScrollControllers() {
    for (final controller in [
      _allScrollController,
      _videoScrollController,
      _imageScrollController,
      _postScrollController,
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
    Get.delete<HistoryListController>(tag: 'post');
    super.dispose();
  }

  void _disposeScrollControllers() {
    _allScrollController.dispose();
    _videoScrollController.dispose();
    _imageScrollController.dispose();
    _postScrollController.dispose();
  }

  void _handleTabChange() {
    if (!_tabController.indexIsChanging) {
      final previousController = _getControllerForIndex(_lastTappedIndex);
      if (previousController.isMultiSelect.value) {
        previousController.toggleMultiSelect();
      }
      _lastTappedIndex = _tabController.index;
      setState(() {});
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
      case 3:
        return postController;
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
      case 3:
        return _postScrollController;
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
        title: _buildSearchField(context),
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
            onPressed: () => _showClearHistoryDialog(),
            icon: const Icon(Icons.delete_sweep),
            tooltip: slang.t.common.clearAllHistory,
          ),
          IconButton(
            onPressed: () {
              final controller = _getControllerForIndex(_tabController.index);
              controller.toggleMultiSelect();
            },
            icon: const Icon(Icons.checklist),
          ),
          const SizedBox(width: 8),
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
              _buildHistoryList(postController, _postScrollController),
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
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _buildMultiSelectBar(postController),
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
    return Container(
      width: 400,
      margin: const EdgeInsets.symmetric(
        horizontal: 0,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context)
            .colorScheme
            .surfaceContainerHighest
            .withOpacity(0.3),
        borderRadius: BorderRadius.circular(25),
      ),
      child: TabBar(
        controller: _tabController,
        onTap: _handleTabTap,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
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
        tabs: [
          Tab(text: slang.t.common.all),
          Tab(text: slang.t.common.video),
          Tab(text: slang.t.common.gallery),
          Tab(text: slang.t.common.post),
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
              maxCrossAxisExtent: 200,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
            ),
            itemBuilder: (context, record, index) =>
                _buildHistoryItem(context, record, controller),
            sourceList: controller.repository,
            padding: EdgeInsets.fromLTRB(
              5.0,
              5.0,
              5.0,
              Get.context != null ? MediaQuery.of(Get.context!).padding.bottom + 5.0 : 0,
            ),
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
              width: 200,
            )
          else if (record.itemType == 'image')
            ImageModelCardListItemWidget(
              imageModel: originalData,
              width: 200,
            )
          else if (record.itemType == 'post')
            PostCardListItemWidget(
              post: originalData,
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
            child: SafeArea(
              minimum: const EdgeInsets.only(bottom: 8.0),
              child: IntrinsicHeight(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Text(
                          slang.t.common.selectedRecords(
                              num: controller.selectedRecords.length),
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                      Row(
                        children: [
                          TextButton(
                            onPressed: controller.selectAll,
                            child: Text(controller.isAllSelected
                                ? slang.t.common.cancelSelectAll
                                : slang.t.common.selectAll),
                          ),
                          const SizedBox(width: 16),
                          TextButton(
                            onPressed: controller.toggleMultiSelect,
                            child: Text(slang.t.common.exitEditMode),
                          ),
                          const SizedBox(width: 16),
                          Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: ElevatedButton(
                              onPressed: () => _showDeleteConfirmDialog(controller),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                              ),
                              child: Text(slang.t.common.delete),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        : const SizedBox());
  }

  void _showDeleteConfirmDialog(HistoryListController controller) {
    Get.dialog(
      AlertDialog(
        title: Text(slang.t.common.confirmDelete),
        content: Text(slang.t.common.areYouSureYouWantToDeleteSelectedItems(
            num: controller.selectedRecords.length)),
        actions: [
          TextButton(
            onPressed: () => AppService.tryPop(),
            child: Text(slang.t.common.cancel),
          ),
          TextButton(
            onPressed: () {
              AppService.tryPop();
              controller.deleteSelected();
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            child: Text(slang.t.common.delete),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField(BuildContext context) {
    final controller = _getControllerForIndex(_tabController.index);
    final t = slang.Translations.of(context);

    return TextField(
      decoration: InputDecoration(
        hintText: t.common.searchHistoryRecords,
        hintStyle: TextStyle(
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
        ),
        prefixIcon: const Icon(Icons.search),
      ),
      style: TextStyle(
        color: Theme.of(context).colorScheme.onSurface,
      ),
      onChanged: (value) => controller.search(value),
      controller: TextEditingController(text: controller.searchKeyword.value),
    );
  }

  void _showClearHistoryDialog() {
    final controller = _getControllerForIndex(_tabController.index);
    final itemType = controller.itemType;

    Get.dialog(
      AlertDialog(
        title: Text(slang.t.common.clearAllHistory),
        content: Text(slang.t.common.clearAllHistoryConfirm),
        actions: [
          TextButton(
            onPressed: () => AppService.tryPop(),
            child: Text(slang.t.common.cancel),
          ),
          TextButton(
            onPressed: () async {
              await controller.clearHistoryByType(itemType);
              AppService.tryPop();
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            child: Text(slang.t.common.confirm),
          ),
        ],
      ),
    );
  }
}
