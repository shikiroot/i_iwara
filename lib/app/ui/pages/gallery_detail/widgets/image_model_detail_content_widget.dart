import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:extended_text/extended_text.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:i_iwara/app/services/api_service.dart';
import 'package:i_iwara/app/ui/widgets/empty_widget.dart';
import 'package:i_iwara/utils/date_time_extension.dart';
import 'package:i_iwara/utils/logger_utils.dart';
import 'package:i_iwara/utils/widget_extensions.dart';
import 'package:super_clipboard/super_clipboard.dart';

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
import 'my_gallery_photo_view_wrapper.dart';

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

  // 构建图像库内容的布局
  Widget _contentLayout(BuildContext context, Widget child) {
    return Column(
      children: [
        _buildPaddingTop(),
        _buildHeader(context),
        _buildImageContent(context, child),
      ],
    );
  }

  // 构建顶部的透明间距
  Widget _buildPaddingTop() {
    return Container(
      height: paddingTop,
      color: Colors.transparent,
    );
  }

  // 构建标题栏，包括返回按钮和标题
  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: ExtendedText(
            controller.imageModelInfo.value?.title ?? '',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
      ],
    );
  }

  // 构建图片内容部分，主要是显示图库图片
  Widget _buildImageContent(BuildContext context, Widget child) {
    return SizedBox(
      width: imageModelWidth,
      height: (imageModelHeight ?? MediaQuery.sizeOf(context).width / 1.7),
      child: child.paddingHorizontal(16),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildGalleryArea(context),
        _buildGalleryDetails(context),
      ],
    );
  }

  // 构建图库区域，显示图片和加载错误信息
  Widget _buildGalleryArea(BuildContext context) {
    return ClipRect(
      child: Stack(
        children: [
          Obx(() {
            if (controller.errorMessage.value != null) {
              return _buildErrorContent(context);
            }
            return _buildImageListContent(context);
          }),
        ],
      ),
    );
  }

  // 构建错误信息区域
  Widget _buildErrorContent(BuildContext context) {
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

  // 构建图片列表内容
  Widget _buildImageListContent(BuildContext context) {
    ImageModel? im = controller.imageModelInfo.value;
    if (im == null) {
      return _contentLayout(
          context, const EmptyWidget(message: "啊？怎么会没有数据呢？出错了吧 :<"));
    }

    List<ImageItem> imageItems = im.files
        .map((e) => ImageItem(
              url: e.getLargeImageUrl(),
              data: ImageItemData(
                id: e.id,
                url: e.getLargeImageUrl(),
                originalUrl: e.getOriginalImageUrl(),
              ),
            ))
        .toList();

    return _contentLayout(
      context,
      MouseRegion(
        onEnter: (_) => controller.isHoveringHorizontalList.value = true,
        onExit: (_) => controller.isHoveringHorizontalList.value = false,
        child: HorizontalImageList(
          images: imageItems,
          onItemTap: (item) => _onImageTap(context, item, imageItems),
          menuItemsBuilder: (context, item) => _buildImageMenuItems(item),
        ),
      ),
    );
  }

  // 处理图片点击事件
  void _onImageTap(
      BuildContext context, ImageItem item, List<ImageItem> imageItems) {
    ImageItemData iid = item.data;
    LogUtils.d('点击了图片：${iid.id}', 'ImageModelDetailContent');
    int index = imageItems.indexWhere((element) => element.url == item.url);
    if (index == -1) {
      index = imageItems.indexWhere((element) => element.data.id == iid.id);
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MyGalleryPhotoViewWrapper(
          galleryItems: imageItems,
          initialIndex: index,
          menuItemsBuilder: (context, item) => _buildImageMenuItems(item),
        ),
      ),
    );
  }

  // 构建图片的菜单项
  List<MenuItem> _buildImageMenuItems(ImageItem item) {
    return [
      MenuItem(
        title: '复制链接地址',
        icon: Icons.copy,
        onTap: () => _copyLink(item),
      ),
      MenuItem(
        title: '复制图片',
        icon: Icons.copy,
        onTap: () => _copyImage(item),
      ),
      if (GetPlatform.isDesktop && !GetPlatform.isWeb)
        MenuItem(
          title: '另存为',
          icon: Icons.download,
          onTap: () => _downloadImageForDesktop(item),
        ),
      if (GetPlatform.isIOS || GetPlatform.isAndroid)
        MenuItem(
          title: '保存到相册',
          icon: Icons.save,
          onTap: () => _downloadImageForMobile(item),
        ),
    ];
  }

  // 复制链接到剪贴板
  void _copyLink(ImageItem item) {
    String url =
        item.data.originalUrl.isEmpty ? item.data.url : item.data.originalUrl;
    if (url.isEmpty) {
      Get.snackbar('提示', '链接地址为空');
      return;
    }
    final data = DataWriterItem();
    data.add(Formats.plainText(url));
    SystemClipboard.instance?.write([data]);
    Get.snackbar('提示', '链接地址已复制到剪贴板');
  }

  // 复制图片到剪贴板
  void _copyImage(ImageItem item) async {
    String url =
        item.data.originalUrl.isEmpty ? item.data.url : item.data.originalUrl;
    if (url.isEmpty) {
      Get.snackbar('提示', '链接地址为空');
      return;
    }

    try {
      var apiService = await ApiService.getInstance();
      Uint8List bytes = (await apiService.dio
              .get(url, options: Options(responseType: ResponseType.bytes)))
          .data;
      final dataWriterItem =
          DataWriterItem(suggestedName: '${item.data.id}.png');
      dataWriterItem.add(Formats.png(bytes));
      SystemClipboard.instance?.write([dataWriterItem]);
      Get.snackbar('提示', '图片已复制到剪贴板');
    } catch (e) {
      Get.snackbar('提示', '复制图片失败');
    }
  }
  // 下载图片: 移动端
  void _downloadImageForMobile(ImageItem item) async {
    Get.snackbar('提示', '移动端的保存图片功能还在开发中');
  }

  // 下载图片: 桌面
  void _downloadImageForDesktop(ImageItem item) async {
    final String? directoryPath = await getDirectoryPath();
    LogUtils.d('选择的目录：$directoryPath', 'ImageModelDetailContent');
    if (directoryPath == null) {
      LogUtils.d('用户取消了选择目录', 'ImageModelDetailContent');
      return;
    } else {
      String url = item.data.originalUrl.isEmpty ? item.data.url : item.data.originalUrl;
      if (url.isEmpty) {
        Get.snackbar('提示', '链接地址为空');
        return;
      }

      try {
        var apiService = await ApiService.getInstance();
        Uint8List bytes = (await apiService.dio
                .get(url, options: Options(responseType: ResponseType.bytes)))
            .data;
        final String filePath = '$directoryPath/${item.data.id}.png';
        await File(filePath).writeAsBytes(bytes);
        Get.snackbar('提示', '图片已保存到：$filePath');
      } catch (e) {
        Get.snackbar('提示', '保存图片失败');
      }
    }
  }

  // 构建图库详情区域
  Widget _buildGalleryDetails(BuildContext context) {
    return Obx(() {
      return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          _buildGalleryTitle(),
          const SizedBox(height: 8),
          _buildAuthorInfo(),
          const SizedBox(height: 8),
          _buildPublishInfo(),
          const SizedBox(height: 16),
          _buildGalleryDescription(),
          const SizedBox(height: 16),
          _buildTags(),
          const SizedBox(height: 16),
          _buildLikeAvatars(),
          const SizedBox(height: 16),
          _buildLikeAndCommentButtons(),
        ],
      );
    });
  }

  // 构建图库标题
  Widget _buildGalleryTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SelectableText(
        controller.imageModelInfo.value?.title ?? '',
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }

  // 构建作者信息区域
  Widget _buildAuthorInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          _buildAuthorAvatar(),
          const SizedBox(width: 8),
          _buildAuthorNameButton(),
        ],
      ),
    );
  }

  // 构建作者头像
  Widget _buildAuthorAvatar() {
    return InkWell(
      onTap: () {
        NaviService.navigateToAuthorProfilePage(
            controller.imageModelInfo.value?.user?.username ?? '');
      },
      borderRadius: BorderRadius.circular(20),
      child: CircleAvatar(
        backgroundImage: CachedNetworkImageProvider(
          controller.imageModelInfo.value?.user?.avatar?.avatarUrl ??
              CommonConstants.defaultAvatarUrl,
          headers: const {'referer': CommonConstants.iwaraBaseUrl},
        ),
      ),
    );
  }

  // 构建作者名字按钮
  Widget _buildAuthorNameButton() {
    return TextButton(
      child: Text(
        controller.imageModelInfo.value?.user?.username ?? '',
        style: const TextStyle(fontSize: 16),
      ),
      onPressed: () {
        NaviService.navigateToAuthorProfilePage(
            controller.imageModelInfo.value?.user?.username ?? '');
      },
    );
  }

  // 构建发布时间和观看次数
  Widget _buildPublishInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        '发布时间：${controller.imageModelInfo.value?.createdAt?.customFormat("SHORT_CHINESE")}    观看次数：${controller.imageModelInfo.value?.numViews?.customFormat()}',
        style: const TextStyle(color: Colors.grey),
      ),
    );
  }

  // 构建图库描述
  Widget _buildGalleryDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: MediaDescriptionWidget(
        description: controller.imageModelInfo.value?.body,
        isDescriptionExpanded: controller.isDescriptionExpanded,
      ),
    );
  }

  // 构建标签区域
  Widget _buildTags() {
    final tags = controller.imageModelInfo.value?.tags;
    if (tags != null && tags.isNotEmpty) {
      return ExpandableTagsWidget(tags: tags);
    }
    return const SizedBox.shrink();
  }

  // 构建点赞用户头像区域
  Widget _buildLikeAvatars() {
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
    }
    return const SizedBox.shrink();
  }

  // 构建点赞和评论按钮区域
  Widget _buildLikeAndCommentButtons() {
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
    }
    return const SizedBox.shrink();
  }
}
