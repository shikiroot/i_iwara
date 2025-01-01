import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_iwara/app/ui/pages/popular_media_list/widgets/post_card_list_item_widget.dart';
import 'package:i_iwara/app/ui/pages/subscriptions/controllers/subscription_post_controller.dart';
import 'package:i_iwara/app/ui/widgets/empty_widget.dart';
import 'package:i_iwara/i18n/strings.g.dart' as slang;

class SubscriptionPostList extends StatelessWidget {
  final SubscriptionPostController controller;

  const SubscriptionPostList({
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
          controller.loadPosts();
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
            if (controller.posts.isEmpty && !controller.isLoading.value) {
              return MyEmptyWidget(
                message: slang.t.common.noMoreDatas,
                onRefresh: () => controller.loadPosts(),
              );
            }

            final itemCount = (controller.posts.length / columns).ceil() + 1;
            
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
    final endIndex = (startIndex + columns).clamp(0, controller.posts.length);
    final rowItems = controller.posts.sublist(startIndex, endIndex);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: rowItems
            .map((post) => Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: PostCardListItemWidget(post: post),
                  ),
                ))
            .toList(),
      ),
    );
  }

  int _calculateColumns(double availableWidth) {
    if (availableWidth > 1200) return 3;
    if (availableWidth > 900) return 2;
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
        : Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Center(
              child: Text(
                slang.t.common.noMoreDatas,
                style: TextStyle(color: Colors.grey),
              ),
            ),
          );
  }
} 