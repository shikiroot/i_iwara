import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_iwara/app/ui/pages/subscriptions/controllers/subscription_video_controller.dart';
import 'package:i_iwara/app/ui/pages/popular_media_list/widgets/video_tile_list_item_widget.dart';

class SubscriptionVideoList extends StatelessWidget {
  final SubscriptionVideoController controller;

  const SubscriptionVideoList({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollInfo) {
        if (!controller.isLoading.value &&
            scrollInfo.metrics.pixels >= scrollInfo.metrics.maxScrollExtent - 100 &&
            controller.hasMore.value) {
          controller.loadVideos();
        }
        return false;
      },
      child: Obx(() => ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: controller.videos.length + 1,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          if (index < controller.videos.length) {
            return VideoTileListItem(video: controller.videos[index]);
          } else {
            return _buildLoadMoreIndicator();
          }
        },
      )),
    );
  }

  Widget _buildLoadMoreIndicator() {
    if (controller.hasMore.value) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: Center(
          child: CircularProgressIndicator()
        ),
      );
    } else {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: Center(
          child: Text(
            '没有更多视频了',
            style: TextStyle(color: Colors.grey),
          ),
        ),
      );
    }
  }
}