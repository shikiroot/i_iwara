import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_iwara/app/models/message_and_conversation.model.dart';
import 'package:i_iwara/app/services/app_service.dart';
import 'package:i_iwara/app/services/user_service.dart';
import 'package:i_iwara/app/ui/pages/conversation/controllers/conversation_list_repository.dart';
import 'package:i_iwara/app/ui/widgets/avatar_widget.dart';
import 'package:i_iwara/app/ui/widgets/my_loading_more_indicator_widget.dart';
import 'package:i_iwara/app/ui/widgets/user_name_widget.dart';
import 'package:i_iwara/common/constants.dart';
import 'package:i_iwara/utils/common_utils.dart';
import 'package:loading_more_list/loading_more_list.dart';
import 'package:shimmer/shimmer.dart';

class ConversationListWidget extends StatefulWidget {
  final Function(ConversationModel) onConversationSelected;

  const ConversationListWidget({
    super.key,
    required this.onConversationSelected,
  });

  @override
  State<ConversationListWidget> createState() => _ConversationListWidgetState();
}

class _ConversationListWidgetState extends State<ConversationListWidget> {
  late ConversationListRepository listSourceRepository;
  final ScrollController _scrollController = ScrollController();
  final UserService userService = Get.find<UserService>();

  @override
  void initState() {
    super.initState();
    listSourceRepository = ConversationListRepository();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    listSourceRepository.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: LoadingMoreCustomScrollView(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: <Widget>[
          LoadingMoreSliverList<ConversationModel>(
            SliverListConfig<ConversationModel>(
              itemBuilder: (context, conversation, index) => _buildConversationItem(context, conversation),
              sourceList: listSourceRepository,
              padding: EdgeInsets.only(
                left: 5.0,
                right: 5.0,
                top: 5.0,
                bottom: Get.context != null ? MediaQuery.of(Get.context!).padding.bottom : 0,
              ),
              indicatorBuilder: _buildIndicator,
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      centerTitle: false,
      title: const Text('消息'),
      actions: [
        StreamBuilder<Iterable<ConversationModel>>(
          stream: listSourceRepository.rebuild,
          builder: (context, snapshot) {
            final isLoading = listSourceRepository.isLoading && listSourceRepository.length == 0;
            return IconButton(
              onPressed: isLoading ? null : () => listSourceRepository.refresh(true),
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
              onTap: () => listSourceRepository.errorRefresh(),
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
            onTap: () => listSourceRepository.errorRefresh(),
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
              '没有更多会话了',
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
                '暂无会话',
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
            width: 50,
            height: 50,
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
                const SizedBox(height: 4),
                Container(
                  width: 100,
                  height: 12,
                  color: Colors.white,
                ),
                const SizedBox(height: 4),
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
    );
  }

  Widget _buildConversationItem(BuildContext context, ConversationModel conversation) {
    final otherParticipant = conversation.participants.firstWhere(
      (user) => user.id != userService.currentUser.value?.id,
      orElse: () => conversation.participants.first,
    );

    return InkWell(
      onTap: () => widget.onConversationSelected(conversation),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
            GestureDetector(
              onTap: () {
                NaviService.navigateToAuthorProfilePage(otherParticipant.username);
              },
              child: AvatarWidget(
                avatarUrl: otherParticipant.avatar?.avatarUrl,
                defaultAvatarUrl: CommonConstants.defaultAvatarUrl,
                radius: 25,
                isPremium: otherParticipant.premium,
                isAdmin: otherParticipant.isAdmin,
                role: otherParticipant.role,
              ),
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: buildUserName(context, otherParticipant, fontSize: 16, overflowLines: 1),
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
                  Text(
                    '@${otherParticipant.username}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).hintColor,
                    ),
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