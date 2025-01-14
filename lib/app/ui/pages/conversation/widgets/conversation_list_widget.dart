import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_iwara/app/models/message_and_conversation.model.dart';
import 'package:i_iwara/app/services/user_service.dart';
import 'package:i_iwara/app/ui/pages/conversation/controllers/conversation_controller.dart';
import 'package:i_iwara/app/ui/widgets/avatar_widget.dart';
import 'package:i_iwara/common/constants.dart';
import 'package:i_iwara/utils/common_utils.dart';
import 'package:shimmer/shimmer.dart';

class ConversationListWidget extends GetView<ConversationController> {
  final Function(ConversationModel) onConversationSelected;
  final UserService userService = Get.find<UserService>();

  ConversationListWidget({
    super.key,
    required this.onConversationSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Obx(() => _buildBody(context)),
    );
  }

  // 构建AppBar
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      centerTitle: false,
      title: const Text('消息'),
      actions: [
        Obx(() => IconButton(
          icon: controller.isLoading.value 
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              )
            : const Icon(Icons.refresh),
          onPressed: controller.isLoading.value 
            ? null 
            : () => controller.refreshConversations(),
        )),
      ],
    );
  }

  // 构建主体内容
  Widget _buildBody(BuildContext context) {
    if (controller.errorMessage.isNotEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(controller.errorMessage.value),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: controller.isLoading.value 
                ? null 
                : () => controller.refreshConversations(),
              child: controller.isLoading.value
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  )
                : const Text('重试'),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: controller.refreshConversations,
      child: ListView.builder(
        itemCount: controller.conversations.length + 1,
        itemBuilder: (context, index) {
          if (index == controller.conversations.length) {
            return _buildLoadingItem(controller.hasMore.value);
          }
          return _buildConversationItem(context, controller.conversations[index]);
        },
      ),
    );
  }

  // 构建加载项
  Widget _buildLoadingItem(bool hasMore) {
    if (!hasMore) return const SizedBox.shrink();
    
    controller.loadConversations();
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 120,
                        height: 16,
                        color: Colors.white,
                      ),
                      Container(
                        width: 50,
                        height: 12,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    height: 14,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 构建会话项
  Widget _buildConversationItem(BuildContext context, ConversationModel conversation) {
    final otherParticipant = conversation.participants.firstWhere(
      (user) => user.id != userService.currentUser.value?.id,
      orElse: () => conversation.participants.first,
    );

    return InkWell(
      onTap: () => onConversationSelected(conversation),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Theme.of(context).dividerColor,
              width: 0.5,
            ),
          ),
        ),
        child: Row(
          children: [
            AvatarWidget(
              avatarUrl: otherParticipant.avatar?.avatarUrl,
              defaultAvatarUrl: CommonConstants.defaultAvatarUrl,
              radius: 25,
              isPremium: otherParticipant.premium,
              isAdmin: otherParticipant.isAdmin,
              role: otherParticipant.role,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          otherParticipant.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        CommonUtils.formatFriendlyTimestamp(conversation.lastMessage.createdAt),
                        style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          conversation.lastMessage.body,
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).hintColor,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (conversation.unread)
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.error,
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
} 