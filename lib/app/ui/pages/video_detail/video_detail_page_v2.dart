import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_iwara/app/ui/pages/comment/widgets/comment_input_dialog.dart';
import 'package:i_iwara/app/ui/pages/video_detail/widgets/media_tile_list_loading_widget.dart';
import 'package:i_iwara/app/ui/pages/video_detail/widgets/video_detail_content_widget.dart';
import 'package:i_iwara/app/ui/pages/video_detail/widgets/video_detail_info_skeleton_widget.dart';
import 'package:logger/logger.dart';
import '../../../../common/enums/media_enums.dart';
import '../../../my_app.dart';
import '../../widgets/error_widget.dart';
import '../../widgets/sliding_card_widget.dart';
import '../comment/controllers/comment_controller.dart';
import '../comment/widgets/comment_entry_area_widget.dart';
import '../comment/widgets/comment_section_widget.dart';
import '../popular_media_list/widgets/video_tile_list_item_widget.dart';
import 'controllers/my_video_state_controller.dart';
import 'controllers/related_media_controller.dart';

class MyVideoDetailPage extends StatefulWidget {
  const MyVideoDetailPage({super.key});

  @override
  _MyVideoDetailPageState createState() => _MyVideoDetailPageState();
}

class _MyVideoDetailPageState extends State<MyVideoDetailPage> with RouteAware {
  final Logger logger = Logger();
  final String uniqueTag = UniqueKey().toString();
  late String videoId;

  late MyVideoStateController controller;
  late CommentController commentController;
  late RelatedMediasController relatedVideoController;

  @override
  void initState() {
    super.initState();
    videoId = Get.parameters['videoId'] ?? '';

    if (videoId.isEmpty) {
      // 如果视频ID为空，不需要初始化控制器
      return;
    }

    // 初始化控制器
    controller = Get.put(
      MyVideoStateController(videoId),
      tag: uniqueTag,
    );

    commentController = Get.put(
      CommentController(id: videoId, type: CommentType.video),
      tag: uniqueTag,
    );

    relatedVideoController = Get.put(
      RelatedMediasController(mediaId: videoId, mediaType: MediaType.VIDEO),
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
    // 尝试删除controller
    try {
      Get.delete<MyVideoStateController>(tag: uniqueTag);
      Get.delete<CommentController>(tag: uniqueTag);
      Get.delete<RelatedMediasController>(tag: uniqueTag);
    } catch (e) {
      logger.e('删除控制器失败', error: e);
    }
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
      double screenHeight, double screenWidth, double videoRatio) {
    // 使用有效的视频比例，如果比例小于1，则使用1.7
    final effectiveVideoRatio = videoRatio < 1 ? 1.7 : videoRatio;
    // 视频的高度
    final videoHeight = screenWidth / effectiveVideoRatio;
    // 如果视频高度超过屏幕高度的70%，并且屏幕宽度足够
    return videoHeight > screenHeight * 0.7;
  }

  Size _calcVideoColumnWidthAndHeight(double screenWidth, double screenHeight,
      double videoRatio, double sideColumnMinWidth, double paddingTop) {
    logger.d(
        '[DEBUG] screenWidth: $screenWidth, screenHeight: $screenHeight, videoRatio: $videoRatio, sideColumnMinWidth: $sideColumnMinWidth');
    // 使用有效的视频比例，如果比例小于1，则使用1.7
    final effectiveVideoRatio = videoRatio < 1 ? 1.7 : videoRatio;
    // 先获取70%屏幕高度时的视频宽度
    double videoWidth = (screenHeight * 0.7) * effectiveVideoRatio;
    // 如果视频宽度加上侧边栏宽度小于屏幕宽度，就使用这个宽度
    double renderVideoWidth;
    double renderVideoHeight;
    if (videoWidth + sideColumnMinWidth < screenWidth) {
      renderVideoWidth = videoWidth;
      renderVideoHeight = renderVideoWidth / effectiveVideoRatio + paddingTop;
    } else {
      renderVideoWidth = screenWidth - sideColumnMinWidth;
      renderVideoHeight = renderVideoWidth / effectiveVideoRatio + paddingTop;
    }

    return Size(renderVideoWidth, renderVideoHeight);
  }

  @override
  Widget build(BuildContext context) {
    if (videoId.isEmpty) {
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
        Size renderVideoSize = _calcVideoColumnWidthAndHeight(
            screenWidth,
            screenHeight,
            controller.aspectRatio.value,
            sideColumnMinWidth,
            paddingTop);

        if (isWide) {
          // 宽屏布局
          if (controller.isVideoInfoLoading.value) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 左侧视频详情
                SizedBox(
                  width: renderVideoSize.width,
                  child: MediaDetailInfoSkeletonWidget(),
                ),
                // 右侧评论列表
                Expanded(child: MediaTileListSkeletonWidget()),
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
                      : renderVideoSize.width,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        VideoDetailContent(
                          controller: controller,
                          paddingTop: paddingTop,
                          videoHeight: renderVideoSize.height,
                          videoWidth: renderVideoSize.width,
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
                              if (controller.otherAuthorzVideosController !=
                                      null &&
                                  controller.otherAuthorzVideosController!
                                      .isLoading.value) ...[
                                Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                    child: Text('作者的其他视频',
                                        style: TextStyle(fontSize: 18))),
                                MediaTileListSkeletonWidget()
                              ] else if (controller
                                  .otherAuthorzVideosController!.videos.isEmpty)
                                const SizedBox.shrink()
                              else ...[
                                Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                    child: Text('作者的其他视频',
                                        style: TextStyle(fontSize: 18))),
                                // 构建作者的其他视频列表
                                for (var video in controller
                                    .otherAuthorzVideosController!.videos)
                                  VideoTileListItem(video: video),
                              ],
                              if (relatedVideoController.isLoading.value) ...[
                                const SizedBox(height: 16),
                                Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                    child: Text('相关视频',
                                        style: TextStyle(fontSize: 18))),
                                MediaTileListSkeletonWidget()
                              ] else if (relatedVideoController.videos.isEmpty)
                                const SizedBox.shrink()
                              else ...[
                                const SizedBox(height: 16),
                                Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                    child: Text('相关视频',
                                        style: TextStyle(fontSize: 18))),
                                // 构建相关视频列表
                                for (var video in relatedVideoController.videos)
                                  VideoTileListItem(video: video),
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
                                    // 添加发表评论按钮
                                    TextButton.icon(
                                      onPressed: () {
                                        Get.dialog(
                                          CommentInputDialog(
                                            title: '发表评论',
                                            submitText: '发表',
                                            onSubmit: (text) async {
                                              if (text.trim().isEmpty) {
                                                Get.snackbar('错误', '评论内容不能为空');
                                                return;
                                              }
                                              await commentController.postComment(text);
                                            },
                                          ),
                                          barrierDismissible: true,
                                        );
                                      },
                                      icon: const Icon(Icons.add_comment),
                                      label: const Text('发表评论'),
                                    ),
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
                                      controller.videoInfo.value?.user?.id)),
                            )),
                      ],
                    ),
                  )
              ],
            ),
          );
        } else {
          // 窄屏布局，使用Stack 覆盖整个屏幕
          if (controller.isVideoInfoLoading.value) {
            return MediaDetailInfoSkeletonWidget();
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
                      VideoDetailContent(
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
                        if (controller.otherAuthorzVideosController != null &&
                            controller.otherAuthorzVideosController!.isLoading
                                .value) ...[
                          Container(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Text('作者的其他视频',
                                  style: TextStyle(fontSize: 18))),
                          MediaTileListSkeletonWidget()
                        ] else if (controller
                            .otherAuthorzVideosController!.videos.isEmpty)
                          const SizedBox.shrink()
                        else ...[
                          Container(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Text('作者的其他视频',
                                  style: TextStyle(fontSize: 18))),
                          // 构建作者的其他视频列表
                          for (var video in controller
                              .otherAuthorzVideosController!.videos)
                            VideoTileListItem(video: video),
                        ],
                        // 相关视频
                        if (relatedVideoController.isLoading.value) ...[
                          const SizedBox(height: 16),
                          Container(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child:
                                  Text('相关视频', style: TextStyle(fontSize: 18))),
                          MediaTileListSkeletonWidget()
                        ] else if (relatedVideoController.videos.isEmpty)
                          const SizedBox.shrink()
                        else ...[
                          const SizedBox(height: 16),
                          Container(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child:
                                  Text('相关视频', style: TextStyle(fontSize: 18))),
                          // 构建相关视频列表
                          for (var video in relatedVideoController.videos)
                            VideoTileListItem(video: video),
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
                              // 添加发表评论按钮
                              TextButton.icon(
                                onPressed: () {
                                  Get.dialog(
                                    CommentInputDialog(
                                      title: '发表评论',
                                      submitText: '发表',
                                      onSubmit: (text) async {
                                        if (text.trim().isEmpty) {
                                          Get.snackbar('错误', '评论内容不能为空');
                                          return;
                                        }
                                        await commentController.postComment(text);
                                      },
                                    ),
                                    barrierDismissible: true,
                                  );
                                },
                                icon: const Icon(Icons.add_comment),
                                label: const Text('发表评论'),
                              ),
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
                                controller.videoInfo.value?.user?.id)),
                      )),
              ],
            ),
          );
        }
      }),
    );
  }
}
