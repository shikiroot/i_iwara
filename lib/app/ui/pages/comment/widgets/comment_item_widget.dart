import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_iwara/app/services/app_service.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../common/constants.dart';
import '../../../../models/comment.model.dart';
import '../../../../routes/app_routes.dart';
import '../../../widgets/custom_markdown_body_widget.dart';
import '../controllers/comment_reply_controller.dart';


class CommentItem extends StatefulWidget {
  final Comment comment;
  final String? authorUserId;

  const CommentItem({super.key, required this.comment, this.authorUserId});

  @override
  _CommentItemState createState() => _CommentItemState();
}

class _CommentItemState extends State<CommentItem> {
  bool _isRepliesExpanded = false;

  ReplyController? _replyController;

  @override
  void initState() {
    super.initState();
    // 如果没有回复则不初始化控制器
    if (widget.comment.numReplies == null || widget.comment.numReplies == 0) {
      return;
    }
    _replyController = Get.put(
      ReplyController(
          videoId: widget.comment.videoId ?? '',
          profileId: widget.comment.profileId ?? '',
          parentId: widget.comment.id),
      tag: widget.comment.id,
    );
  }

  @override
  void dispose() {
    // 释放控制器
    Get.delete<ReplyController>(tag: widget.comment.id);
    super.dispose();
  }

  /// 构建 Shimmer 占位符
  Widget _buildShimmerItem() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Padding(
        padding: EdgeInsets.only(
          left: widget.comment.parent != null ? 32.0 : 16.0,
          right: 16.0,
          top: 8.0,
          bottom: 8.0,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 头像占位符
            const CircleAvatar(
              backgroundColor: Colors.white,
              radius: 20,
            ),
            const SizedBox(width: 8),
            // 文本占位符
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(height: 10.0, color: Colors.white),
                  const SizedBox(height: 6.0),
                  Container(height: 10.0, width: 150.0, color: Colors.white),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final comment = widget.comment;

    // 构建头像
    Widget avatar = CircleAvatar(
      radius: 20,
      backgroundImage: CachedNetworkImageProvider(
        comment.user?.avatar?.avatarUrl ?? CommonConstants.defaultAvatarUrl,
        headers: const {'referer': CommonConstants.iwaraBaseUrl},
      ),
    );

    if (comment.user?.premium == true) {
      avatar = Container(
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
          padding: const EdgeInsets.all(4.0),
          child: avatar,
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.only(
        left: comment.parent != null ? 32.0 : 16.0,
        right: 16.0,
        top: 8.0,
        bottom: 8.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 评论头部
          InkWell(
            onTap: () {
              NaviService.navigateToAuthorProfilePage(
                  comment.user?.username ?? ''
              );
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                avatar,
                const SizedBox(width: 8),
                // 用户名和时间戳
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      comment.user?.premium == true
                        ? ShaderMask(
                            shaderCallback: (bounds) => LinearGradient(
                              colors: [
                                Colors.purple.shade300,
                                Colors.blue.shade300,
                                Colors.pink.shade300,
                              ],
                            ).createShader(bounds),
                            child: Text(
                              comment.user?.name ?? '未知用户',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          )
                        : Text(
                            comment.user?.name ?? '未知用户',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                      const SizedBox(height: 2),
                      if (comment.createdAt != null)
                        Text(
                          _formatTimestamp(comment.createdAt!),
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          // 评论内容（Markdown格式）
          CustomMarkdownBody(data: comment.body ?? ''),
          // 查看回复按钮
          if (comment.numReplies != null && comment.numReplies! > 0)
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: TextButton(
                onPressed: () {
                  setState(() {
                    _isRepliesExpanded = !_isRepliesExpanded;
                  });

                  // 展开回复时，如果还未加载，则进行加载
                  if (_isRepliesExpanded &&
                      _replyController?.replies.isEmpty == true &&
                      _replyController?.isLoading.value == false) {
                    _replyController?.fetchReplies(refresh: true);
                  }
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(50, 30),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  _isRepliesExpanded ? '隐藏回复' : '查看回复 (${comment.numReplies})',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          // 回复列表
          if (_isRepliesExpanded && _replyController != null)
            Obx(() {
              if (_replyController!.isLoading.value &&
                  _replyController!.replies.isEmpty) {
                // 显示 Shimmer 占位符
                return Column(
                  children: List.generate(
                      comment.numReplies ?? 3, (index) => _buildShimmerItem()),
                );
              } else if (_replyController!.errorMessage.value.isNotEmpty &&
                  _replyController!.replies.isEmpty) {
                return Center(
                  child: Text(
                    _replyController!.errorMessage.value,
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              } else if (!_replyController!.isLoading.value &&
                  _replyController!.replies.isEmpty) {
                return const Center(child: Text('暂无回复'));
              } else {
                return Column(
                  children: [
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _replyController!.replies.length +
                          (_replyController!.hasMore.value ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index < _replyController!.replies.length) {
                          Comment reply = _replyController!.replies[index];
                          return CommentItem(comment: reply);
                        } else {
                          // 加载更多提示
                          if (_replyController!.isLoading.value) {
                            return _buildShimmerItem();
                          } else if (_replyController!.hasMore.value) {
                            return TextButton(
                              onPressed: () {
                                if (!_replyController!.isLoading.value) {
                                  _replyController!.fetchReplies();
                                }
                              },
                              child: const Text('加载更多回复'),
                            );
                          } else {
                            return const Center(child: Text('没有更多回复了'));
                          }
                        }
                      },
                    ),
                  ],
                );
              }
            }),
        ],
      ),
    );
  }

  /// 辅助方法，用于格式化时间戳
  String _formatTimestamp(DateTime timestamp) {
    // 根据需要自定义时间格式
    return "${timestamp.year}-${_twoDigits(timestamp.month)}-${_twoDigits(timestamp.day)} "
        "${_twoDigits(timestamp.hour)}:${_twoDigits(timestamp.minute)}:${_twoDigits(timestamp.second)}";
  }

  /// 辅助方法，将数字补齐为两位
  String _twoDigits(int n) => n.toString().padLeft(2, '0');
}
