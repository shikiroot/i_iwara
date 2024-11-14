import 'package:flutter/material.dart';
import 'package:i_iwara/utils/date_time_extension.dart';

class VideoLikeWidget extends StatelessWidget {
  // 视频Id
  final String? videoId;
  final bool? liked;
  final bool showLikeCount;
  final int likeCount;

  // TODO 实现点赞功能
  final VoidCallback? onTap;

  const VideoLikeWidget(
      {super.key, this.videoId, required this.liked, this.onTap, required this.likeCount, this.showLikeCount = true});

  @override
  Widget build(BuildContext context) {
    if (liked == null) {
      return const SizedBox.shrink();
    }
    return videoId != null && onTap != null
        ? IconButton(
            icon: Icon(
              liked! ? Icons.favorite : Icons.favorite_border,
              color: liked! ? Colors.red : null,
            ),
            onPressed: onTap,
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                liked! ? Icons.favorite : Icons.favorite_border,
                color: liked! ? Colors.red : null,
              ),
              if (showLikeCount) const SizedBox(width: 4),
              if (showLikeCount)
                Text(
                  likeCount.customFormat(),
                  style: const TextStyle(fontSize: 14),
                ),
            ],
          );
  }
}
