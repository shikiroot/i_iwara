import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_iwara/app/ui/pages/popular_media_list/widgets/image_model_card_list_item_widget.dart';
import 'package:i_iwara/app/ui/pages/subscriptions/controllers/subscription_image_controller.dart';

import '../../../widgets/empty_widget.dart';

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
      child: LayoutBuilder(
        builder: (context, constraints) {
          final columns = _calculateColumns(constraints.maxWidth);
          
          return Obx(() {
            if (controller.errorWidget.value != null) {
              return controller.errorWidget.value!;
            }
            if (controller.images.isEmpty && !controller.isLoading.value) {
              return MyEmptyWidget(
                message: '暂无订阅图片',
                onRefresh: () => controller.loadImages(),
              );
            }

            final itemCount = (controller.images.length / columns).ceil() + 1;
            
            return ListView.builder(
              padding: EdgeInsets.zero,
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: itemCount,
              itemBuilder: (context, index) {
                if (index < itemCount - 1) {
                  return _buildRow(index, columns, constraints.maxWidth);
                } else {
                  return Obx(() => _buildLoadMoreIndicator());
                }
              },
            );
          });
        },
      ),
    );
  }

  Widget _buildRow(int index, int columns, double maxWidth) {
    final startIndex = index * columns;
    final endIndex = (startIndex + columns).clamp(0, controller.images.length);
    final rowItems = controller.images.sublist(startIndex, endIndex);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: rowItems
            .map((image) => Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: ImageModelCardListItemWidget(
                      imageModel: image,
                      width: maxWidth / columns - 8,
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }

  int _calculateColumns(double availableWidth) {
    if (availableWidth > 1200) return 5;
    if (availableWidth > 900) return 4;
    if (availableWidth > 600) return 3;
    if (availableWidth > 300) return 2;
    return 1;
  }

  Widget _buildLoadMoreIndicator() {
    return controller.hasMore.value
        ? const Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : const Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Center(
              child: Text(
                '没有更多图片了',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          );
  }
}
