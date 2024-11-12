import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_iwara/app/services/app_service.dart';
import 'package:i_iwara/app/ui/pages/popular_video_list/widgets/video_preview_modal.dart';
import 'package:i_iwara/utils/date_time_extension.dart';
import 'package:vibration/vibration.dart';

import '../../../../../utils/constants.dart';
import '../../../../models/video.model.dart';
import '../../../../routes/app_routes.dart';
import 'home_dialog_route_animation.dart';

class VideoCardListItemWidget extends StatelessWidget {
  final Video video;
  final double width;

  const VideoCardListItemWidget({
    super.key,
    required this.video,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    final double imageHeight = (width * 160) / 220;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return SizedBox(
      width: width,
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: InkWell(
          onTap: () => _navigateToDetailPage(context),
          onSecondaryTap: () => _showDetailsModalWithVibration(context),
          onLongPress: () => _showDetailsModalWithVibration(context),
          hoverColor: Theme.of(context).hoverColor.withOpacity(0.1),
          splashColor: Theme.of(context).splashColor.withOpacity(0.2),
          highlightColor: Theme.of(context).highlightColor.withOpacity(0.1),
          child: _buildCardContent(imageHeight, textTheme, context),
        ),
      ),
    );
  }

  Widget _buildCardContent(
      double imageHeight, TextTheme textTheme, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildThumbnail(imageHeight, context),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTitle(textTheme),
              _buildTimeInfo(textTheme),
              const SizedBox(height: 8),
              _buildAuthorInfo(textTheme, context),
            ],
          ),
        ),
      ],
    );
  }

  // 视频缩略图
  Widget _buildThumbnail(double imageHeight, BuildContext context) {
    return SizedBox(
      height: imageHeight,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: CachedNetworkImage(
              imageUrl: video.thumbnailUrl,
              fit: BoxFit.cover,
              placeholder: (context, url) => _buildPlaceholder(),
              errorWidget: (context, url, error) =>
                  const Center(child: Icon(Icons.error, size: 50)),
            ),
          ),
          if (video.rating == 'ecchi')
            Positioned(
              left: 0,
              bottom: 0,
              child: _buildRatingTag(context),
            ),
          if (video.private == true)
            Positioned(
              left: 0,
              top: 0,
              child: _buildPrivateTag(context),
            ),
          if (video.minutesDuration != null)
            Positioned(
              right: 0,
              bottom: 0,
              child: _buildDurationTag(context),
            ),
        ],
      ),
    );
  }

  Widget _buildPlaceholder() => Container(color: Colors.grey[300]);

  Widget _buildRatingTag(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(14),
        bottomLeft: Radius.circular(12),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: const BoxDecoration(
          color: Colors.red,
        ),
        child: Text(
          'R18',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSecondary,
            fontWeight: FontWeight.bold,
            fontSize: Theme.of(context).textTheme.bodySmall?.fontSize,
            decoration: TextDecoration.none,
          ),
        ),
      ),
    );
  }

  Widget _buildPrivateTag(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(12),
        bottomRight: Radius.circular(12),
      ),
      child: Container(
        width: 100,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: const BoxDecoration(
          color: Colors.black54,
        ),
        child: Text(
          'Private',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
            fontWeight: FontWeight.bold,
            fontSize: Theme.of(context).textTheme.bodySmall?.fontSize,
            decoration: TextDecoration.none,
          ),
        ),
      ),
    );
  }

  Widget _buildDurationTag(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(12),
        bottomRight: Radius.circular(8),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: const BoxDecoration(
          color: Colors.black54,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.access_time,
              size: 16,
              color: Colors.white,
            ),
            const SizedBox(width: 4),
            Text(
              video.minutesDuration!,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: Theme.of(context).textTheme.bodySmall?.fontSize,
                decoration: TextDecoration.none,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(TextTheme textTheme) {
    return SizedBox(
      height: textTheme.bodyLarge!.fontSize! * 3.5,
      child: Text(
        video.title ?? '',
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: textTheme.bodyLarge!.fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildTimeInfo(TextTheme textTheme) {
    return Text(
      video.createdAt!.customFormat("SHORT_CHINESE"),
      style: textTheme.bodySmall,
    );
  }

  Widget _buildAuthorInfo(TextTheme textTheme, BuildContext context) {
    return GestureDetector(
      onTap: () => NaviService.navigateToAuthorProfilePage(video.user?.username ?? ''),
      child: Row(
        children: [
          _buildAvatar(),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              video.user?.name ?? 'Unknown User',
              style: textTheme.bodySmall,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    return SizedBox(
      width: 24,
      height: 24,
      child: ClipOval(
        child: CachedNetworkImage(
          imageUrl: video.user?.avatar?.avatarUrl ?? '',
          httpHeaders: const {'referer': CommonConstants.iwaraBaseUrl},
          fit: BoxFit.cover,
          placeholder: (context, url) => _buildPlaceholder(),
          errorWidget: (context, url, error) =>
              const Icon(Icons.person, size: 24),
        ),
      ),
    );
  }

  void _navigateToDetailPage(BuildContext context) {
    context.delegate.toNamed(
      Routes.VIDEO_DETAIL,
      parameters: {'videoId': video.id},
      preventDuplicates: false,
    );
  }

  void _showDetailsModalWithVibration(BuildContext context) async {
    if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate(pattern: [500]);
    }

    if (context.mounted) {
      // 显示预览模态框
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return VideoPreviewDetailModal(video: video);
        },
      );
    }
  }
}
