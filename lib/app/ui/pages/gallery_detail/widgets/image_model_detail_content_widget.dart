import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_iwara/utils/date_time_extension.dart';

import '../../../../../common/constants.dart';
import '../../../../../common/enums/media_enums.dart';
import '../../../../services/app_service.dart';
import '../../../widgets/error_widget.dart';
import '../../popular_media_list/widgets/media_description_widget.dart';
import '../../video_detail/widgets/expandable_tags_widget.dart';
import '../../video_detail/widgets/like_avatars_widget.dart';
import '../controllers/gallery_detail_controller.dart';

class ImageModelDetailContent extends StatelessWidget {
  final GalleryDetailController controller;
  final double paddingTop;
  final double? imageModelHeight;
  final double? imageModelWidth;

  const ImageModelDetailContent({
    super.key,
    required this.controller,
    required this.paddingTop,
    this.imageModelHeight,
    this.imageModelWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // 图库播放器区域
        ClipRect(
          child: Stack(
            children: [
              Obx(() {
                // 如果图库加载出错，显示错误组件
                if (controller.errorMessage.value != null) {
                  return CommonErrorWidget(
                    text: controller.errorMessage.value ??
                        '在加载图库时出现了错误',
                    children: [
                      ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('回到上一页'),
                      ),
                      ElevatedButton(
                        onPressed: () =>
                            controller
                                .fetchVideoDetail(),
                        child: const Text('重试'),
                      ),
                    ],
                  );
                }
                return SizedBox(
                    width: imageModelWidth,
                    height: (imageModelHeight ??
                        MediaQuery
                            .sizeOf(context)
                            .width /
                            1.7) +
                        paddingTop
                    ,

                    child: Container(
                      color: Colors.black,
                      child: Center(
                          child: Text('临时展位')
                      ),
                    )
                );
              }),
            ],
          ),
        ),
        // 图库详情内容区域
        Obx(() {
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              // 图库标题
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Obx(() =>
                    Text(
                      controller.imageModelInfo.value?.title ?? '',
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    )),
              ),
              const SizedBox(height: 8),
              // 作者信息区域，包括头像和用户名
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Obx(() =>
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            NaviService.navigateToAuthorProfilePage(
                                controller.imageModelInfo.value?.user
                                    ?.username ??
                                    '');
                          },
                          borderRadius: BorderRadius.circular(20),
                          child: CircleAvatar(
                            backgroundImage: CachedNetworkImageProvider(
                              controller.imageModelInfo.value?.user?.avatar
                                  ?.avatarUrl ??
                                  CommonConstants.defaultAvatarUrl,
                              headers: const {
                                'referer': CommonConstants.iwaraBaseUrl
                              },
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        TextButton(
                          child: Text(
                            controller.imageModelInfo.value?.user?.username ??
                                '',
                            style: const TextStyle(fontSize: 16),
                          ),
                          onPressed: () {
                            NaviService.navigateToAuthorProfilePage(
                                controller.imageModelInfo.value?.user
                                    ?.username ??
                                    '');
                          },
                        ),
                      ],
                    )),
              ),
              const SizedBox(height: 8),
              // 图库发布时间和观看次数
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Obx(() =>
                    Text(
                      '发布时间：${controller.imageModelInfo.value?.createdAt
                          ?.customFormat(
                          "SHORT_CHINESE")}    观看次数：${controller
                          .imageModelInfo.value?.numViews?.customFormat()}',
                      style: const TextStyle(color: Colors.grey),
                    )),
              ),
              const SizedBox(height: 16),
              // 图库描述内容，支持展开/收起
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: MediaDescriptionWidget(
                    description: controller.imageModelInfo.value?.body,
                    isDescriptionExpanded: controller.isDescriptionExpanded,
                  )
              ),
              const SizedBox(height: 16),
              // 图库标签区域，支持展开
              Obx(() {
                final tags = controller.imageModelInfo.value?.tags;
                if (tags != null && tags.isNotEmpty) {
                  return ExpandableTagsWidget(tags: tags);
                } else {
                  return const SizedBox.shrink();
                }
              }),
              const SizedBox(height: 16),
              // 点赞用户头像展示
              Obx(() {
                final imageModelId = controller.imageModelInfo.value?.id;
                if (imageModelId != null) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: SizedBox(
                      height: 40,
                      child: LikeAvatarsWidget(
                          mediaId: imageModelId, mediaType: MediaType.IMAGE),
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              }),
              const SizedBox(height: 16),
              // 点赞和评论按钮区域
              Obx(() {
                final imageModelInfo = controller.imageModelInfo.value;
                if (imageModelInfo != null) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            // ImageModelLikeWidget(
                            //   imageModelId: imageModelInfo.id,
                            //   liked: imageModelInfo.liked,
                            //   likeCount: imageModelInfo.numLikes ?? 0,
                            // )
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.comment),
                            const SizedBox(width: 4),
                            Text('${imageModelInfo.numComments ?? 0}'),
                          ],
                        ),
                      ],
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              }),
            ],
          );
        }),
      ],
    );
  }
}