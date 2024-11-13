import 'package:get/get.dart';
import 'package:i_iwara/app/models/api_result.model.dart';
import 'package:i_iwara/app/models/image.model.dart';
import 'package:i_iwara/app/models/page_data.model.dart';
import 'package:i_iwara/utils/constants.dart';
import 'package:i_iwara/utils/logger_utils.dart';

import 'api_service.dart';

class GalleryService extends GetxService {
  final ApiService _apiService = Get.find<ApiService>();

  /// 根据提供的查询参数获取图片列表。
  ///
  /// 此方法向 `/images` 端点发送带有给定查询参数的 GET 请求，并返回包含图片列表的 `ApiResult`。
  ///
  /// [params] 一个用于过滤图片的查询参数映射。
  /// - `sort` 排序方式。
  /// - `tags` 标签。
  /// - `date` 日期。
  /// - `rating` 内容评级。 general, ecchi
  /// [page] 当前页码。
  /// [limit] 每页数据量。
  ///
  /// 返回一个包含 `ImageModel` 对象列表、消息和状态码的 `ApiResult`。
  Future<ApiResult<PageData<ImageModel>>> fetchImageModelsByParams({
    Map<String, dynamic> params = const {},
    int page = 0,
    int limit = 20,
  }) async {
    try {
      // [HACK_IMPLEMENT] 如果params里有的值为空字符串，则去掉key
      // 我靠，iwara站的搜索居然连空字符串都用于搜索了，哎
      params.removeWhere((key, value) => value == '');
      final response = await _apiService.get(ApiConstants.images(), queryParameters: {
        ...params,
        'page': page,
        'limit': limit,
      });

      final List<ImageModel> results = (response.data['results'] as List)
          .map((imageModel) => ImageModel.fromJson(imageModel))
          .toList();

      final PageData<ImageModel> pageData = PageData(
        page: response.data['page'],
        limit: response.data['limit'],
        count: response.data['count'],
        results: results,
      );

      return ApiResult.success(data: pageData);
    } catch (e) {
      LogUtils.e('获取图片列表失败', tag: 'ImageModelService', error: e);
      return ApiResult.fail('噫嘘唏, 获取图片列表失败');
    }
  }
}

