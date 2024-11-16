import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_iwara/app/models/image.model.dart';
import 'package:i_iwara/app/services/app_service.dart';
import 'package:i_iwara/utils/date_time_extension.dart';

import '../../../../../common/constants.dart';
import '../../../../routes/app_routes.dart';

class ImageModelCardListItemWidget extends StatelessWidget {
  final ImageModel imageModel;
  final double width;

  const ImageModelCardListItemWidget({
    super.key,
    required this.imageModel,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    final double imageHeight = (width * 160) / 220;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return SizedBox(
      width: width,
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: InkWell(
          onTap: () => _navigateToDetailPage(),
          hoverColor: Theme.of(context).hoverColor.withOpacity(0.1),
          splashColor: Theme.of(context).splashColor.withOpacity(0.2),
          highlightColor: Theme.of(context).highlightColor.withOpacity(0.1),
          child: _buildCardContent(imageHeight, textTheme, context),
        ),
      ),
    );
  }

  Widget _buildCardContent(
      double imageHeight, TextTheme textTheme, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildThumbnail(imageHeight, context),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTitle(textTheme),
              _buildTimeInfo(textTheme),
              const SizedBox(height: 8),
              _buildAuthorInfo(textTheme, context),
            ],
          ),
        ),
      ],
    );
  }

  // 视频缩略图
  Widget _buildThumbnail(double imageHeight, BuildContext context) {
    return SizedBox(
      height: imageHeight,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: CachedNetworkImage(
              imageUrl: imageModel.thumbnailUrl,
              fit: BoxFit.cover,
              placeholder: (context, url) => _buildPlaceholder(),
              errorWidget: (context, url, error) =>
                  const Center(child: Icon(Icons.error, size: 50)),
            ),
          ),
          if (imageModel.rating == 'ecchi')
            Positioned(
              left: 0,
              bottom: 0,
              child: _buildRatingTag(context),
            ),
          // 左下角显示图片数量
          Positioned(
              right: 0,
              top: 0,
              child: _buildImageNums(context, imageModel.numImages)),
          // 右下角显示观看数量
          Positioned(
            right: 0,
            bottom: 0,
            child: _buildViewsNums(context, imageModel.numViews),
          ),
          // 左上角显示点赞数量
          Positioned(
            left: 0,
            top: 0,
            child: _buildLikeNums(context, imageModel.numLikes),
          )
        ],
      ),
    );
  }

  Widget _buildPlaceholder() => Container(color: Colors.grey[300]);

  Widget _buildRatingTag(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(14),
        bottomLeft: Radius.circular(12),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: const BoxDecoration(
          color: Colors.red,
        ),
        child: Text(
          'R18',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSecondary,
            fontWeight: FontWeight.bold,
            fontSize: Theme.of(context).textTheme.bodySmall?.fontSize,
            decoration: TextDecoration.none,
          ),
        ),
      ),
    );
  }

  Widget _buildLikeNums(BuildContext context, int likes) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(12),
        bottomRight: Radius.circular(14),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: const BoxDecoration(
          color: Color(0x99000000),
        ),
        // 显示点赞数量 + icon
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.favorite, size: 16, color: Colors.white),
            const SizedBox(width: 4),
            Text(
              likes.customFormat(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildViewsNums(BuildContext context, int views) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(14),
        bottomRight: Radius.circular(12),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: const BoxDecoration(
          color: Color(0x99000000),
        ),
        // 显示观看数量 + icon
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.remove_red_eye, size: 16, color: Colors.white),
            const SizedBox(width: 4),
            Text(
              views.customFormat(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageNums(BuildContext context, int numImages) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(14),
        bottomLeft: Radius.circular(12),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: const BoxDecoration(
          color: Color(0x99000000),
        ),
        // 显示图片数量 + icon
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.image, size: 16, color: Colors.white),
            const SizedBox(width: 4),
            Text(
              '$numImages',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(TextTheme textTheme) {
    return SizedBox(
      height: textTheme.bodyLarge!.fontSize! * 3.5,
      child: Text(
        imageModel.title ?? '',
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: textTheme.bodyLarge!.fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildTimeInfo(TextTheme textTheme) {
    return Text(
      imageModel.createdAt!.customFormat("SHORT_CHINESE"),
      style: textTheme.bodySmall,
    );
  }

  Widget _buildAuthorInfo(TextTheme textTheme, BuildContext context) {
    return GestureDetector(
      onTap: () => NaviService.navigateToAuthorProfilePage(
          imageModel.user?.username ?? ''),
      child: Row(
        children: [
          _buildAvatar(),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              imageModel.user?.name ?? 'Unknown User',
              style: textTheme.bodySmall,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    return SizedBox(
      width: 24,
      height: 24,
      child: ClipOval(
        child: CachedNetworkImage(
          imageUrl: imageModel.user?.avatar?.avatarUrl ?? '',
          httpHeaders: const {'referer': CommonConstants.iwaraBaseUrl},
          fit: BoxFit.cover,
          placeholder: (context, url) => _buildPlaceholder(),
          errorWidget: (context, url, error) =>
              const Icon(Icons.person, size: 24),
        ),
      ),
    );
  }

  void _navigateToDetailPage() {
    NaviService.navigateToGalleryDetailPage(imageModel.id);
  }
}
