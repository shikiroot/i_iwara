import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_iwara/app/models/video.model.dart';
import 'package:i_iwara/app/services/app_service.dart';
import 'package:i_iwara/app/services/share_service.dart';
import 'package:i_iwara/app/ui/pages/play_list/controllers/play_list_detail_controller.dart';
import 'package:i_iwara/app/ui/pages/popular_media_list/widgets/video_card_list_item_widget.dart';
import 'package:i_iwara/app/ui/widgets/my_loading_more_indicator_widget.dart';
import 'package:loading_more_list/loading_more_list.dart';

class PlayListDetailPage extends StatefulWidget {
  final String playlistId;
  final bool isMine;

  const PlayListDetailPage(
      {super.key, required this.playlistId, required this.isMine});

  @override
  State<PlayListDetailPage> createState() => _PlayListDetailPageState();
}

class _PlayListDetailPageState extends State<PlayListDetailPage> {
  late PlayListDetailController controller;
  final ScrollController _scrollController = ScrollController();
  final RxBool _showBackToTop = false.obs;

  @override
  void initState() {
    super.initState();
    controller =
        Get.put(PlayListDetailController(playlistId: widget.playlistId));

    // 添加滚动监听
    _scrollController.addListener(() {
      if (_scrollController.offset >= 1000) {
        _showBackToTop.value = true;
      } else {
        _showBackToTop.value = false;
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    controller.repository.dispose();
    Get.delete<PlayListDetailController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: LoadingMoreCustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          LoadingMoreSliverList<Video>(
            SliverListConfig<Video>(
              extendedListDelegate:
                  const SliverWaterfallFlowDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 300,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
              ),
              itemBuilder: buildVideoItem,
              sourceList: controller.repository,
              padding: const EdgeInsets.all(5.0),
              lastChildLayoutType: LastChildLayoutType.foot,
              indicatorBuilder: (context, status) => myLoadingMoreIndicator(
                  context, status,
                  isSliver: true, loadingMoreBase: controller.repository),
            ),
          )
        ],
      ),
      floatingActionButton: Obx(() => _showBackToTop.value
          ? FloatingActionButton(
              onPressed: () {
                _scrollController.animateTo(
                  0,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              },
              child: const Icon(Icons.arrow_upward),
            )
          : const SizedBox()),
      bottomNavigationBar: Obx(() => controller.isMultiSelect.value
          ? _buildMultiSelectBottomBar()
          : const SizedBox()),
    );
  }

  Widget buildVideoItem(BuildContext context, Video video, int index) {
    return Obx(() {
      final bool isSelected = controller.selectedVideos.contains(video.id);
      final bool isMultiSelect = controller.isMultiSelect.value;

      return Card(
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            VideoCardListItemWidget(
              video: video,
              width: 300,
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

  void _showShareDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('分享播放列表'),
        content: const Text('要分享这个播放列表吗?'),
        actions: [
          TextButton(
            onPressed: () => AppService.tryPop(),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              AppService.tryPop();
              ShareService.sharePlayListDetail(
                  widget.playlistId, controller.playlistTitle.value);
            },
            child: const Text('分享'),
          ),
        ],
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
              case 'share':
                _showShareDialog();
                break;
            }
          },
          itemBuilder: (context) => [
            if (widget.isMine)
              const PopupMenuItem(
                value: 'edit',
                child: Row(
                  children: [
                    Icon(Icons.edit),
                    SizedBox(width: 8),
                    Text('编辑标题'),
                  ],
                ),
              ),
            if (widget.isMine)
              const PopupMenuItem(
                value: 'multiSelect',
                child: Row(
                  children: [
                    Icon(Icons.checklist),
                    SizedBox(width: 8),
                    Text('编辑模式'),
                  ],
                ),
              ),
            // 删除
            // const PopupMenuItem(
            //   value: 'deleteCurPlaylist',
            //   child: Row(
            //     children: [
            //       Icon(Icons.delete),
            //       SizedBox(width: 8),
            //       Text('删除此播放列表'),
            //     ],
            //   ),
            // ),
            // 分享
            const PopupMenuItem(
              value: 'share',
              child: Row(
                children: [
                  Icon(Icons.share),
                  SizedBox(width: 8),
                  Text('分享'),
                ],
              ),
            ),
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
}
