import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:extended_text/extended_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_iwara/app/models/play_list.model.dart';
import 'package:i_iwara/app/services/app_service.dart';
import 'package:i_iwara/app/ui/pages/play_list/controllers/play_list_controller.dart';
import 'package:i_iwara/app/ui/widgets/empty_widget.dart';

class PlayListPage extends StatefulWidget {
  const PlayListPage({super.key});

  @override
  State<PlayListPage> createState() => _PlayListPageState();
}

class _PlayListPageState extends State<PlayListPage> {
  late PlayListsController controller;
  late EasyRefreshController _refreshController;

  @override
  void initState() {
    super.initState();
    controller = Get.put(PlayListsController());
    _refreshController = EasyRefreshController(
      controlFinishRefresh: true,
      controlFinishLoad: true,
    );
  }

  @override
  void dispose() {
    _refreshController.dispose();
    Get.delete<PlayListsController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('我的播放列表'),
        actions: [
          // 提示
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: () => _showHelpDialog(),
          ),
          // 创建
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showCreateDialog(context),
          ),
        ],
      ),
      body: Obx(() {
        // 如果是第0页且loading，则显示loading
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
          child: controller.playlists.isEmpty && !controller.isLoading.value
              ? Center(child: EmptyWidget(
                  message: "暂无播放列表",
                  onRefresh: () async {
                    await controller.refreshData();
                    _refreshController.finishRefresh();
                    _refreshController.resetFooter();
                  },
                ))
              : Stack(
                  children: [
                    GridView.builder(
                      padding: const EdgeInsets.all(8),
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        childAspectRatio: 0.75,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                      ),
                      itemCount: controller.playlists.length,
                      itemBuilder: (context, index) {
                        return _buildPlayListCard(controller.playlists[index]);
                      },
                    ),
                  ],
                ),
        );
      }),
    );
  }

  Widget _buildPlayListCard(PlaylistModel playlist) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => NaviService.navigateToPlayListDetail(playlist.id),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: CachedNetworkImage(
                    imageUrl: playlist.thumbnailUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    placeholder: (context, url) => Container(
                      color: Colors.grey[300],
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    errorWidget: (context, url, error) => const Center(
                      child: Icon(Icons.error),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        playlist.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${playlist.numVideos} 个视频',
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodySmall?.color,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showCreateDialog(BuildContext context) {
    final TextEditingController textController = TextEditingController();

    Get.dialog(
      AlertDialog(
        title: const Text('创建播放列表'),
        content: TextField(
          controller: textController,
          decoration: const InputDecoration(
            hintText: '请输入播放列表标题',
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
            onPressed: () async {
              if (textController.text.trim().isNotEmpty) {
                AppService.tryPop();
                await controller.createPlaylist(textController.text.trim());
              }
            },
            child: const Text('创建'),
          ),
        ],
      ),
    );
  }

  _showHelpDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('💡 友情提示', style: TextStyle(fontSize: 18)),
        content: const ExtendedText(
          '亲爱的用户:\n\n'
          '⚠️ iwara的播放列表系统目前还不太完善...\n'
          '• 不支持设置封面\n'
          '• 不能删除列表\n'
          '• 无法设为私密\n\n'
          '没错...创建的列表会一直存在且对所有人可见 😅\n\n'
          '💡 小建议: 如果您比较注重隐私，建议使用"点赞"功能来收藏内容~\n\n'
          '🤝 如果你有其他的建议或想法，欢迎来 GitHub 讨论!',
          style: TextStyle(fontSize: 15, height: 1.5),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('明白了', style: TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }
}
