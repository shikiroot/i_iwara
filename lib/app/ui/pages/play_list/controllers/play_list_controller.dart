import 'package:get/get.dart';
import 'package:i_iwara/app/models/play_list.model.dart';
import 'package:i_iwara/app/routes/app_routes.dart';
import 'package:i_iwara/app/services/play_list_service.dart';
import 'package:i_iwara/app/services/user_service.dart';

class PlayListsController extends GetxController {
  final PlayListService _playListService = Get.find<PlayListService>();
  final UserService _userService = Get.find<UserService>();

  // 创建播放列表
  Future<void> createPlaylist(String title) async {
    final result = await _playListService.createPlaylist(title: title);
    if (!result.isSuccess) {
      Get.snackbar('错误', result.message);
    }
  }

  Future<List<PlaylistModel>> loadPageData(int pageKey, int pageSize) async {
    if (_userService.currentUser.value == null) {
      Get.snackbar('错误', '请先登录');
      Get.toNamed(Routes.LOGIN);
      return [];
    }

    final result = await _playListService.getPlaylists(
      userId: _userService.currentUser.value!.id,
      page: pageKey,
      limit: pageSize,
    );

    if (result.isSuccess && result.data != null) {
      return result.data!.results;
    }

    throw Exception('加载失败');
  }

}
