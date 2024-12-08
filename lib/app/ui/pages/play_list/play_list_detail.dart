import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_iwara/app/models/video.model.dart';
import 'package:i_iwara/app/services/app_service.dart';
import 'package:i_iwara/app/ui/pages/play_list/controllers/play_list_detail_controller.dart';
import 'package:i_iwara/app/ui/pages/popular_media_list/widgets/video_card_list_item_widget.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:i_iwara/app/ui/widgets/empty_widget.dart';

class PlayListDetailPage extends StatefulWidget {
  final String playlistId;
  const PlayListDetailPage({super.key, required this.playlistId});

  @override
  State<PlayListDetailPage> createState() => _PlayListDetailPageState();
}

class _PlayListDetailPageState extends State<PlayListDetailPage> {
  late PlayListDetailController controller;
  final ScrollController _scrollController = ScrollController();
  late EasyRefreshController _refreshController;

  @override
  void initState() {
    super.initState();
    controller = Get.put(PlayListDetailController(playlistId: widget.playlistId));
    _refreshController = EasyRefreshController(
      controlFinishRefresh: true,
      controlFinishLoad: true,
    );

    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _refreshController.dispose();
    Get.delete<PlayListDetailController>();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      controller.loadData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Obx(() {
        if (controller.isLoading.value && controller.currentPage == 0) {
          return const Center(child: CircularProgressIndicator());
        }

        return EasyRefresh(
          controller: _refreshController,
          onRefresh: () async {
            await controller.refreshData();
            _refreshController.finishRefresh();
            _refreshController.resetFooter();
          },
          onLoad: () async {
            await controller.loadData();
            if (controller.hasMore.value) {
              _refreshController.finishLoad();
            } else {
              _refreshController.finishLoad(IndicatorResult.noMore);
            }
          },
          child: controller.videos.isEmpty && !controller.isLoading.value
              ? MyEmptyWidget(
                  message: '暂无视频',
                  onRefresh: () async {
                    await controller.refreshData();
                    _refreshController.finishRefresh();
                    _refreshController.resetFooter();
                  },
                )
              : LayoutBuilder(
                  builder: (context, constraints) {
                    final columns = _calculateColumns(constraints.maxWidth);
                    final itemCount = (controller.videos.length / columns).ceil();

                    return ListView.builder(
                      padding: const EdgeInsets.all(4),
                      itemCount: itemCount,
                      itemBuilder: (context, index) {
                        return _buildRow(index, columns, constraints.maxWidth);
                      },
                    );
                  },
                ),
        );
      }),
      bottomNavigationBar: Obx(() =>
          controller.isMultiSelect.value ? _buildMultiSelectBottomBar() : const SizedBox()),
    );
  }

  int _calculateColumns(double availableWidth) {
    if (availableWidth > 1200) return 5;
    if (availableWidth > 900) return 4;
    if (availableWidth > 600) return 3;
    if (availableWidth > 300) return 2;
    return 1;
  }

  Widget _buildRow(int index, int columns, double maxWidth) {
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
                    child: _buildVideoCard(video, maxWidth / columns - 8),
                  ),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildVideoCard(Video video, double width) {
    return Obx(() {
      final bool isSelected = controller.selectedVideos.contains(video.id);
      final bool isMultiSelect = controller.isMultiSelect.value;

      return Card(
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            VideoCardListItemWidget(
              video: video,
              width: width,
            ),
            if (isMultiSelect)
              Positioned.fill(
                child: Material(
                  color: Colors.black26,
                  child: InkWell(
                    onTap: () => controller.toggleSelection(video.id),
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
        ),
      );
    });
  }

  Widget _buildMultiSelectBottomBar() {
    return BottomAppBar(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(() => Text(
                  '已选择 ${controller.selectedVideos.length} 个视频',
                  style: const TextStyle(fontSize: 16),
                )),
            Row(
              children: [
                TextButton(
                  onPressed: controller.selectAll,
                  // 全选、取消全选
                  child: Text(controller.isAllSelected ? '取消全选' : '全选'),
                ),
                const SizedBox(width: 16),
                TextButton(
                  onPressed: controller.toggleMultiSelect,
                  child: const Text('退出编辑模式'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () => _showDeleteConfirmDialog(),
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
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Obx(() => Text(controller.playlistTitle.value)),
      actions: [
        PopupMenuButton<String>(
          onSelected: (value) {
            switch (value) {
              case 'edit':
                _showEditTitleDialog();
                break;
              case 'multiSelect':
                controller.toggleMultiSelect();
                break;
              case 'deleteCurPlaylist':
                _showDeleteCurPlaylistConfirmDialog();
                break;
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'edit',
              child: Text('编辑标题'),
            ),
            const PopupMenuItem(
              value: 'multiSelect',
              child: Text('编辑模式')
            ),
            // 删除
            // const PopupMenuItem(
            //   value: 'deleteCurPlaylist',
            //   child: Text('删除此播放列表'),
            // ),
          ],
        ),
      ],
    );
  }

  void _showEditTitleDialog() {
    final TextEditingController textController = TextEditingController(
      text: controller.playlistTitle.value,
    );

    Get.dialog(
      AlertDialog(
        title: const Text('编辑播放列表标题'),
        content: TextField(
          controller: textController,
          decoration: const InputDecoration(
            hintText: '请输入新标题',
            border: OutlineInputBorder(),
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              if (textController.text.trim().isNotEmpty) {
                controller.editTitle(textController.text.trim());
                AppService.tryPop();
              }
            },
            child: const Text('保存'),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('确认删除'),
        content: Text('确定要删除选中的 ${controller.selectedVideos.length} 个视频吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
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

  /// 我靠，iwara压根就没有删除播放列表的功能
  @deprecated
  void _showDeleteCurPlaylistConfirmDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('确认删除'),
        content: const Text('确定要删除此播放列表吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              controller.deleteCurPlaylist();
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
