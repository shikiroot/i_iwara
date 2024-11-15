import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import '../../../my_app.dart';
import '../../widgets/error_widget.dart';
import '../../widgets/sliding_card_widget.dart';
import '../comment/controllers/comment_controller.dart';
import '../comment/widgets/comment_entry_area_widget.dart';
import '../comment/widgets/comment_section_widget.dart';

class MyImageModelDetailPage extends StatefulWidget {
  final String imageModelId;

  const MyImageModelDetailPage({super.key, required this.imageModelId});

  @override
  _MyImageModelDetailPageState createState() => _MyImageModelDetailPageState();
}

class _MyImageModelDetailPageState extends State<MyImageModelDetailPage> with RouteAware {
  late String imageModelId;
  late GalleryDetailController controller;

  @override
  void initState() {
    super.initState();
    imageModelId = widget.imageModelId;
    if (imageModelId.isEmpty) {
      return;
    }
    final String uniqueTag = UniqueKey().toString();

    // 初始化控制器
    controller = Get.put(
      GalleryDetailController(imageModelId),
      tag: uniqueTag,
    );

    commentController = Get.put(
      CommentController(imageModelId: imageModelId),
      tag: uniqueTag,
    );

    relatedImageModelController = Get.put(
      RelatedImageModelController(imageModelId: imageModelId),
      tag: uniqueTag,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 订阅路由变化
    routeObserver.subscribe(this, ModalRoute.of(context)! as PageRoute);
  }

  @override
  void dispose() {
    // 取消订阅路由变化
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  // 当当前路由被其他路由覆盖时调用
  @override
  void didPushNext() {
    super.didPushNext();
    logger.d("[详情页路由监听]跳转到其他页面");
    controller.player.pause(); // 暂停视频
  }

  // 当返回到当前路由时调用
  @override
  void didPopNext() {
    super.didPopNext();
    logger.d("[详情页路由监听]返回到当前页面");
    // 可以在这里恢复播放视频，如果需要
    // controller.player.play();
  }

  // 计算是否需要分两列
  bool _shouldUseWideScreenLayout(
      double screenHeight, double screenWidth, double imageModelRatio) {
    // 使用有效的视频比例，如果比例小于1，则使用1.7
    final effectiveImageModelRatio = imageModelRatio < 1 ? 1.7 : imageModelRatio;
    // 视频的高度
    final imageModelHeight = screenWidth / effectiveImageModelRatio;
    // 如果视频高度超过屏幕高度的70%，并且屏幕宽度足够
    return imageModelHeight > screenHeight * 0.7;
  }

  Size _calcImageModelColumnWidthAndHeight(double screenWidth, double screenHeight,
      double imageModelRatio, double sideColumnMinWidth, double paddingTop) {
    logger.d(
        '[DEBUG] screenWidth: $screenWidth, screenHeight: $screenHeight, imageModelRatio: $imageModelRatio, sideColumnMinWidth: $sideColumnMinWidth');
    // 使用有效的视频比例，如果比例小于1，则使用1.7
    final effectiveImageModelRatio = imageModelRatio < 1 ? 1.7 : imageModelRatio;
    // 先获取70%屏幕高度时的视频宽度
    double imageModelWidth = (screenHeight * 0.7) * effectiveImageModelRatio;
    // 如果视频宽度加上侧边栏宽度小于屏幕宽度，就使用这个宽度
    double renderImageModelWidth;
    double renderImageModelHeight;
    if (imageModelWidth + sideColumnMinWidth < screenWidth) {
      renderImageModelWidth = imageModelWidth;
      renderImageModelHeight = renderImageModelWidth / effectiveImageModelRatio + paddingTop;
    } else {
      renderImageModelWidth = screenWidth - sideColumnMinWidth;
      renderImageModelHeight = renderImageModelWidth / effectiveImageModelRatio + paddingTop;
    }

    return Size(renderImageModelWidth, renderImageModelHeight);
  }

  @override
  Widget build(BuildContext context) {
    if (imageModelId.isEmpty) {
      return CommonErrorWidget(
        text: '视频ID为空',
        children: [
          ElevatedButton(
            onPressed: () => Get.back(),
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
        if (controller.errorMessage.value != null) {
          return CommonErrorWidget(
            text: controller.errorMessage.value ?? '在加载视频详情时出现了错误',
            children: [
              ElevatedButton(
                onPressed: () => Get.back(),
                child: const Text('返回'),
              ),
            ],
          );
        }
        bool isDesktopAppFullScreen = controller.isDesktopAppFullScreen.value;

        // 判断是否使用宽屏布局
        bool isWide = _shouldUseWideScreenLayout(
            screenHeight, screenWidth, controller.aspectRatio.value);
        // 分配视频详情与附列表的宽度
        const sideColumnMinWidth = 400.0;
        Size renderImageModelSize = _calcImageModelColumnWidthAndHeight(
            screenWidth,
            screenHeight,
            controller.aspectRatio.value,
            sideColumnMinWidth,
            paddingTop);

        if (isWide) {
          // 宽屏布局
          if (controller.isImageModelInfoLoading.value) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 左侧视频详情
                SizedBox(
                  width: renderImageModelSize.width,
                  child: ImageModelDetailInfoSkeletonWidget(),
                ),
                // 右侧评论列表
                Expanded(child: ImageModelTileListSkeletonWidget()),
              ],
            );
          }

          return PopScope(
            canPop: !controller.isCommentSheetVisible.value,
            onPopInvokedWithResult: (bool didPop, dynamic result) {
              if (controller.isCommentSheetVisible.value) {
                controller.isCommentSheetVisible.toggle();
              }
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 左侧视频详情，使用SingleChildScrollView以确保内容可滚动
                SizedBox(
                  width: isDesktopAppFullScreen
                      ? screenWidth
                      : renderImageModelSize.width,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ImageModelDetailContent(
                          controller: controller,
                          paddingTop: paddingTop,
                          imageModelHeight: renderImageModelSize.height,
                          imageModelWidth: renderImageModelSize.width,
                        ),
                        if (!isDesktopAppFullScreen)
                          Container(
                            padding: const EdgeInsets.all(16),
                            child: CommentEntryAreaButtonWidget(
                                commentController: commentController,
                                onClickButton: () {
                                  controller.isCommentSheetVisible.toggle();
                                }),
                          )
                      ],
                    ),
                  ),
                ),
                if (!controller.isDesktopAppFullScreen.value)
                  Expanded(
                    child: Stack(
                      children: [
                        SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // 相关视频
                              Container(
                                  height: paddingTop, color: Colors.black),
                              // 作者的其他视频
                              if (controller.otherAuthorzImageModelsController !=
                                  null &&
                                  controller.otherAuthorzImageModelsController!
                                      .isLoading.value) ...[
                                Container(
                                    padding:
                                    EdgeInsets.symmetric(horizontal: 16),
                                    child: Text('作者的其他视频',
                                        style: TextStyle(fontSize: 18))),
                                ImageModelTileListSkeletonWidget()
                              ] else if (controller
                                  .otherAuthorzImageModelsController!.imageModels.isEmpty)
                                const SizedBox.shrink()
                              else ...[
                                  Container(
                                      padding:
                                      EdgeInsets.symmetric(horizontal: 16),
                                      child: Text('作者的其他视频',
                                          style: TextStyle(fontSize: 18))),
                                  // 构建作者的其他视频列表
                                  for (var imageModel in controller
                                      .otherAuthorzImageModelsController!.imageModels)
                                    ImageModelTileListItem(imageModel: imageModel),
                                ],
                              if (relatedImageModelController.isLoading.value) ...[
                                const SizedBox(height: 16),
                                Container(
                                    padding:
                                    EdgeInsets.symmetric(horizontal: 16),
                                    child: Text('相关视频',
                                        style: TextStyle(fontSize: 18))),
                                ImageModelTileListSkeletonWidget()
                              ] else if (relatedImageModelController.imageModels.isEmpty)
                                const SizedBox.shrink()
                              else ...[
                                  const SizedBox(height: 16),
                                  Container(
                                      padding:
                                      EdgeInsets.symmetric(horizontal: 16),
                                      child: Text('相关视频',
                                          style: TextStyle(fontSize: 18))),
                                  // 构建相关视频列表
                                  for (var imageModel in relatedImageModelController.imageModels)
                                    ImageModelTileListItem(imageModel: imageModel),
                                ],
                            ],
                          ),
                        ),
                        // SlidingCard 仅覆盖右侧区域
                        Obx(() => SlidingCard(
                          isVisible: controller.isCommentSheetVisible.value,
                          onDismiss: () =>
                              controller.isCommentSheetVisible.toggle(),
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
                                  onPressed: () => controller
                                      .isCommentSheetVisible
                                      .toggle(),
                                ),
                              ],
                            ),
                          ),
                          child: Obx(() => CommentSection(
                              controller: commentController,
                              authorUserId:
                              controller.imageModelInfo.value?.user?.id)),
                        )),
                      ],
                    ),
                  )
              ],
            ),
          );
        } else {
          // 窄屏布局，使用Stack 覆盖整个屏幕
          if (controller.isImageModelInfoLoading.value) {
            return ImageModelDetailInfoSkeletonWidget();
          }
          return PopScope(
            canPop: !controller.isCommentSheetVisible.value,
            onPopInvokedWithResult: (bool didPop, dynamic result) {
              if (controller.isCommentSheetVisible.value) {
                controller.isCommentSheetVisible.toggle();
              }
            },
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // 视频详情
                      ImageModelDetailContent(
                        controller: controller,
                        paddingTop: paddingTop,
                      ),
                      if (!controller.isDesktopAppFullScreen.value) ...[
                        // 评论区域
                        Container(
                          padding: const EdgeInsets.all(16),
                          child: CommentEntryAreaButtonWidget(
                            commentController: commentController,
                            onClickButton: () {
                              controller.isCommentSheetVisible.toggle();
                            },
                          ),
                        ),
                        // 作者的其他视频
                        if (controller.otherAuthorzImageModelsController != null &&
                            controller.otherAuthorzImageModelsController!.isLoading
                                .value) ...[
                          Container(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Text('作者的其他视频',
                                  style: TextStyle(fontSize: 18))),
                          ImageModelTileListSkeletonWidget()
                        ] else if (controller
                            .otherAuthorzImageModelsController!.imageModels.isEmpty)
                          const SizedBox.shrink()
                        else ...[
                            Container(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: Text('作者的其他视频',
                                    style: TextStyle(fontSize: 18))),
                            // 构建作者的其他视频列表
                            for (var imageModel in controller
                                .otherAuthorzImageModelsController!.imageModels)
                              ImageModelTileListItem(imageModel: imageModel),
                          ],
                        // 相关视频
                        if (relatedImageModelController.isLoading.value) ...[
                          const SizedBox(height: 16),
                          Container(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child:
                              Text('相关视频', style: TextStyle(fontSize: 18))),
                          ImageModelTileListSkeletonWidget()
                        ] else if (relatedImageModelController.imageModels.isEmpty)
                          const SizedBox.shrink()
                        else ...[
                            const SizedBox(height: 16),
                            Container(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child:
                                Text('相关视频', style: TextStyle(fontSize: 18))),
                            // 构建相关视频列表
                            for (var imageModel in relatedImageModelController.imageModels)
                              ImageModelTileListItem(imageModel: imageModel),
                          ],
                      ]
                    ],
                  ),
                ),
                if (!controller.isDesktopAppFullScreen.value)
                  Obx(() => SlidingCard(
                    isVisible: controller.isCommentSheetVisible.value,
                    onDismiss: () =>
                        controller.isCommentSheetVisible.toggle(),
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
                            onPressed: () =>
                                controller.isCommentSheetVisible.toggle(),
                          ),
                        ],
                      ),
                    ),
                    child: Obx(() => CommentSection(
                        controller: commentController,
                        authorUserId:
                        controller.imageModelInfo.value?.user?.id)),
                  )),
              ],
            ),
          );
        }
      }),
    );
  }
}
