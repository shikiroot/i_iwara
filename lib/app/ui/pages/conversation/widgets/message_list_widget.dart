import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_iwara/app/models/message_and_conversation.model.dart';
import 'package:i_iwara/app/services/app_service.dart';
import 'package:i_iwara/app/ui/pages/conversation/controllers/message_controller.dart';
import 'package:i_iwara/app/ui/widgets/avatar_widget.dart';
import 'package:i_iwara/common/constants.dart';
import 'package:i_iwara/utils/common_utils.dart';
import 'package:shimmer/shimmer.dart';

class MessageListWidget extends StatelessWidget {
  final ConversationModel conversation;
  final bool fromNarrowScreen; // 是否从窄屏进入
  final Function(ConversationModel)? onSuccessFetchData;

  const MessageListWidget({
    super.key,
    required this.conversation,
    this.fromNarrowScreen = false,
    this.onSuccessFetchData,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MessageController>(
      init: MessageController(
        conversation,
        onSuccessFetchData: onSuccessFetchData,
      ),
      dispose: (state) {
        // 确保在下一帧执行销毁操作
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Get.delete<MessageController>();
        });
      },
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: Text(controller.otherParticipant.name),
          leading: Builder(
            builder: (context) {
              // 如果是从窄屏进入，或者当前是窄屏且之前是从窄屏进入
              final bool isNarrowScreen = MediaQuery.of(context).size.width <= 600;
              final bool shouldShowBackButton = fromNarrowScreen && (isNarrowScreen || !isNarrowScreen);
              
              return shouldShowBackButton 
                ? IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => AppService.homeNavigatorKey.currentState?.pop(),
                  )
                : const SizedBox.shrink();
            },
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              // 消息列表
              Expanded(
                child: Obx(
                  () => ListView.builder(
                    reverse: true,
                    controller: controller.scrollController,
                    itemCount: controller.messages.length + 1,
                    itemBuilder: (context, index) {
                      if (index == controller.messages.length) {
                        // 加载更多
                        if (controller.hasMore.value) {
                          controller.loadMoreMessages();
                          return Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // 头像占位
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
                                        // 时间占位
                                        Container(
                                          width: 100,
                                          height: 12,
                                          color: Colors.white,
                                        ),
                                        const SizedBox(height: 8),
                                        // 消息内容占位
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
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      }

                      final message = controller.messages[index];
                      final bool isMe = message.user.id == controller.currentUserId;

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 8.0,
                        ),
                        child: Row(
                          mainAxisAlignment:
                              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (!isMe) ...[
                              AvatarWidget(
                                avatarUrl: message.user.avatar?.avatarUrl,
                                defaultAvatarUrl: CommonConstants.defaultAvatarUrl,
                                radius: 20,
                                isPremium: message.user.premium,
                                isAdmin: message.user.isAdmin,
                                role: message.user.role,
                              ),
                              const SizedBox(width: 8),
                            ],
                            Flexible(
                              child: Column(
                                crossAxisAlignment: isMe
                                    ? CrossAxisAlignment.end
                                    : CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    CommonUtils.formatFriendlyTimestamp(message.createdAt),
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Theme.of(context).hintColor,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Container(
                                    constraints: BoxConstraints(
                                      maxWidth:
                                          MediaQuery.of(context).size.width * 0.7,
                                    ),
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: isMe
                                          ? Theme.of(context).primaryColor
                                          : Theme.of(context).cardColor,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Text(
                                      message.body,
                                      style: TextStyle(
                                        color: isMe ? Colors.white : null,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (isMe) ...[
                              const SizedBox(width: 8),
                              AvatarWidget(
                                avatarUrl: message.user.avatar?.avatarUrl,
                                defaultAvatarUrl: CommonConstants.defaultAvatarUrl,
                                radius: 20,
                                isPremium: message.user.premium,
                                isAdmin: message.user.isAdmin,
                                role: message.user.role,
                              ),
                            ],
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              // 输入框
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: SafeArea(
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: controller.messageController,
                          decoration: const InputDecoration(
                            hintText: '输入消息...',
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                          ),
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        onPressed: () {
                          if (controller.messageController.text.trim().isNotEmpty) {
                            controller.sendMessage();
                          }
                        },
                        icon: const Icon(Icons.send),
                        color: Theme.of(context).primaryColor,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 