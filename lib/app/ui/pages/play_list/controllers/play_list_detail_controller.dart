import 'package:get/get.dart';
import 'package:i_iwara/app/models/video.model.dart';
import 'package:i_iwara/app/services/play_list_service.dart';

class PlayListDetailController extends GetxController {
  final PlayListService _playListService = Get.find<PlayListService>();
  
  final RxList<Video> videos = <Video>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool hasMore = true.obs;
  final RxBool isMultiSelect = false.obs;
  final RxSet<String> selectedVideos = <String>{}.obs;
  final RxString playlistTitle = ''.obs;
  
  final String playlistId;
  int currentPage = 0;

  PlayListDetailController({required this.playlistId});

  get isAllSelected => selectedVideos.length == videos.length;
  
  @override
  void onInit() {
    super.onInit();
    loadPlaylistName();
    refreshData();
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
    if (selectedVideos.length == videos.length) {
      selectedVideos.clear();
    } else {
      selectedVideos.addAll(videos.map((v) => v.id));
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
    refreshData();
  }
  
  // 刷新和加载数据的方法与播放列表页面类似
  Future<void> refreshData() async {
    currentPage = 0;
    hasMore.value = true;
    await loadData(refresh: true);
  }
  
  Future<void> loadData({bool refresh = false}) async {
    if (isLoading.value || (!hasMore.value && !refresh)) return;
    
    isLoading.value = true;
    try {
      final result = await _playListService.getPlaylistVideos(
        playlistId: playlistId,
        page: currentPage,
      );
      
      if (result.isSuccess && result.data != null) {
        if (refresh) {
          videos.clear();
        }
        
        if (result.data!.results.isEmpty) {
          hasMore.value = false;
        } else {
          videos.addAll(result.data!.results);
          currentPage++;
        }
      }
    } finally {
      isLoading.value = false;
    }
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
