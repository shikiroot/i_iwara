import 'package:cached_network_image/cached_network_image.dart';
import 'package:extended_text/extended_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_iwara/app/models/play_list.model.dart';
import 'package:i_iwara/app/services/app_service.dart';
import 'package:i_iwara/app/ui/pages/play_list/controllers/play_list_controller.dart';
import 'package:i_iwara/app/ui/pages/play_list/controllers/play_list_repository.dart';
import 'package:i_iwara/app/ui/widgets/empty_widget.dart';
import 'package:loading_more_list/loading_more_list.dart';

class PlayListPage extends StatefulWidget {
  const PlayListPage({super.key});

  @override
  State<PlayListPage> createState() => _PlayListPageState();
}

class _PlayListPageState extends State<PlayListPage> {
  late PlayListsController controller;
  late PlayListRepository listSourceRepository;

  @override
  void initState() {
    super.initState();
    controller = Get.put(PlayListsController());
    listSourceRepository = PlayListRepository();
  }

  @override
  void dispose() {
    super.dispose();
    Get.delete<PlayListsController>();
    listSourceRepository.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('我的播放列表'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => listSourceRepository.refresh(),
          ),
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: () => _showHelpDialog(),
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showCreateDialog(context),
          ),
        ],
      ),
      body: LoadingMoreCustomScrollView(
        slivers: <Widget>[
          LoadingMoreSliverList<PlaylistModel>(
            SliverListConfig<PlaylistModel>(
              extendedListDelegate:
                  const SliverWaterfallFlowDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 300,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
              ),
              itemBuilder: buildItem,
              sourceList: listSourceRepository,
              padding: const EdgeInsets.all(5.0),
              lastChildLayoutType: LastChildLayoutType.foot,
              indicatorBuilder: _buildIndicator,
            ),
          )
        ],
      ),
    );
  }

  Widget getIndicator(BuildContext context) {
    return CircularProgressIndicator(
      strokeWidth: 2.0,
      valueColor: AlwaysStoppedAnimation<Color>(
        Theme.of(context).colorScheme.primary,
      ),
    );
  }

  Widget _buildIndicator(BuildContext context, IndicatorStatus status) {
    const bool isSliver = true;
    Widget? widget;

    switch (status) {
      case IndicatorStatus.none:
        widget = Container(height: 0.0);
        break;
      case IndicatorStatus.loadingMoreBusying:
        widget = Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(right: 5.0),
              height: 15.0,
              width: 15.0,
              child: getIndicator(context),
            ),
            const Text('正在加载...')
          ],
        );
        break;
      case IndicatorStatus.fullScreenBusying:
        widget = Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(right: 0.0),
              height: 30.0,
              width: 30.0,
              child: getIndicator(context),
            ),
            const Text('正在加载...')
          ],
        );
        widget = isSliver
            ? SliverFillRemaining(child: widget)
            : CustomScrollView(
                slivers: <Widget>[SliverFillRemaining(child: widget)],
              );
        break;
      case IndicatorStatus.error:
        widget = GestureDetector(
          onTap: () => listSourceRepository.errorRefresh(),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Icon(Icons.error, color: Colors.red),
                Text('啊哦，好像出现了问题呢？'),
              ],
            ),
          ),
        );
        break;
      case IndicatorStatus.fullScreenError:
        widget = GestureDetector(
          onTap: () => listSourceRepository.errorRefresh(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              Icon(Icons.error, color: Colors.red),
              Text('啊哦，好像出现了问题呢？'),
            ],
          ),
        );
        widget = isSliver
            ? SliverFillRemaining(child: widget)
            : CustomScrollView(
                slivers: <Widget>[SliverFillRemaining(child: widget)],
              );
        break;
      case IndicatorStatus.noMoreLoad:
        widget = Center(
          child: Text(
            '没有更多了',
            style: TextStyle(
              color: Theme.of(context).textTheme.bodySmall?.color,
            ),
          ),
        );
        break;
      case IndicatorStatus.empty:
        widget = const MyEmptyWidget(message: '没有数据');
        widget = isSliver
            ? SliverToBoxAdapter(child: widget)
            : CustomScrollView(
                slivers: <Widget>[SliverFillRemaining(child: widget)],
              );
        break;
    }
    return widget;
  }

  Widget buildItem(BuildContext c, PlaylistModel playlist, int index) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => NaviService.navigateToPlayListDetail(playlist.id),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min, // 添加这行
          children: [
            // 使用 AspectRatio 来固定图片区域的宽高比
            AspectRatio(
              aspectRatio: 16 / 9, // 可以根据需要调整宽高比
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
                      color: Theme.of(c).textTheme.bodySmall?.color,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
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
                listSourceRepository.refresh();
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
