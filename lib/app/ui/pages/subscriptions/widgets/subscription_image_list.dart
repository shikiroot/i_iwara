import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_iwara/app/ui/pages/subscriptions/controllers/subscription_image_controller.dart';
import 'package:i_iwara/app/ui/pages/popular_media_list/widgets/image_model_tile_list_item_widget.dart';

class SubscriptionImageList extends StatelessWidget {
  final SubscriptionImageController controller;

  const SubscriptionImageList({
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
          controller.loadImages();
        }
        return false;
      },
      child: Obx(
            () => ListView.separated(
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: controller.images.length + 1,
          separatorBuilder: (context, index) => const Divider(height: 1),
          itemBuilder: (context, index) {
            if (index < controller.images.length) {
              return ImageModelTileListItem(
                imageModel: controller.images[index],
              );
            } else {
              return _buildLoadMoreIndicator();
            }
          },
        ),
      ),
    );
  }

  Widget _buildLoadMoreIndicator() {
    return Obx(
          () {
        if (controller.hasMore.value) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Center(
              child: Text(
                '没有更多图片了',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          );
        }
      },
    );
  }
}
