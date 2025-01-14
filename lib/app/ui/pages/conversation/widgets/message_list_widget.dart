import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_iwara/app/models/message_and_conversation.model.dart';
import 'package:i_iwara/app/models/user.model.dart';
import 'package:i_iwara/app/services/app_service.dart';
import 'package:i_iwara/app/services/conversation_service.dart';
import 'package:i_iwara/app/services/user_service.dart';
import 'package:i_iwara/app/ui/widgets/avatar_widget.dart';
import 'package:i_iwara/app/ui/widgets/custom_markdown_body_widget.dart';
import 'package:i_iwara/app/ui/widgets/translation_dialog_widget.dart';
import 'package:i_iwara/app/ui/widgets/user_name_widget.dart';
import 'package:i_iwara/common/constants.dart';
import 'package:i_iwara/utils/common_utils.dart';
import 'package:i_iwara/utils/logger_utils.dart';
import 'package:loading_more_list/loading_more_list.dart';
import 'package:shimmer/shimmer.dart';

class MessageListWidget extends StatefulWidget {
  final ConversationModel conversation;
  final bool fromNarrowScreen;

  const MessageListWidget({
    super.key,
    required this.conversation,
    required this.fromNarrowScreen,
  });

  @override
  State<MessageListWidget> createState() => _MessageListWidgetState();
}

class _MessageListWidgetState extends State<MessageListWidget> {
  late MessageListRepository _messageListRepository;
  final ScrollController _scrollController = ScrollController();
  final UserService _userService = Get.find<UserService>();

  @override
  void initState() {
    super.initState();
    _messageListRepository = MessageListRepository(widget.conversation.id);
  }

  @override
  void dispose() {
    _messageListRepository.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: LoadingMoreCustomScrollView(
        controller: _scrollController,
        reverse: true,
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          LoadingMoreSliverList<MessageModel>(
            SliverListConfig<MessageModel>(
              sourceList: _messageListRepository,
              itemBuilder: (context, message, index) {
                return _buildMessageItem(context, message);
              },
              indicatorBuilder: _buildIndicator,
              padding: const EdgeInsets.all(8.0),
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget? _buildAppBar() {
    final otherParticipant = widget.conversation.participants.firstWhere(
      (user) => user.id != _userService.currentUser.value?.id,
      orElse: () => widget.conversation.participants.first,
    );

    return AppBar(
      // 窄屏来的要显示返回按钮
      leading: widget.fromNarrowScreen ? IconButton(
        onPressed: () => AppService.tryPop(),
        icon: const Icon(Icons.arrow_back),
      ) : const SizedBox.shrink(),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildUserName(context, otherParticipant, fontSize: 16),
          Text(
            '@${otherParticipant.username}',
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(context).hintColor,
            ),
          ),
        ],
      ),
      actions: [
        StreamBuilder<Iterable<MessageModel>>(
          stream: _messageListRepository.rebuild,
          builder: (context, snapshot) {
            final isLoading = _messageListRepository.isLoading && _messageListRepository.length == 0;
            return IconButton(
              onPressed: isLoading ? null : () => _messageListRepository.refresh(true),
              icon: isLoading
                ? Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: const Icon(Icons.refresh),
                  )
                : const Icon(Icons.refresh),
            );
          }
        ),
      ],
    );
  }

  Widget? _buildIndicator(BuildContext context, IndicatorStatus status) {
    Widget? widget;
    
    switch (status) {
      case IndicatorStatus.none:
        return null;
      case IndicatorStatus.loadingMoreBusying:
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: _buildShimmerItem(),
          ),
        );
      case IndicatorStatus.fullScreenBusying:
        widget = Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Column(
            children: List.generate(3, (index) => _buildShimmerItem()),
          ),
        );
        return SliverFillRemaining(child: widget);
      case IndicatorStatus.error:
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 0,
            color: Theme.of(context).colorScheme.errorContainer,
            child: InkWell(
              onTap: () => _messageListRepository.errorRefresh(),
              borderRadius: BorderRadius.circular(12),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      Icons.error_outline,
                      size: 20,
                      color: Theme.of(context).colorScheme.error,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '加载失败,点击重试',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      case IndicatorStatus.fullScreenError:
        widget = Card(
          elevation: 0,
          color: Theme.of(context).colorScheme.errorContainer,
          child: InkWell(
            onTap: () => _messageListRepository.errorRefresh(),
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(
                    Icons.error_outline,
                    size: 48,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '加载失败',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '点击重试',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onErrorContainer,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
        return SliverFillRemaining(
          hasScrollBody: false,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: widget,
            ),
          ),
        );
      case IndicatorStatus.noMoreLoad:
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              '没有更多消息了',
              style: TextStyle(
                color: Theme.of(context).textTheme.bodySmall?.color,
              ),
            ),
          ),
        );
      case IndicatorStatus.empty:
        widget = Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.chat_bubble_outline,
                size: 48,
                color: Theme.of(context).hintColor,
              ),
              const SizedBox(height: 16),
              Text(
                '暂无消息',
                style: TextStyle(
                  color: Theme.of(context).hintColor,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        );
        return SliverFillRemaining(
          hasScrollBody: false,
          child: Center(child: widget),
        );
    }
  }

  Widget _buildShimmerItem() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 100,
                      height: 14,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 50,
                      height: 12,
                      color: Colors.white,
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageItem(BuildContext context, MessageModel message) {
    final bool isMe = message.user.id == _userService.currentUser.value?.id;
    final ConversationService _conversationService = Get.find<ConversationService>();

    Future<void> _showDeleteConfirmation() async {
      await showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: Icon(
                    Icons.delete_outline,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  title: const Text('删除此消息'),
                  subtitle: const Text('此操作不可撤销'),
                  onTap: () async {
                    Navigator.pop(context);
                    final result = await _conversationService.deleteMessage(message.id);
                    if (result.isSuccess) {
                      _messageListRepository.refresh(true);
                    }
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.close),
                  title: const Text('取消'),
                  onTap: () => Navigator.pop(context),
                ),
              ],
            ),
          );
        },
      );
    }

    void _showTranslationDialog() {
      Get.dialog(
        TranslationDialog(text: message.body),
        barrierDismissible: true,
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isMe) _buildAvatar(message.user),
          const SizedBox(width: 8),
          Flexible(
            child: Column(
              crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (!isMe) Flexible(
                        child: buildUserName(context, message.user, fontSize: 13),
                      ),
                      if (!isMe) const SizedBox(width: 8),
                      Text(
                        CommonUtils.formatFriendlyTimestamp(message.createdAt),
                        style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      if (isMe) const SizedBox(width: 8),
                      if (isMe) Flexible(
                        child: buildUserName(context, message.user, fontSize: 13),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (isMe) ...[
                      IconButton(
                        icon: Icon(
                          Icons.delete_outline,
                          size: 18,
                          color: Theme.of(context).hintColor,
                        ),
                        onPressed: _showDeleteConfirmation,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(
                          minWidth: 24,
                          minHeight: 24,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.translate,
                          size: 18,
                          color: Theme.of(context).hintColor,
                        ),
                        onPressed: _showTranslationDialog,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(
                          minWidth: 24,
                          minHeight: 24,
                        ),
                      ),
                    ],
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isMe
                              ? Theme.of(context).primaryColor.withOpacity(0.1)
                              : Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(16),
                          border: !isMe ? Border.all(
                            color: Theme.of(context).dividerColor.withOpacity(0.5),
                            width: 0.5,
                          ) : null,
                        ),
                        child: CustomMarkdownBody(
                          data: message.body,
                          initialShowUnprocessedText: false,
                          clickInternalLinkByUrlLaunch: false,
                        ),
                      ),
                    ),
                    if (!isMe) IconButton(
                      icon: Icon(
                        Icons.translate,
                        size: 18,
                        color: Theme.of(context).hintColor,
                      ),
                      onPressed: _showTranslationDialog,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(
                        minWidth: 24,
                        minHeight: 24,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          if (isMe) _buildAvatar(message.user),
        ],
      ),
    );
  }

  Widget _buildAvatar(User user) {
    return AvatarWidget(
      avatarUrl: user.avatar?.avatarUrl,
      defaultAvatarUrl: CommonConstants.defaultAvatarUrl,
      radius: 20,
      isPremium: user.premium,
      isAdmin: user.isAdmin,
      role: user.role,
    );
  }
}

class MessageListRepository extends LoadingMoreBase<MessageModel> {
  final String conversationId;
  final ConversationService _conversationService = Get.find<ConversationService>();
  String? _lastMessageTime;
  bool _hasMoreMessages = true;
  
  MessageListRepository(this.conversationId);

  @override
  bool get hasMore => _hasMoreMessages;

  @override
  Future<bool> loadData([bool isLoadMoreAction = false]) async {
    try {
      // 第一次加载使用当前时间,之后使用上一次结果的last时间
      final before = isLoadMoreAction ? _lastMessageTime : DateTime.now().toIso8601String();
      
      final result = await _conversationService.getMessages(
        conversationId,
        before: before,
        limit: 100,
      );

      if (result.isSuccess && result.data != null) {
        final data = result.data!;
        // print('加载消息: before=$before, count=${data.count}, first=${data.first}, last=${data.last}, results=${data.results.length}');
        
        if (data.results.isEmpty) {
          _hasMoreMessages = false;
          return true;
        }

        // 记录最后一条消息的时间，用于下次加载
        _lastMessageTime = data.last.toIso8601String();
        
        // API返回的消息是从旧到新排序，但我们需要新消息在前面
        // 所以每次都需要反转消息顺序
        final reversedMessages = data.results.reversed.toList();
        
        // 第一次加载时，直接添加到列表前面
        // 加载更多时，添加到列表后面
        if (isLoadMoreAction) {
          addAll(reversedMessages);
        } else {
          addAll(reversedMessages);
        }

        // 如果返回的消息数量小于请求的数量，说明没有更多消息了
        _hasMoreMessages = data.results.length >= 2;
        
        return true;
      }
      return false;
    } catch (e) {
      // print('加载消息失败: $e');
      LogUtils.e('加载消息失败', tag: 'MessageListRepository', error: e);
      return false;
    }
  }

  @override
  Future<bool> refresh([bool notifyStateChanged = false]) async {
    _lastMessageTime = null;
    _hasMoreMessages = true;
    return super.refresh(notifyStateChanged);
  }

  @override
  void dispose() {
    super.dispose();
    clear();
  }
} 