import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_iwara/app/ui/pages/popular_video_list/widgets/video_preview_modal.dart';
import 'package:i_iwara/utils/date_time_extension.dart';
import 'package:vibration/vibration.dart';

import '../../../../models/video.model.dart';
import '../../../../routes/app_routes.dart';

class VideoTileListItem extends StatelessWidget {
  final Video video;

  const VideoTileListItem({super.key, required this.video});

  @override
  Widget build(BuildContext context) {
    final bool isDesktopPlatform = _isDesktop();

    return InkWell(
      onTap: () => _navigateToDetailPage(context),
      onLongPress: () => _handleLongPress(context),
      onSecondaryTap:
          isDesktopPlatform ? () => _handleLongPress(context) : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildThumbnail(context),
            const SizedBox(width: 16),
            _buildVideoInfo(context),
          ],
        ),
      ),
    );
  }

  /// 判断是否为桌面平台
  bool _isDesktop() {
    return !kIsWeb &&
        (Platform.isWindows || Platform.isLinux || Platform.isMacOS);
  }

  /// 构建带有标签的缩略图，不包裹 Hero
  Widget _buildThumbnail(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () => _navigateToDetailPage(context),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              imageUrl: video.thumbnailUrl,
              width: 120,
              height: 90,
              fit: BoxFit.cover,
              placeholder: (context, url) =>
                  Container(width: 120, height: 90, color: Colors.grey[300]),
              errorWidget: (context, url, error) => const SizedBox(
                  width: 120, height: 90, child: Icon(Icons.error)),
            ),
          ),
        ),
        // 添加标签
        if (video.rating == 'ecchi') _buildRatingTag(context),
        if (video.private == true) _buildPrivateTag(context),
        if (video.minutesDuration != null) _buildDurationTag(context),
      ],
    );
  }

  /// 构建视频信息部分（标题、作者和创建时间）
  Widget _buildVideoInfo(BuildContext context) {
    // 格式化创建时间
    String formattedDate = '';
    if (video.createdAt != null) {
      formattedDate = video.createdAt!.customFormat("SHORT_CHINESE");
    }

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            video.title ?? '无标题',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 16, // 调整标题字号
              fontWeight: FontWeight.bold, // 调整标题粗细
            ),
          ),
          const SizedBox(height: 4),
          Text(
            video.user?.name ?? '未知用户',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 14, // 调整作者名字号
              fontWeight: FontWeight.w500, // 调整作者名粗细
            ),
          ),
          if (formattedDate.isNotEmpty)
            Text(
              formattedDate,
              style: const TextStyle(
                fontSize: 12, // 创建时间字号
                color: Colors.grey, // 创建时间字体颜色
              ),
            ),
        ],
      ),
    );
  }

  /// 构建 R18 标签
  Widget _buildRatingTag(BuildContext context) {
    return Positioned(
      left: 0,
      bottom: 0,
      child: _buildTag(
        label: 'R18',
        backgroundColor: Colors.red,
      ),
    );
  }

  /// 构建 Private 标签
  Widget _buildPrivateTag(BuildContext context) {
    return Positioned(
      left: 0,
      top: 0,
      child: _buildTag(
        label: 'Private',
        backgroundColor: Colors.black54,
      ),
    );
  }

  /// 构建 Duration 标签
  Widget _buildDurationTag(BuildContext context) {
    return Positioned(
      right: 0,
      bottom: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          children: [
            const Icon(Icons.access_time, size: 12, color: Colors.white),
            const SizedBox(width: 2),
            Text(
              video.minutesDuration!,
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  /// 通用标签构建方法
  Widget _buildTag({required String label, required Color backgroundColor}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: const TextStyle(color: Colors.white, fontSize: 12),
      ),
    );
  }

  /// 导航到详情页
  void _navigateToDetailPage(BuildContext context) {
    Get.toNamed(Routes.VIDEO_DETAIL,
        parameters: {'videoId': video.id}, preventDuplicates: false);
  }

  /// 处理长按和右键事件
  void _handleLongPress(BuildContext context) async {
    // 震动反馈
    if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate(pattern: [100]);
    }

    if (!context.mounted) return;

    // 显示预览模态框
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return VideoPreviewDetailModal(video: video);
      },
    );
  }
}
