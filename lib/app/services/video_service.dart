import 'package:get/get.dart';
import 'package:i_iwara/app/models/api_result.model.dart';
import 'package:i_iwara/app/models/page_data.model.dart';
import 'package:i_iwara/app/models/video.model.dart';
import 'package:i_iwara/utils/logger_utils.dart';

import 'api_service.dart';

class VideoService extends GetxService {
  final ApiService _apiService = Get.find<ApiService>();

  /// 根据提供的查询参数获取视频列表。
  ///
  /// 此方法向 `/videos` 端点发送带有给定查询参数的 GET 请求，并返回包含视频列表的 `ApiResult`。
  ///
  /// [params] 一个用于过滤视频的查询参数映射。
  /// [page] 当前页码。
  /// [limit] 每页数据量。
  ///
  /// 返回一个包含 `Video` 对象列表、消息和状态码的 `ApiResult`。
  Future<ApiResult<PageData<Video>>> fetchVideosByParams({
    required Map<String, dynamic> params,
    int page = 0,
    int limit = 20,
  }) async {
    try {
      final response = await _apiService.get('/videos', queryParameters: {
        ...params,
        'page': page,
        'limit': limit,
      });

      final List<Video> results = (response.data['results'] as List)
          .map((video) => Video.fromJson(video))
          .toList();

      final PageData<Video> pageData = PageData(
        page: response.data['page'],
        limit: response.data['limit'],
        count: response.data['count'],
        results: results,
      );

      return ApiResult.success(data: pageData);
    } catch (e) {
      LogUtils.e('获取视频列表失败', tag: 'VideoService', error: e);
      return ApiResult.fail('啊呕，获取视频列表失败');
    }
  }
}
