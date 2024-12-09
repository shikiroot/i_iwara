import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_iwara/app/models/api_result.model.dart';
import 'package:i_iwara/app/services/app_service.dart';
import 'package:i_iwara/app/services/config_service.dart';
import 'package:i_iwara/app/services/translation_service.dart';
import 'package:i_iwara/app/services/user_service.dart';
import 'package:i_iwara/app/ui/pages/comment/controllers/comment_controller.dart';
import 'package:i_iwara/app/ui/pages/comment/widgets/comment_remove_dialog.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../common/constants.dart';
import '../../../../models/comment.model.dart';
import '../../../widgets/custom_markdown_body_widget.dart';
import '../controllers/comment_reply_controller.dart';
import '../widgets/comment_input_dialog.dart';

class CommentItem extends StatefulWidget {
  final Comment comment;
  final String? authorUserId;

  static const double _tagFontSize = 11.0;
  static const EdgeInsets _tagPadding =
      EdgeInsets.symmetric(horizontal: 6, vertical: 2);

  const CommentItem({super.key, required this.comment, this.authorUserId});

  @override
  _CommentItemState createState() => _CommentItemState();
}

class _CommentItemState extends State<CommentItem> {
  bool _isRepliesExpanded = false;
  bool _showTranslationMenu = false;
  bool _isTranslating = false;
  String? _translatedText;
  final UserService _userService = Get.find();

  final TranslationService _translationService = Get.find();
  final ConfigService _configService = Get.find();

  ReplyController? _replyController;

  @override
  void initState() {
    super.initState();
    // 如果没有回复则不初始化控制器
    if (widget.comment.numReplies == 0) {
      return;
    }

    _replyController = Get.put(
      ReplyController(
          videoId: widget.comment.videoId ?? '',
          profileId: widget.comment.profileId ?? '',
          imageId: widget.comment.imageId ?? '',
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
          right: 0.0,
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

  Widget _buildTranslationButton() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 左侧翻译按钮
          Flexible(
            child: InkWell(
              borderRadius:
                  const BorderRadius.horizontal(left: Radius.circular(20)),
              onTap: _isTranslating ? null : () => _handleTranslation(),
              child: Padding(
                padding: const EdgeInsets.only(left: 12, top: 6, bottom: 6),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (_isTranslating)
                      const SizedBox(
                        width: 14,
                        height: 14,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    else
                      const Icon(Icons.translate, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      '翻译',
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // 分割线
          Container(
            height: 24,
            width: 1,
            color: Colors.grey.withOpacity(0.2),
          ),
          // 右侧下拉按钮
          InkWell(
            borderRadius:
                const BorderRadius.horizontal(right: Radius.circular(20)),
            onTap: () =>
                setState(() => _showTranslationMenu = !_showTranslationMenu),
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Icon(
                _showTranslationMenu
                    ? Icons.arrow_drop_up
                    : Icons.arrow_drop_down,
                size: 26,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTranslationMenu() {
    return Card(
      elevation: 4,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: CommonConstants.translationSorts.map((sort) {
          final isSelected =
              sort.id == _configService.currentTranslationSort.id;
          return ListTile(
            dense: true,
            selected: isSelected,
            title: Text(sort.label),
            onTap: () {
              _configService.updateTranslationLanguage(sort);
              setState(() {
                _showTranslationMenu = false;
                _translatedText = null;
              });
              _handleTranslation();
            },
          );
        }).toList(),
      ),
    );
  }

  Future<void> _handleTranslation() async {
    if (_isTranslating) return;

    setState(() => _isTranslating = true);

    ApiResult<String> result =
        await _translationService.translate(widget.comment.body);
    if (result.isSuccess) {
      setState(() {
        _translatedText = result.data;
        _isTranslating = false;
      });
    } else {
      setState(() {
        _translatedText = '翻译失败，请稍后重试';
        _isTranslating = false;
      });
    }
  }

  // 构建翻译后的内容区域
  Widget _buildTranslatedContent() {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context)
            .colorScheme
            .surfaceContainerHighest
            .withOpacity(0.3),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.translate, size: 14),
              const SizedBox(width: 4),
              Text(
                '翻译结果',
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              const Spacer(),
              Text(
                'Powered by Google',
                style: TextStyle(
                  fontSize: 10,
                  color: Theme.of(context)
                      .colorScheme
                      .onSurfaceVariant
                      .withOpacity(0.7),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          if (_translatedText == '翻译失败，请稍后重试')
            Text(
              _translatedText!,
              style: TextStyle(
                color: Theme.of(context).colorScheme.error,
                fontSize: 14,
              ),
            )
          else
            CustomMarkdownBody(
              data: _translatedText!,
            ),
        ],
      ),
    );
  }

  // 添加这个方法来构建标签
  Widget _buildCommentTag(String text, Color color) {
    return Container(
      margin: const EdgeInsets.only(right: 4),
      padding: CommentItem._tagPadding,
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withOpacity(0.5),
          width: 1,
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: CommentItem._tagFontSize,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  /// 格式化时间为人性化显示
  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) {
      return '刚刚';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes}分钟前';
    } else if (difference.inDays < 1) {
      return '${difference.inHours}小时前';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}天前';
    } else {
      return "${timestamp.year}-${_twoDigits(timestamp.month)}-${_twoDigits(timestamp.day)} "
          "${_twoDigits(timestamp.hour)}:${_twoDigits(timestamp.minute)}";
    }
  }

  /// 构建时间显示区域
  Widget _buildTimeInfo(Comment comment) {
    if (comment.createdAt == null) return const SizedBox.shrink();

    final hasEdit = comment.updatedAt != null &&
        comment.createdAt != null &&
        comment.updatedAt!.isAfter(comment.createdAt!);

    final timeTextStyle = TextStyle(
      fontSize: 12,
      color: Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.75),
    );

    return DefaultTextStyle(
      style: timeTextStyle,
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text(_formatTimestamp(comment.createdAt!)),
          if (hasEdit) ...[
            const Text(' · '),
            Text(
              '编辑于${_formatTimestamp(comment.updatedAt!)}',
              style: timeTextStyle.copyWith(),
            ),
          ],
        ],
      ),
    );
  }

  void _showDeleteConfirmDialog() {
    final commentController = Get.find<CommentController>(
      tag: widget.comment.videoId ??
          widget.comment.profileId ??
          widget.comment.imageId,
    );

    Get.dialog(
      CommentRemoveDialog(
        onDelete: () async {
          await commentController.deleteComment(widget.comment.id);
          AppService.tryPop();
        },
      ),
    );
  }

  void _showEditDialog() {
    final commentController = Get.find<CommentController>(
      tag: widget.comment.videoId ??
          widget.comment.profileId ??
          widget.comment.imageId,
    );

    Get.dialog(
      CommentInputDialog(
        initialText: widget.comment.body,
        title: '编辑评论',
        submitText: '保存',
        onSubmit: (text) async {
          if (text.trim().isEmpty) {
            Get.snackbar('错误', '评论内容不能为空');
            return;
          }
          await commentController.editComment(widget.comment.id, text);
        },
      ),
      barrierDismissible: true,
    );
  }

  void _showReplyDialog() {
    final commentController = Get.find<CommentController>(
      tag: widget.comment.videoId ??
          widget.comment.profileId ??
          widget.comment.imageId,
    );

    Get.dialog(
      CommentInputDialog(
        title: '回复评论',
        submitText: '回复',
        onSubmit: (text) async {
          if (text.trim().isEmpty) {
            Get.snackbar('错误', '评论内容不能为空');
            return;
          }
          await commentController.postComment(
            text,
            parentId: widget.comment.id,
          );
        },
      ),
      barrierDismissible: true,
    );
  }


  // 在评论内容下方添加回复按钮
  Widget _buildCommentActions() {
    return Row(
      children: [
        if (widget.comment.parent == null)
          IconButton(
            icon: const Icon(Icons.reply, size: 16),
            onPressed: _showReplyDialog,
            tooltip: '回复',
          ),
        if (_userService.currentUser.value?.id == widget.comment.user?.id) ...[
          IconButton(
            icon: const Icon(Icons.edit, size: 16),
            onPressed: _showEditDialog,
            tooltip: '编辑',
          ),
          IconButton(
            icon: const Icon(Icons.delete, size: 16),
            onPressed: _showDeleteConfirmDialog,
            tooltip: '删除',
          ),
        ],
      ],
    );
  }

  // 在 build 方法中的用户信息行添加编辑和删除按钮
  Widget _buildUserActions() {
    final currentUserId = _userService.currentUser.value?.id;
    if (currentUserId != widget.comment.user?.id) {
      return const SizedBox.shrink();
    }

    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.edit, size: 16),
          onPressed: _showEditDialog,
          tooltip: '编辑',
        ),
        IconButton(
          icon: const Icon(Icons.delete, size: 16),
          onPressed: _showDeleteConfirmDialog,
          tooltip: '删除',
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final comment = widget.comment;
    final currentUserId = _userService.currentUser.value?.id;

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
        right: 2,
        top: 8.0,
        bottom: 8.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    NaviService.navigateToAuthorProfilePage(
                        comment.user?.username ?? '');
                  },
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      avatar,
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // 用户名行
                            Row(
                              children: [
                                // 用户名
                                Flexible(
                                  child: comment.user?.premium == true
                                      ? ShaderMask(
                                          shaderCallback: (bounds) =>
                                              LinearGradient(
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
                                ),
                                const SizedBox(width: 4),
                                // 标签
                                if (widget.authorUserId != null &&
                                    comment.user?.id == widget.authorUserId)
                                  _buildCommentTag(
                                    '作者',
                                    Theme.of(context).colorScheme.primary,
                                  ),
                                if (currentUserId != null &&
                                    comment.user?.id == currentUserId)
                                  _buildCommentTag(
                                    '我',
                                    Theme.of(context).colorScheme.secondary,
                                  ),
                              ],
                            ),
                            const SizedBox(height: 2),
                            _buildTimeInfo(comment),
                          ],
                        ),
                      ),
                      _buildCommentActions(),
                    ],
                  ),
                ),
              ),
              _buildTranslationButton(),
            ],
          ),
          if (_showTranslationMenu)
            Align(
              alignment: Alignment.centerRight,
              child: _buildTranslationMenu(),
            ),
          const SizedBox(height: 8),
          // 评论内容
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 原始评论内容
              CustomMarkdownBody(
                data: comment.body,
              ),

              // 如果有翻译内容，显示分割线和翻译
              if (_translatedText != null) ...[
                const SizedBox(height: 12),
                _buildTranslatedContent(),
              ],
            ],
          ),
          // 查看回复按钮
          if (comment.numReplies > 0)
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
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
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _isRepliesExpanded
                            ? '隐藏回复'
                            : '查看回复 (${comment.numReplies})',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 13,
                        ),
                      ),
                      Icon(
                        _isRepliesExpanded
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        size: 16,
                        color: Theme.of(context).primaryColor,
                      ),
                    ],
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
                      comment.numReplies, (index) => _buildShimmerItem()),
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _replyController!.replies.length +
                          (_replyController!.hasMore.value ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index < _replyController!.replies.length) {
                          Comment reply = _replyController!.replies[index];
                          return CommentItem(
                            comment: reply,
                            authorUserId: widget.authorUserId,
                          );
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
            })
        ],
      ),
    );
  }

  /// 辅助方法，将数字补齐为两位
  String _twoDigits(int n) => n.toString().padLeft(2, '0');
}
