// avatar_widget.dart
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AvatarWidget extends StatelessWidget {
  final String? avatarUrl;
  final double radius;
  final Map<String, String>? headers;
  final String defaultAvatarUrl;
  final bool isPremium;
  final bool isAdmin;
  final String? role;
  final double borderWidth;
  final Function()? onTap;
  const AvatarWidget({
    super.key,
    this.avatarUrl,
    this.radius = 20,
    this.headers,
    required this.defaultAvatarUrl,
    this.isPremium = false,
    this.isAdmin = false,
    this.role,
    this.borderWidth = 2.0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final avatar = CachedNetworkImage(
      imageUrl: avatarUrl ?? defaultAvatarUrl,
      imageBuilder: (context, imageProvider) => CircleAvatar(
        radius: radius - borderWidth, // 减去边框宽度
        backgroundImage: imageProvider,
      ),
      httpHeaders: headers,
      errorWidget: (context, url, error) => CircleAvatar(
        radius: radius - borderWidth,
        backgroundImage: NetworkImage(defaultAvatarUrl),
        onBackgroundImageError: (exception, stackTrace) => Icon(
          Icons.person,
          size: radius - borderWidth,
        ),
      ),
      placeholder: (context, url) => Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: CircleAvatar(
          radius: radius - borderWidth,
          backgroundColor: Colors.white,
        ),
      ),
    );

    // 优先判断是否是会员或管理员
    if (isPremium) {
      return _buildBorderedAvatar(
        avatar,
        LinearGradient(
          colors: [
            Colors.purple.shade200,
            Colors.blue.shade200,
            Colors.pink.shade200,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      );
    } else if (isAdmin) {
      return _buildBorderedAvatar(
        avatar,
        LinearGradient(
          colors: [
            Colors.red.shade400,
            Colors.orange.shade400,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      );
    }

    // 根据角色显示不同的边框
    switch (role) {
      case 'officer':
      case 'moderator':
        return _buildBorderedAvatar(
          avatar,
          LinearGradient(
            colors: [
              Colors.green.shade400,
              Colors.teal.shade400,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        );
      case 'admin':
        return _buildBorderedAvatar(
          avatar,
          LinearGradient(
            colors: [
              Colors.red.shade400,
              Colors.orange.shade400,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        );
      case 'limited':
        return _buildBorderedAvatar(
          avatar,
          LinearGradient(
            colors: [
              Colors.grey.shade400,
              Colors.grey.shade600,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        );
      default:
        // 普通用户添加透明边框，保持一致的大小
        return Container(
          width: radius * 2,
          height: radius * 2,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.transparent,
          ),
          child: Padding(
            padding: EdgeInsets.all(borderWidth),
            child: avatar,
          ),
        );
    }
  }

  Widget _buildBorderedAvatar(Widget avatar, Gradient gradient) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: radius * 2,
        height: radius * 2,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: gradient,
        ),
        child: Padding(
          padding: EdgeInsets.all(borderWidth),
          child: avatar,
        ),
      ),
    );
  }
}
