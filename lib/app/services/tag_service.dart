import 'package:get/get.dart';
import 'package:i_iwara/common/constants.dart';
import 'package:i_iwara/i18n/strings.g.dart';
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
  }) async {
    try {
      var response = await _apiService.get(ApiConstants.tags(), queryParameters: {
        ...params,
        'page': page,
        'limit': limit,
      });

      final List<Tag> results = (response.data['results'] as List)
          .map((tag) => Tag.fromJson(tag))
          .toList();

      final PageData<Tag> pageData = PageData(
        page: response.data['page'],
        limit: response.data['limit'],
        count: response.data['count'],
        results: results,
      );

      return ApiResult.success(data: pageData);
    } catch (e) {
      LogUtils.e('获取标签列表失败', tag: 'TagService', error: e);
      return ApiResult.fail(t.errors.failedToFetchData);
    }

  }
}
