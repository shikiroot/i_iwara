import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:i_iwara/app/models/user.model.dart';
import 'package:i_iwara/common/constants.dart';

class UserCard extends StatelessWidget {
  final User user;
  final VoidCallback? onTap;
  final bool showFriendOptions;
  final bool showFriendAcceptAndRejectOptions;
  final bool showCancelFriendRequestOption;
  final Function(String)? onRemoveFriend;
  final Function(String)? onAcceptFriendRequest;
  final Function(String)? onRejectFriendRequest;
  final Function(String)? onCancelFriendRequest;
  final bool isRemovingFriend;
  final bool isAcceptingRequest;
  final bool isRejectingRequest;
  final bool isCancelingRequest;
  final bool isRestoringFriend;

  const UserCard({
    super.key,
    required this.user,
    this.onTap,
    this.showFriendOptions = false,
    this.showFriendAcceptAndRejectOptions = false,
    this.showCancelFriendRequestOption = false,
    this.onRemoveFriend,
    this.onAcceptFriendRequest,
    this.onRejectFriendRequest,
    this.onCancelFriendRequest,
    this.isRemovingFriend = false,
    this.isAcceptingRequest = false,
    this.isRejectingRequest = false,
    this.isCancelingRequest = false,
    this.isRestoringFriend = false,
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
              _buildAvatar(),
              const SizedBox(width: 12),
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
              if (showFriendOptions && user.friend) ...[
                const SizedBox(width: 8),
                _buildRemoveFriendButton(context),
              ],
              if (showFriendAcceptAndRejectOptions) ...[
                const SizedBox(width: 8),
                _buildFriendRequestButtons(context),
              ],
              if (showCancelFriendRequestOption) ...[
                const SizedBox(width: 8),
                _buildCancelRequestButton(context),
              ],
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
            key: 'premium',
          ),
        if (user.friend)
          _buildTag(
            label: '好友',
            color: Colors.green.shade100,
            textColor: Colors.green,
            key: 'friend',
          ),
        if (user.following)
          _buildTag(
            label: '已关注',
            color: Colors.blue.shade100,
            textColor: Colors.blue,
            key: 'following',
          ),
        if (user.followedBy)
          _buildTag(
            label: '关注你',
            color: Colors.orange.shade100,
            textColor: Colors.orange,
            key: 'followedBy',
          ),
      ],
    );
  }

  Widget _buildTag({
    required String label,
    required Color color,
    required Color textColor,
    required String key,
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
          if (key == 'premium')
            Icon(Icons.stars, size: 14, color: textColor)
          else if (key == 'friend')
            Icon(Icons.favorite, size: 14, color: textColor)
          else if (key == 'following')
            Icon(Icons.check_circle, size: 14, color: textColor)
          else if (key == 'followedBy')
            Icon(Icons.person_add, size: 14, color: textColor),
          if (label != '') const SizedBox(width: 4),
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

  Widget _buildRemoveFriendButton(BuildContext context) {
    return IconButton(
      icon: isRemovingFriend
          ? const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : const Icon(Icons.person_remove),
      color: Colors.red,
      onPressed: isRemovingFriend ? null : () => onRemoveFriend?.call(user.id),
      tooltip: '删除好友',
    );
  }

  Widget _buildFriendRequestButtons(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: isAcceptingRequest
              ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.green,
                  ),
                )
              : const Icon(Icons.check_circle),
          color: Colors.green,
          onPressed: isAcceptingRequest ? null : () => onAcceptFriendRequest?.call(user.id),
          tooltip: '接受',
        ),
        IconButton(
          icon: isRejectingRequest
              ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.red,
                  ),
                )
              : const Icon(Icons.cancel),
          color: Colors.red,
          onPressed: isRejectingRequest ? null : () => onRejectFriendRequest?.call(user.id),
          tooltip: '拒绝',
        ),
      ],
    );
  }

  Widget _buildCancelRequestButton(BuildContext context) {
    return IconButton(
      icon: isCancelingRequest
          ? const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.orange,
              ),
            )
          : const Icon(Icons.person_remove),
      color: Colors.orange,
      onPressed: isCancelingRequest ? null : () => onCancelFriendRequest?.call(user.id),
      tooltip: '取消申请',
    );
  }
}
