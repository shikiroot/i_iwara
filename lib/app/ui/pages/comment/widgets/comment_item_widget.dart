import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_iwara/app/models/api_result.model.dart';
import 'package:i_iwara/app/services/app_service.dart';
import 'package:i_iwara/app/services/config_service.dart';
import 'package:i_iwara/app/services/translation_service.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../common/constants.dart';
import '../../../../models/comment.model.dart';
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
  bool _showTranslationMenu = false;
  bool _isTranslating = false;
  String? _translatedText;

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
              borderRadius: BorderRadius.horizontal(left: Radius.circular(20)),
              onTap: _isTranslating ? null : () => _handleTranslation(),
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 12, top: 6, bottom: 6),
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
            borderRadius: BorderRadius.horizontal(right: Radius.circular(20)),
            onTap: () =>
                setState(() => _showTranslationMenu = !_showTranslationMenu),
            child: Padding(
              padding: EdgeInsets.only(left: 8),
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
        color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
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
              // 原有的用户信息部分
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
                data: comment.body ?? '',
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
            })
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
