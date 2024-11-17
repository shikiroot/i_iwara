import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_iwara/app/ui/widgets/empty_widget.dart';
import 'package:i_iwara/utils/date_time_extension.dart';
import 'package:i_iwara/utils/logger_utils.dart';
import 'package:i_iwara/utils/widget_extensions.dart';

import '../../../../../common/constants.dart';
import '../../../../../common/enums/media_enums.dart';
import '../../../../models/image.model.dart';
import '../../../../services/app_service.dart';
import '../../../widgets/error_widget.dart';
import '../../popular_media_list/widgets/media_description_widget.dart';
import '../../video_detail/widgets/expandable_tags_widget.dart';
import '../../video_detail/widgets/like_avatars_widget.dart';
import '../controllers/gallery_detail_controller.dart';
import 'horizontial_image_list.dart';

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

  Widget _contentLayout(BuildContext context, Widget child) {
    return Column(
      children: [
        Container(
          height: paddingTop,
          color: Colors.transparent,
        ),
        if (!GetPlatform.isWeb && GetPlatform.isDesktop) ...[
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).pop(),
              ),
              const SizedBox(width: 8),
              Text(
                controller.imageModelInfo.value?.title ?? '',
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ],
          )
        ],
        SizedBox(
            width: imageModelWidth,
            height:
                (imageModelHeight ?? MediaQuery.sizeOf(context).width / 1.7),
            child: child.paddingHorizontal(16)),
      ],
    );
  }

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
                    text: controller.errorMessage.value ?? '在加载图库时出现了错误',
                    children: [
                      ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('回到上一页'),
                      ),
                      ElevatedButton(
                        onPressed: () => controller.fetchVideoDetail(),
                        child: const Text('重试'),
                      ),
                    ],
                  );
                }
                ImageModel? im = controller.imageModelInfo.value;

                if (im == null) {
                  return _contentLayout(context,
                      const EmptyWidget(message: "啊？怎么会没有数据呢？出错了吧 :<"));
                }

                List<ImageItem> imageItems = controller
                    .imageModelInfo.value!.files
                    .map((e) => ImageItem(url: e.getLargeImageUrl(), data: e))
                    .toList();

                return _contentLayout(
                    context,
                    MouseRegion(
                      onEnter: (_) =>
                          controller.isHoveringHorizontalList.value = true,
                      onExit: (_) =>
                          controller.isHoveringHorizontalList.value = false,
                      child: HorizontalImageList(
                          images: imageItems,
                          menuItemsBuilder: (context, item) {
                            return [
                              MenuItem(
                                title: '下载原图',
                                icon: Icons.download,
                                onTap: () {
                                  // TODO 下载图片
                                  Get.snackbar('提示', '暂不支持下载图片');
                                  LogUtils.d(
                                      '下载图片：${item.data.getLargeImageUrl()}',
                                      'ImageModelDetailContent');
                                  // AppService.downloadFile(item.url);
                                },
                              ),
                            ];
                          }),
                    ));
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
                child: SelectableText(
                  controller.imageModelInfo.value?.title ?? '',
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 8),
              // 作者信息区域，包括头像和用户名
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          NaviService.navigateToAuthorProfilePage(
                              controller.imageModelInfo.value?.user?.username ??
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
                          controller.imageModelInfo.value?.user?.username ?? '',
                          style: const TextStyle(fontSize: 16),
                        ),
                        onPressed: () {
                          NaviService.navigateToAuthorProfilePage(
                              controller.imageModelInfo.value?.user?.username ??
                                  '');
                        },
                      ),
                    ],
                  )),
              const SizedBox(height: 8),
              // 图库发布时间和观看次数
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    '发布时间：${controller.imageModelInfo.value?.createdAt?.customFormat("SHORT_CHINESE")}    观看次数：${controller.imageModelInfo.value?.numViews?.customFormat()}',
                    style: const TextStyle(color: Colors.grey),
                  )),
              const SizedBox(height: 16),
              // 图库描述内容，支持展开/收起
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: MediaDescriptionWidget(
                    description: controller.imageModelInfo.value?.body,
                    isDescriptionExpanded: controller.isDescriptionExpanded,
                  )),
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
                            // TODO 点赞按钮
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
