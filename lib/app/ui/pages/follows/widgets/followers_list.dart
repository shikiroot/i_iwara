import 'package:flutter/material.dart';
import 'package:i_iwara/app/models/user.model.dart';
import 'package:i_iwara/app/ui/pages/follows/controllers/follows_controller.dart';
import 'package:i_iwara/app/ui/widgets/my_loading_more_indicator_widget.dart';
import 'package:i_iwara/app/ui/widgets/user_card.dart';
import 'package:loading_more_list/loading_more_list.dart';

class FollowersList extends StatelessWidget {
  final ScrollController scrollController;
  final FollowsController controller;

  const FollowersList({
    super.key,
    required this.scrollController,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return LoadingMoreCustomScrollView(
      controller: scrollController,
      slivers: [
        LoadingMoreSliverList<User>(
          SliverListConfig<User>(
            itemBuilder: (context, user, index) {
              return UserCard(
                user: user,
                onTap: () => controller.navigateToUserProfile(user.username),
                showFollowButton: false,
              );
            },
            sourceList: controller.followersRepository,
            padding: const EdgeInsets.all(8.0),
            indicatorBuilder: (context, status) => myLoadingMoreIndicator(
              context,
              status,
              isSliver: true,
              loadingMoreBase: controller.followersRepository,
            ),
          ),
        ),
      ],
    );
  }
} 