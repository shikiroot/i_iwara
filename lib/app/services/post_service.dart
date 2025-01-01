
import 'package:get/get.dart';
import 'package:i_iwara/app/models/api_result.model.dart';
import 'package:i_iwara/app/models/page_data.model.dart';
import 'package:i_iwara/app/models/post.model.dart';
import 'package:i_iwara/app/services/api_service.dart';
import 'package:i_iwara/common/constants.dart';
import 'package:i_iwara/i18n/strings.g.dart';
import 'package:i_iwara/utils/logger_utils.dart';

class PostService extends GetxService {
  final ApiService _apiService = Get.find();

  /// 获取帖子详情
  /// @param id 帖子ID
  Future<ApiResult<PostModel>> fetchPostDetail(String id) async {
    try {
      var response = await _apiService.get(ApiConstants.post(id));
      return ApiResult.success(data: PostModel.fromJson(response.data));
    } catch (e) {
      LogUtils.e('获取帖子详情失败', tag: 'PostService', error: e);
      return ApiResult.fail(t.errors.failedToFetchData);
    }
  }

  /// 获取帖子列表
  /// [params]
  /// `page` 页码
  /// `limit` 每页数量
  /// `subscribed` 是否订阅
  /// `user` 用户ID
  Future<ApiResult<PageData<PostModel>>> fetchPostList({
    Map<String, dynamic> params = const {},
    int page = 0,
    int limit = 20,
  }) async {
    try {
      var response = await _apiService.get(ApiConstants.posts(), queryParameters: {
        ...params,
        'page': page,
        'limit': limit,
      });
      final List<PostModel> results = (response.data['results'] as List)
          .map((postModel) => PostModel.fromJson(postModel))
          .toList();
      final PageData<PostModel> pageData = PageData(
        page: response.data['page'],
        limit: response.data['limit'],
        count: response.data['count'],
        results: results,
      );
      return ApiResult.success(data: pageData);
    } catch (e) {
      LogUtils.e('获取帖子列表失败', tag: 'PostService', error: e);
      return ApiResult.fail(t.errors.failedToFetchData);
    }
  }

  /// 获取关注的帖子列表
  Future<ApiResult<PageData<PostModel>>> fetchSubscribedPostList({
    int page = 0,
    int limit = 20,
  }) async {
    return await fetchPostList(params: {'subscribed': true}, page: page, limit: limit);
  }

  /// 获取用户的帖子列表
  Future<ApiResult<PageData<PostModel>>> fetchUserPostList(String userId, {
    int page = 0,
    int limit = 20,
  }) async {
    return await fetchPostList(params: {'user': userId}, page: page, limit: limit);
  }
}