import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_iwara/app/ui/pages/gallery_detail/widgets/image_model_detail_content_widget.dart';
import 'package:i_iwara/app/ui/pages/video_detail/widgets/media_tile_list_loading_widget.dart';
import 'package:i_iwara/app/ui/pages/video_detail/widgets/video_detail_info_skeleton_widget.dart';
import 'package:i_iwara/app/ui/widgets/empty_widget.dart';
import '../../../../common/enums/media_enums.dart';
import '../../../../utils/logger_utils.dart';
import '../../widgets/error_widget.dart';
import '../../widgets/sliding_card_widget.dart';
import '../comment/controllers/comment_controller.dart';
import '../comment/widgets/comment_entry_area_widget.dart';
import '../comment/widgets/comment_section_widget.dart';
import '../popular_media_list/widgets/image_model_tile_list_item_widget.dart';
import '../video_detail/controllers/related_media_controller.dart';
import 'controllers/gallery_detail_controller.dart';

class GalleryDetailPage extends StatefulWidget {
  final String imageModelId;

  const GalleryDetailPage({super.key, required this.imageModelId});

  @override
  _GalleryDetailPageState createState() => _GalleryDetailPageState();
}

class _GalleryDetailPageState extends State<GalleryDetailPage> {
  late String imageModelId;
  late GalleryDetailController detailController;
  late CommentController commentController;
  late RelatedMediasController relatedMediasController;
  late OtherAuthorzMediasController otherAuthorzMediasController;

  @override
  void initState() {
    super.initState();
    imageModelId = widget.imageModelId;
    if (imageModelId.isEmpty) {
      return;
    }
    final String uniqueTag = UniqueKey().toString();

    // 初始化控制器
    detailController = Get.put(
      GalleryDetailController(imageModelId),
      tag: uniqueTag,
    );

    commentController = Get.put(
      CommentController(id: imageModelId, type: CommentType.image),
      tag: uniqueTag,
    );

    relatedMediasController = Get.put(
      RelatedMediasController(
          mediaId: imageModelId, mediaType: MediaType.IMAGE),
      tag: uniqueTag,
    );
  }

  // 计算是否需要分两列
  bool _shouldUseWideScreenLayout(double screenHeight, double screenWidth,
      {double imageModelRatio = 1.7}) {
    // 使用有效的图库比例，如果比例小于1，则使用1.7
    final effectiveImageModelRatio =
        imageModelRatio < 1 ? 1.7 : imageModelRatio;
    // 图库的高度
    final imageModelHeight = screenWidth / effectiveImageModelRatio;
    // 如果图库高度超过屏幕高度的70%，并且屏幕宽度足够
    return imageModelHeight > screenHeight * 0.7;
  }

  Size _calcImageModelColumnWidthAndHeight(double screenWidth,
      double screenHeight, double sideColumnMinWidth, double paddingTop,
      {double imageModelRatio = 1.7}) {
    LogUtils.d(
        '[DEBUG] screenWidth: $screenWidth, screenHeight: $screenHeight, imageModelRatio: $imageModelRatio, sideColumnMinWidth: $sideColumnMinWidth');
    // 使用有效的图库比例，如果比例小于1，则使用1.7
    final effectiveImageModelRatio =
        imageModelRatio < 1 ? 1.7 : imageModelRatio;
    // 先获取70%屏幕高度时的图库宽度
    double imageModelWidth = (screenHeight * 0.7) * effectiveImageModelRatio;
    // 如果图库宽度加上侧边栏宽度小于屏幕宽度，就使用这个宽度
    double renderImageModelWidth;
    double renderImageModelHeight;
    if (imageModelWidth + sideColumnMinWidth < screenWidth) {
      renderImageModelWidth = imageModelWidth;
      renderImageModelHeight =
          renderImageModelWidth / effectiveImageModelRatio + paddingTop;
    } else {
      renderImageModelWidth = screenWidth - sideColumnMinWidth;
      renderImageModelHeight =
          renderImageModelWidth / effectiveImageModelRatio + paddingTop;
    }

    return Size(renderImageModelWidth, renderImageModelHeight);
  }

  @override
  Widget build(BuildContext context) {
    if (imageModelId.isEmpty) {
      return CommonErrorWidget(
        text: '无效的图库ID',
        children: [
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('返回'),
          ),
        ],
      );
    }

    // 获取屏幕尺寸和内边距
    Size screenSize = MediaQuery.sizeOf(context);
    double paddingTop = MediaQuery.paddingOf(context).top;
    double screenHeight = screenSize.height;
    double screenWidth = screenSize.width;

    return Scaffold(
      body: Obx(() {
        if (detailController.errorMessage.value != null) {
          return CommonErrorWidget(
            text: detailController.errorMessage.value ?? '在加载图库详情时出现了错误',
            children: [
              ElevatedButton(
                onPressed: () => Get.back(),
                child: const Text('返回'),
              ),
            ],
          );
        }

        // 判断是否使用宽屏布局
        bool isWide = _shouldUseWideScreenLayout(screenHeight, screenWidth);
        // 分配图库详情与附列表的宽度
        const sideColumnMinWidth = 400.0;
        Size renderImageModelSize = _calcImageModelColumnWidthAndHeight(
            screenWidth, screenHeight, sideColumnMinWidth, paddingTop);

        if (isWide) {
          // 宽屏布局
          if (detailController.isImageModelInfoLoading.value) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 左侧图库详情
                SizedBox(
                  width: renderImageModelSize.width,
                  // child: ImageModelDetailInfoSkeletonWidget(),
                  child: const Text('临时股价图'),
                ),
                // 右侧评论列表
                // Expanded(child: ImageModelTileListSkeletonWidget()),
              ],
            );
          }

          if (detailController.imageModelInfo.value == null) {
            return const EmptyWidget();
          }

          return PopScope(
            canPop: !detailController.isCommentSheetVisible.value,
            onPopInvokedWithResult: (bool didPop, dynamic result) {
              if (detailController.isCommentSheetVisible.value) {
                detailController.isCommentSheetVisible.toggle();
              }
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: renderImageModelSize.width,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ImageModelDetailContent(
                          controller: detailController,
                          paddingTop: paddingTop,
                          imageModelHeight: renderImageModelSize.height,
                          imageModelWidth: renderImageModelSize.width,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // 相关图库
                            Container(height: paddingTop, color: Colors.black),
                            // 作者的其他图库
                            if (detailController
                                        .otherAuthorzImageModelsController !=
                                    null &&
                                detailController
                                    .otherAuthorzImageModelsController!
                                    .isLoading
                                    .value) ...[
                              Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 16),
                                  child: const Text('作者的其他图库',
                                      style: TextStyle(fontSize: 18))),
                              const MediaTileListSkeletonWidget()
                            ] else if (detailController
                                .otherAuthorzImageModelsController!
                                .imageModels
                                .isEmpty)
                              const SizedBox.shrink()
                            else ...[
                              Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 16),
                                  child: const Text('作者的其他图库',
                                      style: TextStyle(fontSize: 18))),
                              // 构建作者的其他图库列表
                              for (var imageModel in detailController
                                  .otherAuthorzImageModelsController!
                                  .imageModels)
                                ImageModelTileListItem(
                                    imageModel: imageModel),
                            ],
                            if (relatedMediasController
                                .isLoading.value) ...[
                              const SizedBox(height: 16),
                              Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 16),
                                  child: const Text('相关图库',
                                      style: TextStyle(fontSize: 18))),
                              const MediaTileListSkeletonWidget()
                            ] else if (relatedMediasController
                                .imageModels.isEmpty)
                              const SizedBox.shrink()
                            else ...[
                              const SizedBox(height: 16),
                              Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 16),
                                  child: const Text('相关图库',
                                      style: TextStyle(fontSize: 18))),
                              // 构建相关图库列表
                              for (var imageModel
                                  in relatedMediasController.imageModels)
                                ImageModelTileListItem(
                                    imageModel: imageModel),
                            ],
                          ],
                        ),
                      ),
                      // SlidingCard 仅覆盖右侧区域
                      Obx(() => SlidingCard(
                            isVisible:
                                detailController.isCommentSheetVisible.value,
                            onDismiss: () =>
                                detailController.isCommentSheetVisible.toggle(),
                            title: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Row(
                                children: [
                                  const Text(
                                    '评论列表',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const Spacer(),
                                  // 关闭按钮
                                  IconButton(
                                    icon: const Icon(Icons.close),
                                    onPressed: () => detailController
                                        .isCommentSheetVisible
                                        .toggle(),
                                  ),
                                ],
                              ),
                            ),
                            child: Obx(() => CommentSection(
                                controller: commentController,
                                authorUserId: detailController
                                    .imageModelInfo.value?.user?.id)),
                          )),
                    ],
                  ),
                )
              ],
            ),
          );
        } else {
          if (detailController.isImageModelInfoLoading.value) {
            return const VideoDetailInfoSkeletonWidget();
          }

          if (detailController.imageModelInfo.value == null) {
            return const EmptyWidget();
          }

          return PopScope(
            canPop: !detailController.isCommentSheetVisible.value,
            onPopInvokedWithResult: (bool didPop, dynamic result) {
              if (detailController.isCommentSheetVisible.value) {
                detailController.isCommentSheetVisible.toggle();
              }
            },
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // 图库详情
                      ImageModelDetailContent(
                        controller: detailController,
                        paddingTop: paddingTop,
                      ),
                      // 评论区域
                      Container(
                        padding: const EdgeInsets.all(16),
                        child: CommentEntryAreaButtonWidget(
                          commentController: commentController,
                          onClickButton: () {
                            detailController.isCommentSheetVisible.toggle();
                          },
                        ),
                      ),
                      // 作者的其他图库
                      if (detailController.otherAuthorzImageModelsController !=
                              null &&
                          detailController.otherAuthorzImageModelsController!
                              .isLoading.value) ...[
                        Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: const Text('作者的其他图库',
                                style: TextStyle(fontSize: 18))),
                        const MediaTileListSkeletonWidget()
                      ] else if (detailController
                          .otherAuthorzImageModelsController!
                          .imageModels
                          .isEmpty)
                        const SizedBox.shrink()
                      else ...[
                        Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: const Text('作者的其他图库',
                                style: TextStyle(fontSize: 18))),
                        // 构建作者的其他图库列表
                        for (var imageModel in detailController
                            .otherAuthorzImageModelsController!.imageModels)
                          ImageModelTileListItem(imageModel: imageModel),
                      ],
                      // 相关图库
                      if (relatedMediasController.isLoading.value) ...[
                        const SizedBox(height: 16),
                        Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: const Text('相关图库',
                                style: TextStyle(fontSize: 18))),
                        const MediaTileListSkeletonWidget()
                      ] else if (relatedMediasController.imageModels.isEmpty)
                        const SizedBox.shrink()
                      else ...[
                        const SizedBox(height: 16),
                        Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: const Text('相关图库',
                                style: TextStyle(fontSize: 18))),
                        // 构建相关图库列表
                        for (var imageModel
                            in relatedMediasController.imageModels)
                          ImageModelTileListItem(imageModel: imageModel),
                      ],
                    ],
                  ),
                ),
                Obx(() => SlidingCard(
                      isVisible: detailController.isCommentSheetVisible.value,
                      onDismiss: () =>
                          detailController.isCommentSheetVisible.toggle(),
                      title: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            const Text(
                              '评论列表',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            // 关闭按钮
                            IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () => detailController
                                  .isCommentSheetVisible
                                  .toggle(),
                            ),
                          ],
                        ),
                      ),
                      child: Obx(() => CommentSection(
                          controller: commentController,
                          authorUserId:
                              detailController.imageModelInfo.value?.user?.id)),
                    )),
              ],
            ),
          );
        }
      }),
    );
  }
}
