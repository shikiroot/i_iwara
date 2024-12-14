import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_iwara/app/models/dto/user_dto.dart';
import 'package:i_iwara/app/models/user.model.dart';
import 'package:i_iwara/app/services/user_preference_service.dart';
import 'package:i_iwara/app/services/user_service.dart';

class FollowButtonWidget extends StatefulWidget {
  final User user;
  final Function(User user)? onUserUpdated;

  const FollowButtonWidget({
    super.key,
    required this.user,
    this.onUserUpdated,
  });

  @override
  State<FollowButtonWidget> createState() => _FollowButtonWidgetState();
}

class _FollowButtonWidgetState extends State<FollowButtonWidget> {
  bool _isLoading = false;
  late User _currentUser;
  final UserService _userService = Get.find();
  final UserPreferenceService _userPreferenceService = Get.find();

  @override
  void initState() {
    super.initState();
    _currentUser = widget.user;
  }

  // 构建加载中的按钮
  Widget _buildLoadingButton({bool isFollowing = false}) {
    return ElevatedButton(
      onPressed: null,
      style: ElevatedButton.styleFrom(
        backgroundColor: isFollowing ? Colors.grey[300] : null,
        foregroundColor: isFollowing ? Colors.black87 : null,
      ),
      child: SizedBox(
        height: 20,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isFollowing) ...[
              const Icon(Icons.check, size: 18),
              const SizedBox(width: 4),
            ],
            SizedBox(
              width: 12,
              height: 12,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(
                  isFollowing ? Colors.black87 : Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 4),
            Text(isFollowing ? '已关注' : '关注'),
          ],
        ),
      ),
    );
  }

  // 显示关注选项底部菜单
  void _showFollowOptionsSheet() {
    final RxBool isProcessing = false.obs;
    final UserDTO? likedUser =
        _userPreferenceService.getLikedUser(_currentUser.id);

    Get.bottomSheet(
      Obx(
        () => Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                enabled: !isProcessing.value,
                leading: Icon(
                  likedUser != null ? Icons.star : Icons.star_border,
                  color: likedUser != null ? Colors.amber : null,
                ),
                title: Text(likedUser != null ? '取消特别关注' : '加入特别关注'),
                trailing: isProcessing.value
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : null,
                onTap: () {
                  if (likedUser != null) {
                    _userPreferenceService.removeLikedUser(likedUser);
                  } else {
                    _userPreferenceService.addLikedUser(UserDTO(
                      id: _currentUser.id,
                      name: _currentUser.name,
                      username: _currentUser.username ?? '',
                      avatarUrl: _currentUser.avatar?.avatarUrl ?? '',
                    ));
                  }
                  if (Get.isBottomSheetOpen ?? false) {
                    Get.closeAllBottomSheets();
                  }
                },
              ),
              ListTile(
                enabled: !isProcessing.value,
                leading: const Icon(Icons.person_remove),
                title: const Text('取消关注'),
                trailing: isProcessing.value
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : null,
                onTap: () async {
                  isProcessing.value = true;
                  try {
                    final result =
                        await _userService.unfollowUser(_currentUser.id);
                    if (result.isSuccess) {
                      final likedUser =
                          _userPreferenceService.getLikedUser(_currentUser.id);
                      if (likedUser != null) {
                        _userPreferenceService.removeLikedUser(likedUser);
                      }

                      final updatedUser = _currentUser.copyWith(
                        following: false,
                        friend: false,
                      );
                      setState(() {
                        _currentUser = updatedUser;
                      });
                      widget.onUserUpdated?.call(updatedUser);
                      if (Get.isBottomSheetOpen ?? false) {
                        Get.closeAllBottomSheets();
                      }
                    } else {
                      Get.snackbar('错误', result.message);
                    }
                  } catch (e) {
                    Get.snackbar('错误', '操作失败');
                  } finally {
                    isProcessing.value = false;
                  }
                },
              ),
            ],
          ),
        ),
      ),
      isDismissible: !isProcessing.value,
      enableDrag: !isProcessing.value,
    );
  }

  @override
  Widget build(BuildContext context) {
    // 如果是自己，不显示关注按钮
    if (_userService.currentUser.value?.id == _currentUser.id) {
      return const SizedBox.shrink();
    }

    if (_isLoading) {
      return _buildLoadingButton(isFollowing: _currentUser.following);
    }

    if (!_currentUser.following) {
      return ElevatedButton(
        onPressed: () async {
          setState(() {
            _isLoading = true;
          });

          try {
            final result = await _userService.followUser(_currentUser.id);
            if (result.isSuccess) {
              final updatedUser = _currentUser.copyWith(following: true);
              setState(() {
                _currentUser = updatedUser;
              });
              widget.onUserUpdated?.call(updatedUser);
            } else {
              Get.snackbar('错误', result.message);
            }
          } catch (e) {
            Get.snackbar('错误', '操作失败');
          } finally {
            setState(() {
              _isLoading = false;
            });
          }
        },
        child: const Text('关注'),
      );
    }

    return ElevatedButton.icon(
      onPressed: _showFollowOptionsSheet,
      icon: const Icon(Icons.check, size: 18),
      label: const Text('已关注'),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey[300],
        foregroundColor: Colors.black87,
      ),
    );
  }
}
