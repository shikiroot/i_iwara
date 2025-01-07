import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_iwara/app/models/image.model.dart';
import 'package:i_iwara/app/ui/pages/popular_media_list/widgets/image_model_card_list_item_widget.dart';
import 'package:i_iwara/app/ui/widgets/my_loading_more_indicator_widget.dart';
import 'package:loading_more_list/loading_more_list.dart';
import '../controllers/subscription_image_repository.dart';

class SubscriptionImageList extends StatefulWidget {
  final String userId;

  const SubscriptionImageList({
    super.key,
    required this.userId,
  });

  @override
  SubscriptionImageListState createState() => SubscriptionImageListState();
}

class SubscriptionImageListState extends State<SubscriptionImageList> {
  late SubscriptionImageRepository listSourceRepository;

  @override
  void initState() {
    super.initState();
    listSourceRepository = SubscriptionImageRepository(userId: widget.userId);
  }

  @override
  void dispose() {
    listSourceRepository.dispose();
    super.dispose();
  }

  Future<void> refresh() async {
    await listSourceRepository.refresh(true);
  }

  @override
  Widget build(BuildContext context) {
    return LoadingMoreCustomScrollView(
      slivers: <Widget>[
        LoadingMoreSliverList(
          SliverListConfig<ImageModel>(
            extendedListDelegate:
                const SliverWaterfallFlowDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 300,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
            ),
            itemBuilder: (BuildContext context, ImageModel image, int index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: ImageModelCardListItemWidget(
                  imageModel: image,
                  width: 300,
                ),
              );
            },
            sourceList: listSourceRepository,
            padding: EdgeInsets.only(
              left: 5.0,
              right: 5.0,
              top: 5.0,
              bottom: Get.context != null ? MediaQuery.of(Get.context!).padding.bottom : 0,
            ),
            lastChildLayoutType: LastChildLayoutType.foot,
            indicatorBuilder: (context, status) => myLoadingMoreIndicator(
              context,
              status,
              isSliver: true,
              loadingMoreBase: listSourceRepository,
            ),
          ),
        ),
      ],
    );
  }
}
