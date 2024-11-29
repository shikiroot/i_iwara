import 'package:get/get.dart';
import 'package:i_iwara/app/models/play_list.model.dart';
import 'package:i_iwara/app/routes/app_routes.dart';
import 'package:i_iwara/app/services/play_list_service.dart';
import 'package:i_iwara/app/services/user_service.dart';

class PlayListsController extends GetxController {
  final PlayListService _playListService = Get.find<PlayListService>();
  final UserService _userService = Get.find<UserService>();
  
  final RxList<PlaylistModel> playlists = <PlaylistModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool hasMore = true.obs;
  int currentPage = 0;

  @override
  void onInit() {
    super.onInit();
    refreshData();
  }
  
  // 创建播放列表
  Future<void> createPlaylist(String title) async {
    final result = await _playListService.createPlaylist(title: title);
    if (result.isSuccess) {
      refreshData();
    } else {
      Get.snackbar('错误', result.message);
    }
  }
  
  // 刷新数据
  Future<void> refreshData() async {
    currentPage = 0;
    hasMore.value = true;
    await loadData(refresh: true);
  }
  
  // 加载数据
  Future<void> loadData({bool refresh = false}) async {
    if (!hasMore.value && !refresh) return;
    
    try {
      isLoading.value = true;
      if (_userService.currentUser.value == null) {
        Get.snackbar('错误', '请先登录');
        Get.toNamed(Routes.LOGIN);
        return;
      }
      final result = await _playListService.getPlaylists(
        userId: _userService.currentUser.value!.id,
        pageNum: currentPage,
      );
      
      if (result.isSuccess && result.data != null) {
        if (refresh) {
          playlists.clear();
        }
        
        final pageData = result.data!;
        if (pageData.results.isEmpty || 
            (currentPage + 1) * pageData.limit >= pageData.count) {
          hasMore.value = false;
        } else {
          currentPage++;
        }
        playlists.addAll(pageData.results);
      }
    } catch (e) {
      // 处理错误
      Get.snackbar('错误', '加载失败');
    } finally {
      isLoading.value = false;
    }
  }
}
