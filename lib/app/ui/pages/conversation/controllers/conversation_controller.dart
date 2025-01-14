import 'package:get/get.dart';
import 'package:i_iwara/app/models/message_and_conversation.model.dart';
import 'package:i_iwara/app/services/conversation_service.dart';
import 'package:i_iwara/app/services/user_service.dart';

class ConversationController extends GetxController {
  final ConversationService _conversationService = Get.find<ConversationService>();
  final UserService _userService = Get.find<UserService>();

  // 对话列表
  final RxList<ConversationModel> conversations = <ConversationModel>[].obs;
  // 当前选中的对话
  final Rxn<ConversationModel> selectedConversation = Rxn<ConversationModel>();
  // 加载状态
  final RxBool isLoading = false.obs;
  // 是否还有更多数据
  final RxBool hasMore = true.obs;
  // 错误信息
  final RxString errorMessage = ''.obs;
  // 当前页码
  int currentPage = 0;
  // 每页数量
  final int pageSize = 20;

  @override
  void onInit() {
    super.onInit();
    loadConversations();
  }

  // 设置选中的对话
  void setSelectedConversation(ConversationModel? conversation) {
    selectedConversation.value = conversation;
  }

  // 加载对话列表
  Future<void> loadConversations({bool refresh = false}) async {
    if (refresh) {
      currentPage = 0;
      hasMore.value = true;
      conversations.clear();
      errorMessage.value = '';
    }

    if (!hasMore.value || isLoading.value) return;

    try {
      isLoading.value = true;
      errorMessage.value = '';
      final userId = _userService.currentUser.value?.id;
      if (userId == null) return;

      final result = await _conversationService.getConversations(
        userId,
        page: currentPage,
        limit: pageSize,
      );

      if (result.isSuccess && result.data != null) {
        final pageData = result.data!;
        conversations.addAll(pageData.results);
        hasMore.value = pageData.results.length >= pageSize;
        currentPage++;
      } else {
        errorMessage.value = result.message;
      }
    } catch (e) {
      errorMessage.value = '加载失败，请重试';
    } finally {
      isLoading.value = false;
    }
  }

  // 刷新对话列表
  Future<void> refreshConversations() async {
    await loadConversations(refresh: true);
  }
} 