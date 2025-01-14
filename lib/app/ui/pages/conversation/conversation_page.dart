import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_iwara/app/models/message_and_conversation.model.dart';
import 'package:i_iwara/app/services/app_service.dart';
import 'package:i_iwara/app/ui/pages/conversation/controllers/conversation_controller.dart';
import 'package:i_iwara/app/ui/pages/conversation/widgets/conversation_list_widget.dart';
import 'package:i_iwara/app/ui/pages/conversation/widgets/message_list_widget.dart';

class ConversationPage extends StatefulWidget {
  const ConversationPage({super.key});

  @override
  State<ConversationPage> createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  late ConversationController _conversationController;
  bool _previousIsWideScreen = false;

  @override
  void initState() {
    super.initState();
    _conversationController = Get.put(ConversationController());
  }

  @override
  void dispose() {
    _conversationController.setSelectedConversation(null);
    Get.delete<ConversationController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final bool isWideScreen = constraints.maxWidth > 600;

          // 如果从宽屏切换到小屏，清除选中的对话
          if (_previousIsWideScreen && !isWideScreen) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _conversationController.setSelectedConversation(null);
            });
          }
          _previousIsWideScreen = isWideScreen;

          return Row(
            children: [
              // 对话列表部分
              SizedBox(
                width: isWideScreen ? 300 : constraints.maxWidth,
                child: ConversationListWidget(
                  onConversationSelected: (ConversationModel conversation) {
                    if (!isWideScreen) {
                      // 小屏幕时使用嵌套导航
                      NaviService.navigateToMessagePage(conversation);
                    } else {
                      // 宽屏时更新选中的对话
                      _conversationController.setSelectedConversation(conversation);
                    }
                  },
                ),
              ),
              // 消息列表部分 - 仅在宽屏时显示
              if (isWideScreen)
                Expanded(
                  child: GetX<ConversationController>(
                    builder: (controller) {
                      final selectedConversation = controller.selectedConversation.value;
                      if (selectedConversation == null) {
                        return const Center(
                          child: Text('请选择一个对话'),
                        );
                      }
                      return MessageListWidget(
                        conversation: selectedConversation,
                        key: ValueKey(selectedConversation.id),
                        fromNarrowScreen: false,
                      );
                    },
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
} 