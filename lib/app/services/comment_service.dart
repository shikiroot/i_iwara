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

  /// 删除评论
  Future<ApiResult<void>> deleteComment(String id) async {
    try {
      await _apiService.delete(ApiConstants.comment(id));
      return ApiResult.success();
    } catch (e) {
      LogUtils.e('删除评论失败', tag: 'CommentService', error: e);
      return ApiResult.fail('噫嘘唏, 删除评论失败');
    }
  }

  /// 编辑评论
  Future<ApiResult<void>> editComment(String id, String body) async {
    try {
      await _apiService.put(ApiConstants.comment(id), data: {'body': body});
      return ApiResult.success();
    } catch (e) {
      LogUtils.e('编辑评论失败', tag: 'CommentService', error: e);
      return ApiResult.fail('噫嘘唏, 编辑评论失败');
    }
  }

  /// 发表评论
  Future<ApiResult<Comment>> postComment({
    required String type,
    required String id,
    required String body,
    String? parentId,
  }) async {
    try {
      final response = await _apiService.post(
        ApiConstants.comments(type, id),
        data: {
          'body': body,
          'rulesAgreement': true,
          if (parentId != null) 'parentId': parentId,
        },
      );

      return ApiResult.success(data: Comment.fromJson(response.data));
    } catch (e) {
      LogUtils.e('发表评论失败', tag: 'CommentService', error: e);
      return ApiResult.fail('噫嘘唏, 发表评论失败');
    }
  }
}
