import 'package:get/get.dart';
import 'package:i_iwara/utils/logger_utils.dart';

import '../models/api_result.model.dart';
import '../models/page_data.model.dart';
import '../models/tag.model.dart';
import 'api_service.dart';

class TagService extends GetxService {
  final ApiService _apiService = Get.find<ApiService>();

  /// 获取标签列表。
  /// [params] 一个用于过滤标签的查询参数映射。
  /// - filter 搜索关键词。
  Future<ApiResult<PageData<Tag>>> fetchTags({
    Map<String, dynamic> params = const {},
    int page = 0,
    int limit = 20,
  }) {
    return _apiService.get('/tags', queryParameters: {
      ...params,
      'page': page,
      'limit': limit,
    }).then((res) {
      return ApiResult<PageData<Tag>>.success(
        data: PageData<Tag>.fromJson(res.data),
      );
    }).catchError((err) {
      LogUtils.e('抓取标签失败', tag: 'TagService', error: err);
      return ApiResult<PageData<Tag>>.fail(err);
    });
  }
}
