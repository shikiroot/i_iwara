import 'package:get/get.dart';
import 'package:i_iwara/app/services/play_list_service.dart';
import 'package:i_iwara/app/ui/pages/play_list/controllers/play_list_detail_repository.dart';

class PlayListDetailController extends GetxController {
  final PlayListService _playListService = Get.find<PlayListService>();
  late PlayListDetailRepository repository;
  
  final RxBool isMultiSelect = false.obs;
  final RxSet<String> selectedVideos = <String>{}.obs;
  final RxString playlistTitle = ''.obs;
  
  final String playlistId;

  PlayListDetailController({required this.playlistId}) {
    repository = PlayListDetailRepository(playlistId: playlistId);
  }

  get isAllSelected => selectedVideos.length == repository.length;
  
  @override
  void onInit() {
    super.onInit();
    loadPlaylistName();
  }
  
  Future<void> loadPlaylistName() async {
    final result = await _playListService.getPlaylistName(playlistId: playlistId);
    if (result.isSuccess) {
      playlistTitle.value = result.data!;
    }
  }
  
  Future<void> editTitle(String newTitle) async {
    final result = await _playListService.editPlaylistTitle(
      playlistId: playlistId,
      title: newTitle,
    );
    if (result.isSuccess) {
      playlistTitle.value = newTitle;
    } else {
      Get.snackbar('错误', result.message);
    }
  }
  
  void toggleMultiSelect() {
    isMultiSelect.value = !isMultiSelect.value;
    if (!isMultiSelect.value) {
      selectedVideos.clear();
    }
  }
  
  void toggleSelection(String videoId) {
    if (selectedVideos.contains(videoId)) {
      selectedVideos.remove(videoId);
    } else {
      selectedVideos.add(videoId);
    }
  }
  
  void selectAll() {
    if (selectedVideos.length == repository.length) {
      selectedVideos.clear();
    } else {
      selectedVideos.addAll(repository.map((v) => v.id));
    }
  }
  
  Future<void> deleteSelected() async {
    for (var videoId in selectedVideos) {
      await _playListService.removeFromPlaylist(
        videoId: videoId,
        playlistId: playlistId,
      );
    }
    selectedVideos.clear();
  }
  
  void deleteCurPlaylist() {
    _playListService.deletePlaylist(playlistId: playlistId).then((result) {
      if (result.isSuccess) {
        Get.snackbar('成功', '删除成功');
      } else {
        Get.snackbar('错误', result.message);
      }
    });
  }
}
