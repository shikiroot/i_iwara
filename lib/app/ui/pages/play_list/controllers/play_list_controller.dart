import 'package:get/get.dart';
import 'package:i_iwara/app/services/play_list_service.dart';

class PlayListsController extends GetxController {
  final PlayListService _playListService = Get.find<PlayListService>();

  // 创建播放列表
  Future<void> createPlaylist(String title) async {
    final result = await _playListService.createPlaylist(title: title);
    if (!result.isSuccess) {
      Get.snackbar('错误', result.message);
    }
  }

}
