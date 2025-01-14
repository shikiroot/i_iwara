import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_iwara/app/models/message_and_conversation.model.dart';
import 'package:i_iwara/app/models/user.model.dart';
import 'package:i_iwara/app/services/conversation_service.dart';
import 'package:i_iwara/app/services/user_service.dart';

class MessageController extends GetxController {
  final ConversationService _conversationService = Get.find<ConversationService>();
  final UserService _userService = Get.find<UserService>();
  final ConversationModel conversation;
  final Function(ConversationModel)? onSuccessFetchData;

  MessageController(
    this.conversation, {
    this.onSuccessFetchData,
  });

  // 消息列表
  final RxList<MessageModel> messages = <MessageModel>[].obs;
  // 是否还有更多消息
  final RxBool hasMore = true.obs;
  // 是否正在加载
  final RxBool isLoading = false.obs;
  // 消息输入控制器
  TextEditingController? _messageController;
  // 滚动控制器
  ScrollController? _scrollController;
  // 错误信息
  final RxString errorMessage = ''.obs;

  TextEditingController get messageController {
    _messageController ??= TextEditingController();
    return _messageController!;
  }

  ScrollController get scrollController {
    _scrollController ??= ScrollController();
    return _scrollController!;
  }

  // 获取当前用户ID
  String get currentUserId => _userService.currentUser.value?.id ?? '';

  // 获取对话的另一方
  User get otherParticipant => conversation.participants.firstWhere(
        (user) => user.id != currentUserId,
        orElse: () => conversation.participants.first,
      );

  @override
  void onInit() {
    super.onInit();
    loadMessages();
  }

  @override
  void onClose() {
    _disposeControllers();
    super.onClose();
  }

  void _disposeControllers() {
    _messageController?.dispose();
    _messageController = null;
    _scrollController?.dispose();
    _scrollController = null;
  }

  // 加载消息
  Future<void> loadMessages({bool refresh = false}) async {
    if (refresh) {
      messages.clear();
      hasMore.value = true;
      errorMessage.value = '';
    }

    if (isLoading.value) return;

    try {
      isLoading.value = true;
      errorMessage.value = '';
      final result = await _conversationService.getMessages(
        conversation.id,
        limit: 20,
      );

      if (result.isSuccess && result.data != null) {
        messages.value = result.data!.results;
        hasMore.value = result.data!.results.length >= 20;
        // 标记会话为已读
        if (conversation.unread) {
          _markConversationAsRead();
        }
      } else {
        errorMessage.value = result.message;
      }
    } catch (e) {
      errorMessage.value = '加载失败，请重试';
    } finally {
      isLoading.value = false;
    }
  }

  // 标记会话为已读
  void _markConversationAsRead() {
    // 更新消息计数
    final userService = Get.find<UserService>();
    if (userService.messagesCount.value > 0) {
      userService.messagesCount.value--;
    }
    
    // 通知会话列表更新未读状态
    onSuccessFetchData?.call(conversation.copyWith(unread: false));
  }

  // 加载更多消息
  Future<void> loadMoreMessages() async {
    if (isLoading.value || !hasMore.value || messages.isEmpty) return;

    try {
      isLoading.value = true;
      errorMessage.value = '';
      final result = await _conversationService.getMessages(
        conversation.id,
        before: messages.last.id,
        limit: 20,
      );

      if (result.isSuccess && result.data != null) {
        messages.addAll(result.data!.results);
        hasMore.value = result.data!.results.length >= 20;
      } else {
        errorMessage.value = result.message;
      }
    } catch (e) {
      errorMessage.value = '加载失败，请重试';
    } finally {
      isLoading.value = false;
    }
  }

  // 刷新消息列表
  Future<void> refreshMessages() async {
    await loadMessages(refresh: true);
  }

  // 发送消息
  Future<void> sendMessage() async {
    final text = messageController.text.trim();
    if (text.isEmpty) return;

    // TODO: 实现发送消息的API
    // final result = await _conversationService.sendMessage(
    //   conversation.id,
    //   text,
    // );

    // if (result.success) {
    //   messageController.clear();
    //   await loadMessages();
    // }
  }
} 