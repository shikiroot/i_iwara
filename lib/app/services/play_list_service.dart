import 'package:get/get.dart';
import 'package:i_iwara/app/models/api_result.model.dart';
import 'package:i_iwara/app/models/page_data.model.dart';
import 'package:i_iwara/app/models/play_list.model.dart';
import 'package:i_iwara/app/models/video.model.dart';
import 'package:i_iwara/app/services/api_service.dart';

class PlayListService extends GetxService {
  final ApiService apiService = Get.find<ApiService>();

  // 创建播放列表
  Future<ApiResult<void>> createPlaylist({required String title}) async {
    try {
      await apiService.post('/playlists', data: {'title': title});
      return ApiResult.success();
    } catch (e) {
      return ApiResult.fail("创建播放列表失败");
    }
  }

  // 编辑播放列表标题
  Future<ApiResult<void>> editPlaylistTitle({
    required String playlistId,
    required String title,
  }) async {
    try {
      await apiService.put('/playlist/$playlistId', data: {'title': title});
      return ApiResult.success();
    } catch (e) {
      return ApiResult.fail("编辑播放列表标题失败");
    }
  }

  // 获取播放列表
  Future<ApiResult<PageData<PlaylistModel>>> getPlaylists({
    required String userId,
    required int page,
    int limit = 20,
  }) async {
    try {
      final response = await apiService.get('/playlists', 
        queryParameters: {
          'user': userId,
          'page': page,
          'limit': limit,
        }
      );
      
      final PageData<PlaylistModel> pageData = PageData(
        page: response.data['page'],
        limit: response.data['limit'],
        count: response.data['count'],
        results: (response.data['results'] as List)
          .map((playlistModel) => PlaylistModel.fromJson(playlistModel))
          .toList(),
      );
      return ApiResult.success(data: pageData);
    } catch (e) {
      return ApiResult.fail("获取播放列表失败");
    }
  }

  // 获取播放列表名称
  Future<ApiResult<String>> getPlaylistName({required String playlistId}) async {
    try {
      final response = await apiService.get('/playlist/$playlistId');
      return ApiResult.success(data: response.data['playlist']['title']);
    } catch (e) {
      return ApiResult.fail("获取播放列表名称失败");
    }
  }

  // 添加视频到播放列表
  Future<ApiResult<void>> addToPlaylist({
    required String videoId,
    required String playlistId,
  }) async {
    try {
      await apiService.post('/playlist/$playlistId/$videoId');
      return ApiResult.success();
    } catch (e) {
      return ApiResult.fail("添加视频到播放列表失败");
    }
  }

  // 从播放列表移除视频
  Future<ApiResult<void>> removeFromPlaylist({
    required String videoId,
    required String playlistId,
  }) async {
    try {
      await apiService.delete('/playlist/$playlistId/$videoId');
      return ApiResult.success();
    } catch (e) {
      return ApiResult.fail("从播放列表移除视频失败");
    }
  }

  // 获取播放列表的视频
  Future<ApiResult<PageData<Video>>> getPlaylistVideos({
    required String playlistId,
    int page = 0,
    int limit = 32,
  }) async {
    try {
      final response = await apiService.get(
        '/playlist/$playlistId', 
        queryParameters: {
          'page': page,
          'limit': limit,
        }
      );
      
      final PageData<Video> pageData = PageData(
        page: response.data['page'],
        limit: response.data['limit'],
        count: response.data['count'],
        results: (response.data['results'] as List)
          .map((video) => Video.fromJson(video))
          .toList(),
      );

      return ApiResult.success(data: pageData);
    } catch (e) {
      return ApiResult.fail("获取播放列表的视频失败");
    }
  }

  // 删除此播放列表
  Future<ApiResult<void>> deletePlaylist({required String playlistId}) async {
    try {
      await apiService.delete('/playlist/$playlistId');
      return ApiResult.success();
    } catch (e) {
      return ApiResult.fail("删除播放列表失败");
    }
  }
}
