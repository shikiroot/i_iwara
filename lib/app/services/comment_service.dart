import 'package:get/get.dart';
import 'package:i_iwara/app/models/api_result.model.dart';
import 'package:i_iwara/app/models/comment.model.dart';
import 'package:i_iwara/app/models/page_data.model.dart';
import 'package:i_iwara/app/services/api_service.dart';
import 'package:i_iwara/common/constants.dart';
import 'package:i_iwara/utils/logger_utils.dart';

class CommentService extends GetxService {
  final ApiService _apiService = Get.find<ApiService>();

  /// 获取评论
  Future<ApiResult<PageData<Comment>>> getComments({
    required String type,
    required String id,
    String? parentId,
    int page = 0,
    int limit = 20,
  }) async {
    try {
      final response = await _apiService.get(
        ApiConstants.comments(type, id),
        queryParameters: {
          'page': page,
          'limit': limit,
          if (parentId != null) 'parent': parentId,
        },
      );

      final List<Comment> results = (response.data['results'] as List)
          .map((comment) => Comment.fromJson(comment))
          .toList();

      final PageData<Comment> pageData = PageData(
        page: response.data['page'],
        limit: response.data['limit'],
        count: response.data['count'],
        results: results,
      );

      return ApiResult.success(data: pageData);
    } catch (e) {
      LogUtils.e('获取评论失败', tag: 'CommentService', error: e);
      return ApiResult.fail('噫嘘唏, 获取评论失败');
    }
  }
}
