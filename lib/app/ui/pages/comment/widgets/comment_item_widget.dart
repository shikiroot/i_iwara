import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_iwara/app/models/api_result.model.dart';
import 'package:i_iwara/app/services/app_service.dart';
import 'package:i_iwara/app/services/config_service.dart';
import 'package:i_iwara/app/services/translation_service.dart';
import 'package:i_iwara/app/services/user_service.dart';
import 'package:i_iwara/app/services/comment_service.dart';
import 'package:i_iwara/app/ui/pages/comment/controllers/comment_controller.dart';
import 'package:i_iwara/app/ui/pages/comment/widgets/comment_remove_dialog.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../common/constants.dart';
import '../../../../models/comment.model.dart';
import '../../../widgets/custom_markdown_body_widget.dart';
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
  bool _isTranslationMenuVisible = false;
  bool _isTranslating = false;
  String? _translatedText;
  final UserService _userService = Get.find();
  final List<Comment> _replies = [];
  bool _isLoadingReplies = false;
  bool _hasMoreReplies = true;
  int _currentPage = 0;
  final int _pageSize = 20;
  String? _errorMessage;

  final TranslationService _translationService = Get.find();
  final ConfigService _configService = Get.find();
  final CommentService _commentService = Get.find();

  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();

  @override
  void initState() {
    super.initState();
  }

  Future<void> _fetchReplies({bool refresh = false}) async {
    if (refresh) {
      setState(() {
        _currentPage = 0;
        _replies.clear();
        _hasMoreReplies = true;
        _errorMessage = null;
      });
    }

    if (!_hasMoreReplies || _isLoadingReplies) return;

    setState(() {
      _isLoadingReplies = true;
    });

    try {
      String type;
      String id;
      if (widget.comment.videoId != null) {
        type = CommentType.video.name;
        id = widget.comment.videoId!;
      } else if (widget.comment.profileId != null) {
        type = CommentType.profile.name;
        id = widget.comment.profileId!;
      } else if (widget.comment.imageId != null) {
        type = CommentType.image.name;
        id = widget.comment.imageId!;
      } else {
        throw Exception('未知的评论类型');
      }

      final result = await _commentService.getComments(
        type: type,
        id: id,
        parentId: widget.comment.id,
        page: _currentPage,
        limit: _pageSize,
      );

      if (result.isSuccess) {
        final pageData = result.data!;
        final fetchedReplies = pageData.results;

        setState(() {
          _replies.addAll(fetchedReplies);
          _currentPage++;
          _hasMoreReplies = fetchedReplies.length >= _pageSize;
          _errorMessage = null;
        });
      } else {
        setState(() {
          _errorMessage = result.message;
          _hasMoreReplies = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = '获取回复时出错，请检查网络连接。';
        _hasMoreReplies = false;
      });
    } finally {
      setState(() {
        _isLoadingReplies = false;
      });
    }
  }

  void _handleViewReplies() {
    setState(() {
      _isRepliesExpanded = !_isRepliesExpanded;
    });

    if (_isRepliesExpanded && _replies.isEmpty && !_isLoadingReplies) {
      _fetchReplies(refresh: true);
    }
  }

  Widget _buildRepliesList() {
    if (_isLoadingReplies && _replies.isEmpty) {
      return Column(
        children: List.generate(
          widget.comment.numReplies, 
          (index) => _buildShimmerItem()
        ),
      );
    } else if (_errorMessage != null && _replies.isEmpty) {
      return Center(
        child: Text(
          _errorMessage!,
          style: const TextStyle(color: Colors.red),
        ),
      );
    } else if (!_isLoadingReplies && _replies.isEmpty) {
      return const Center(child: Text('暂无回复'));
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: _replies.length + (_hasMoreReplies ? 1 : 0),
          itemBuilder: (context, index) {
            if (index < _replies.length) {
              return CommentItem(
                comment: _replies[index],
                authorUserId: widget.authorUserId,
              );
            } else {
              if (_isLoadingReplies) {
                return _buildShimmerItem();
              } else if (_hasMoreReplies) {
                return TextButton(
                  onPressed: () {
                    if (!_isLoadingReplies) {
                      _fetchReplies();
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

  void _toggleTranslationMenu() {
    if (_isTranslationMenuVisible) {
      _overlayEntry?.remove();
      _overlayEntry = null;
    } else {
      _showTranslationMenuOverlay();
    }
    setState(() {
      _isTranslationMenuVisible = !_isTranslationMenuVisible;
    });
  }

  void _showTranslationMenuOverlay() {
    _overlayEntry?.remove();
    
    final overlay = Overlay.of(context);
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: 200,
        child: CompositedTransformFollower(
          link: _layerLink,
          offset: const Offset(0, 40),
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: CommonConstants.translationSorts.map((sort) {
                final isSelected = sort.id == _configService.currentTranslationSort.id;
                return ListTile(
                  dense: true,
                  selected: isSelected,
                  title: Text(sort.label),
                  onTap: () {
                    _configService.updateTranslationLanguage(sort);
                    _toggleTranslationMenu();
                    if (_translatedText != null) {
                      _handleTranslation();
                    }
                  },
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
    
    overlay.insert(_overlayEntry!);
  }

  @override
  void dispose() {
    _overlayEntry?.remove();
    super.dispose();
  }

  void _showTranslationMenuDialog() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  '选择翻译语言',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Divider(height: 1),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(Get.context!).size.height * 0.6,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: CommonConstants.translationSorts.map((sort) {
                      final isSelected = sort.id == _configService.currentTranslationSort.id;
                      return ListTile(
                        dense: true,
                        selected: isSelected,
                        title: Text(sort.label),
                        trailing: isSelected ? const Icon(Icons.check, size: 18) : null,
                        onTap: () {
                          _configService.updateTranslationLanguage(sort);
                          AppService.tryPop();
                          if (_translatedText != null) {
                            _handleTranslation();
                          }
                        },
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: true,
    );
  }

  Widget _buildTranslationButton() {
    return Material(
      borderRadius: BorderRadius.circular(20),
      elevation: 2,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 左侧翻译按钮
          InkWell(
            borderRadius: const BorderRadius.horizontal(left: Radius.circular(20)),
            onTap: _isTranslating ? null : () => _handleTranslation(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
          // 分割线
          Container(
            height: 24,
            width: 1,
            color: Colors.grey.withOpacity(0.2),
          ),
          // 右侧下拉按钮
          InkWell(
            borderRadius: const BorderRadius.horizontal(right: Radius.circular(20)),
            onTap: _showTranslationMenuDialog,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Icon(
                Icons.arrow_drop_down,
                size: 26,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ],
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
          
          // 获取父级评论控制器
          final commentController = Get.find<CommentController>(
            tag: widget.comment.videoId ??
                widget.comment.profileId ??
                widget.comment.imageId,
          );

          // 如果是主评论
          if (widget.comment.parent == null) {
            await commentController.editComment(widget.comment.id, text);
          } else {
            // 如果是回复评论
            final result = await _commentService.editComment(widget.comment.id, text);
            if (result.isSuccess) {
              setState(() {
                // 更新本地评论内容
                final index = _replies.indexWhere((c) => c.id == widget.comment.id);
                if (index != -1) {
                  _replies[index] = widget.comment.copyWith(
                    body: text,
                    updatedAt: DateTime.now(),
                  );
                }
              });
              Get.snackbar('成功', '评论已更新');
              AppService.tryPop();
            } else {
              Get.snackbar('错误', result.message);
            }
          }
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
          final result = await commentController.postComment(
            text,
            parentId: widget.comment.id,
          );
          
          // 如果发布成功且回复列表已展开，将新回复添加到列表开头
          if (result.isSuccess && result.data != null && _isRepliesExpanded) {
            setState(() {
              _replies.insert(0, result.data!);
            });
          }
        },
      ),
      barrierDismissible: true,
    );
  }

  // 新增操作菜单构建方法
  Widget _buildActionMenu() {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert, size: 16),
      padding: EdgeInsets.zero,
      itemBuilder: (context) => [
        if (widget.comment.parent == null)
          const PopupMenuItem(
            value: 'reply',
            child: Row(
              children: [
                Icon(Icons.reply, size: 16),
                SizedBox(width: 8),
                Text('回复', style: TextStyle(fontSize: 14)),
              ],
            ),
          ),
        if (_userService.currentUser.value?.id == widget.comment.user?.id) ...[
          const PopupMenuItem(
            value: 'edit',
            child: Row(
              children: [
                Icon(Icons.edit, size: 16),
                SizedBox(width: 8),
                Text('编辑', style: TextStyle(fontSize: 14)),
              ],
            ),
          ),
          const PopupMenuItem(
            value: 'delete',
            child: Row(
              children: [
                Icon(Icons.delete, size: 16),
                SizedBox(width: 8),
                Text('删除', style: TextStyle(fontSize: 14)),
              ],
            ),
          ),
        ],
      ],
      onSelected: (value) {
        switch (value) {
          case 'reply':
            _showReplyDialog();
            break;
          case 'edit':
            _showEditDialog();
            break;
          case 'delete':
            _showDeleteConfirmDialog();
            break;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final comment = widget.comment;

    return Padding(
      padding: EdgeInsets.only(
        left: comment.parent != null ? 32.0 : 16.0,
        right: 0.0,
        top: 8.0,
        bottom: 8.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 用户信息行
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 头像
              _buildUserAvatar(comment),
              const SizedBox(width: 8),
              // 用户名、标签等信息
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 用户名行
                    Row(
                      children: [
                        // 会员用户名
                        if (comment.user?.premium == true)
                          ShaderMask(
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
                        else
                          Text(
                            comment.user?.name ?? '未知用户',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        const SizedBox(width: 4),
                        // 各种标签
                        if (comment.user?.id == _userService.currentUser.value?.id)
                          _buildCommentTag('我', Colors.blue),
                        if (comment.user?.premium == true)
                          _buildCommentTag('会员', Colors.purple),
                        if (comment.user?.id == widget.authorUserId)
                          _buildCommentTag('作者', Colors.green),
                        if (comment.user?.role.contains('admin') == true)
                          _buildCommentTag('Admin', Colors.red),
                      ],
                    ),
                    // @用户名
                    Text(
                      '@${comment.user?.username ?? ''}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // 评论内容
          Padding(
            padding: const EdgeInsets.only(left: 48.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 评论内容 - 添加点击回复功能
                InkWell(
                  onTap: widget.comment.parent == null ? _showReplyDialog : null,
                  child: CustomMarkdownBody(data: comment.body),
                ),
                if (_translatedText != null) ...[
                  const SizedBox(height: 8),
                  _buildTranslatedContent(),
                ],
                const SizedBox(height: 8),
                // 时间和操作按钮行
                _buildTimeInfo(comment),
                Row(
                  children: [
                    // 回复 文本按钮
                    if (comment.parent == null) ...[
                      TextButton(
                        onPressed: () => _showReplyDialog(),
                        child: Text(
                            '回复',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                    // 添加查看回复按钮行
                    if (widget.comment.numReplies > 0) ...[
                      const SizedBox(height: 8),
                      TextButton(
                        onPressed: _handleViewReplies,
                        child: Row(
                          children: [
                            Text(
                              _isRepliesExpanded ? '隐藏回复' : '查看回复 (${widget.comment.numReplies})',
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
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
                    ],
                    const Spacer(),
                    // 翻译按钮
                    _buildTranslationButton(),
                    // 操作菜单
                    _buildActionMenu(),
                  ],
                ),
              ],
            ),
          ),
          // 回复列表
          if (_isRepliesExpanded) _buildRepliesList(),
        ],
      ),
    );
  }

  // 构建用户头像
  Widget _buildUserAvatar(Comment comment) {
    Widget avatar = CircleAvatar(
      radius: 20,
      backgroundImage: CachedNetworkImageProvider(
        comment.user?.avatar?.avatarUrl ?? CommonConstants.defaultAvatarUrl,
        headers: const {'referer': CommonConstants.iwaraBaseUrl},
      ),
    );

    if (comment.user?.premium == true) {
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
          padding: const EdgeInsets.all(2.0),
          child: avatar,
        ),
      );
    }

    return avatar;
  }

  /// 辅助方法，将数字补齐为两位
  String _twoDigits(int n) => n.toString().padLeft(2, '0');
}
