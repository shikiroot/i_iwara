import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:i_iwara/app/models/user.model.dart';
import 'package:i_iwara/common/constants.dart';

class UserCard extends StatelessWidget {
  final User user;
  final VoidCallback? onTap;
  final bool showFriendOptions;

  const UserCard({
    super.key,
    required this.user,
    this.onTap,
    this.showFriendOptions = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              // Avatar with premium effect
              _buildAvatar(),
              const SizedBox(width: 12),
              // User info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDisplayName(),
                    if (user.name.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      _buildUserName(),
                    ],
                    const SizedBox(height: 8),
                    _buildTags(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    Widget avatar = CircleAvatar(
      radius: 30,
      backgroundImage: CachedNetworkImageProvider(
          user.avatar?.avatarUrl ?? CommonConstants.defaultAvatarUrl,
        headers: const {'referer': CommonConstants.iwaraBaseUrl},
      ),
    );

    if (user.premium) {
      return Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [
              Colors.purple.shade200,
              Colors.blue.shade200,
              Colors.pink.shade200,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0), // 增加边框宽度
          child: avatar,
        ),
      );
    }

    return avatar;
  }

  Widget _buildUserName() {
    if (user.name.isEmpty) {
      return Text(
        '@${user.username}',
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );
    }
    return Text(
      '@${user.username}',
      style: const TextStyle(
        fontSize: 14,
        color: Colors.grey,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildDisplayName() {
    if (!user.premium) {
      return Text(
        user.name,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );
    }

    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        colors: [
          Colors.purple.shade300,
          Colors.blue.shade300,
          Colors.pink.shade300,
        ],
      ).createShader(bounds),
      child: Text(
        user.name,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildTags() {
    return Wrap(
      spacing: 4,
      runSpacing: 4,
      children: [
        if (user.premium)
          _buildTag(
            label: 'PREMIUM',
            color: Colors.purple.shade100,
            textColor: Colors.purple,
          ),
        if (user.friend)
          _buildTag(
            label: '好友',
            color: Colors.green.shade100,
            textColor: Colors.green,
          ),
        if (user.following)
          _buildTag(
            label: '已关注',
            color: Colors.blue.shade100,
            textColor: Colors.blue,
          ),
        if (user.followedBy)
          _buildTag(
            label: '关注你',
            color: Colors.orange.shade100,
            textColor: Colors.orange,
          ),
      ],
    );
  }

  Widget _buildTag({
    required String label,
    required Color color,
    required Color textColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.4),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (label == 'PREMIUM')
            Icon(Icons.stars, size: 14, color: textColor)
          else if (label == '好友')
            Icon(Icons.favorite, size: 14, color: textColor)
          else if (label == '已关注')
            Icon(Icons.check_circle, size: 14, color: textColor)
          else if (label == '关注你')
            Icon(Icons.person_add, size: 14, color: textColor),
          if (label != '')
            const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
