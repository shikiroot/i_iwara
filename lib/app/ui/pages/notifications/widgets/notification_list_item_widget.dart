import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:i_iwara/app/models/comment.model.dart';
import 'package:i_iwara/app/models/user.model.dart';
import 'package:i_iwara/app/models/video.model.dart';
import 'package:i_iwara/app/services/app_service.dart';
import 'package:i_iwara/app/services/user_service.dart';
import 'package:i_iwara/app/ui/widgets/MDToastWidget.dart';
import 'package:i_iwara/i18n/strings.g.dart';
import 'package:i_iwara/utils/common_utils.dart';
import 'package:oktoast/oktoast.dart';
import 'package:shimmer/shimmer.dart';

class NotificationListItemWidget extends StatelessWidget {
  final Map<String, dynamic> notification;
  final UserService _userService = Get.find<UserService>();
  final RxBool _isMarkingAsRead = false.obs;

  NotificationListItemWidget({
    super.key,
    required this.notification,
  });

  @override
  Widget build(BuildContext context) {
    final type = notification['type'] as String;
    final createdAt = DateTime.parse(notification['createdAt'] as String);
    final read = notification['read'] as bool? ?? false;

    return Obx(() => _isMarkingAsRead.value
        ? Shimmer.fromColors(
            baseColor: Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.3),
            highlightColor: Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.6),
            child: _buildCard(context, type, createdAt, read),
          )
        : _buildCard(context, type, createdAt, read));
  }

  Widget _buildCard(BuildContext context, String type, DateTime createdAt, bool read) {
    return Card(
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () => _handleNotificationTap(type),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildNotificationContent(type, context, constraints),
                  const SizedBox(height: 12),
                  constraints.maxWidth < 300
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              CommonUtils.formatFriendlyTimestamp(createdAt),
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onSurfaceVariant,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 8),
                            _buildActionButtons(read, type, context),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              CommonUtils.formatFriendlyTimestamp(createdAt),
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onSurfaceVariant,
                                fontSize: 12,
                              ),
                            ),
                            _buildActionButtons(read, type, context),
                          ],
                        ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons(bool read, String type, BuildContext context) {
    return Wrap(
      spacing: 8,
      children: [
        if (!read)
          OutlinedButton.icon(
            icon: const Icon(Icons.mark_email_read, size: 16),
            label: Text(t.notifications.markAsRead,
                style: const TextStyle(fontSize: 12)),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            onPressed: _markAsRead,
          ),
        if (!_isKnownType(type))
          OutlinedButton.icon(
            icon: const Icon(Icons.copy, size: 16),
            label: Text(t.notifications.copy,
                style: const TextStyle(fontSize: 12)),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            onPressed: () => _copyNotificationData(),
          ),
      ],
    );
  }

  Future<void> _markAsRead() async {
    try {
      _isMarkingAsRead.value = true;
      final result = await _userService.markNotificationAsRead(notification['id']);
      if (result.isSuccess) {
        notification['read'] = true;
        await _userService.fetchUserNotificationCount();
        showToastWidget(
          MDToastWidget(
            message: t.notifications.markAsReadSuccess,
            type: MDToastType.success,
          ),
        );
      } else {
        showToastWidget(
          MDToastWidget(
            message: result.message,
            type: MDToastType.error,
          ),
        );
      }
    } finally {
      _isMarkingAsRead.value = false;
    }
  }

  Widget _buildNotificationContent(String type, BuildContext context, BoxConstraints constraints) {
    switch (type) {
      case 'newReply':
        if (notification['comment'] != null && notification['video'] != null) {
          final comment = Comment.fromJson(notification['comment']);
          final video = Video.fromJson(notification['video']);
          return _buildVideoReplyNotification(comment, video, context, constraints);
        }
        break;
      case 'newComment':
        if (notification['comment'] != null && notification['profile'] != null) {
          final comment = Comment.fromJson(notification['comment']);
          final commentUser = comment.user!;
          final profile = User.fromJson(notification['profile']);
          return _buildProfileCommentNotification(comment, commentUser, profile, context, constraints);
        }
        break;
    }
    return _buildUnsupportedNotification(type, context, constraints);
  }

  Widget _buildVideoReplyNotification(
      Comment comment, Video video, BuildContext context, BoxConstraints constraints) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            InkWell(
              onTap: () {
                if (comment.user?.username != null) {
                  NaviService.navigateToAuthorProfilePage(comment.user!.username);
                }
              },
              child: Text(
                comment.user?.name ?? t.notifications.errors.unknownUser,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(' ${t.notifications.repliedYourVideoComment}'),
          ],
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: () {
            if (video.id.isNotEmpty) {
              NaviService.navigateToVideoDetailPage(video.id);
            }
          },
          child: Container(
            constraints: BoxConstraints(maxWidth: constraints.maxWidth * 0.95),
            child: Text(
              '${t.notifications.video}: ${video.title}',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            comment.body,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              height: 1.4,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.9),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProfileCommentNotification(
      Comment comment, User commentUser, User profile, BuildContext context, BoxConstraints constraints) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          constraints: BoxConstraints(maxWidth: constraints.maxWidth * 0.95),
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  NaviService.navigateToAuthorProfilePage(commentUser.username);
                },
                child: Text(
                  commentUser.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(' ${t.notifications.inYour} '),
              InkWell(
                onTap: () {
                  NaviService.navigateToAuthorProfilePage(profile.username);
                },
                child: Text(
                  t.notifications.profile,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              Text(' ${t.notifications.postedNewComment}'),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            comment.body,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              height: 1.4,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.9),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUnsupportedNotification(String type, BuildContext context, BoxConstraints constraints) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.outlineVariant.withOpacity(0.5),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.info_outline,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                size: 20,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  t.notifications.errors.unsupportedNotificationType,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            t.notifications.errors.unsupportedNotificationTypeWithType(type: type),
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.8),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  void _handleNotificationTap(String type) {
    switch (type) {
      case 'newReply':
        if (notification['video'] != null) {
          final video = Video.fromJson(notification['video']);
          if (video.id.isNotEmpty) {
            NaviService.navigateToVideoDetailPage(video.id);
          }
        }
        break;
      case 'newComment':
        if (_userService.currentUser.value?.username != null) {
          NaviService.navigateToAuthorProfilePage(
              _userService.currentUser.value!.username);
        }
        break;
    }
  }

  bool _isKnownType(String type) {
    if (type == 'newReply') {
      return notification['comment'] != null && notification['video'] != null;
    } else if (type == 'newComment') {
      return notification['comment'] != null && notification['profile'] != null;
    }
    return false;
  }

  void _copyNotificationData() {
    final jsonStr = const JsonEncoder.withIndent('  ').convert(notification);
    Clipboard.setData(ClipboardData(text: jsonStr));
    showToastWidget(
      MDToastWidget(
        message: t.notifications.copySuccess,
        type: MDToastType.success,
      ),
    );
  }
}
