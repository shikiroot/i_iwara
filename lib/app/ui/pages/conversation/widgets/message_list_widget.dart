import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_iwara/app/models/message_and_conversation.model.dart';
import 'package:i_iwara/app/models/user.model.dart';
import 'package:i_iwara/app/services/app_service.dart';
import 'package:i_iwara/app/services/conversation_service.dart';
import 'package:i_iwara/app/services/user_service.dart';
import 'package:i_iwara/app/ui/widgets/avatar_widget.dart';
import 'package:i_iwara/app/ui/widgets/user_name_widget.dart';
import 'package:i_iwara/common/constants.dart';
import 'package:i_iwara/utils/common_utils.dart';
import 'package:i_iwara/utils/logger_utils.dart';
import 'package:loading_more_list/loading_more_list.dart';

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
    );
  }

  Widget? _buildIndicator(BuildContext context, IndicatorStatus status) {
    Widget? widget;
    switch (status) {
      case IndicatorStatus.loadingMoreBusying:
        widget = const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
            SizedBox(width: 8),
            Text('加载中...'),
          ],
        );
        break;
      case IndicatorStatus.noMoreLoad:
        widget = const Center(child: Text('没有更多消息了'));
        break;
      case IndicatorStatus.error:
        widget = const Center(child: Text('加载失败'));
        break;
      default:
        break;
    }
    return widget != null
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: widget,
          )
        : null;
  }

  Widget _buildMessageItem(BuildContext context, MessageModel message) {
    final bool isMe = message.user.id == _userService.currentUser.value?.id;

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
                Container(
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
                  child: Text(
                    message.body,
                    style: const TextStyle(fontSize: 16),
                  ),
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
  void dispose() {
    super.dispose();
    clear();
  }
} 