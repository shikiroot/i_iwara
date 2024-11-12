import 'package:get/get.dart';
import 'package:i_iwara/utils/logger_utils.dart';

import '../../../../../utils/constants.dart';
import '../../../../models/comment.model.dart';
import '../../../../services/api_service.dart';

class CommentController extends GetxController {
  final String? videoId;
  final String? profileId;

  var comments = <Comment>[].obs;
  var isLoading = false.obs;
  var doneFirstTime = false.obs;
  var errorMessage = ''.obs;
  var currentPage = 0;
  final int pageSize = 20;
  var totalComments = 0.obs;
  var hasMore = true.obs;

  // API 服务实例
  final ApiService _apiService = Get.find<ApiService>();

  CommentController({this.videoId, this.profileId});

  @override
  void onInit() {
    super.onInit();
    LogUtils.d('初始化', 'CommentController');
    fetchComments(refresh: true);
  }

  // 从 API 获取评论
  Future<void> fetchComments({bool refresh = false}) async {
    LogUtils.d('获取评论', 'CommentController');
    // 如果是刷新操作，重置分页并清除现有数据
    if (refresh) {
      doneFirstTime.value = false;
      currentPage = 0;
      comments.clear();
      errorMessage.value = '';
      hasMore.value = true; // 重置hasMore标志
    }

    // 如果没有更多评论或已经在加载中，则不进行获取操作
    if (!hasMore.value || isLoading.value) return;

    isLoading.value = true;

    try {
      var api = (videoId != null && videoId!.isNotEmpty)
          ? ApiConstants.videoComments(videoId!)
          : ApiConstants.userComments(profileId!);
      final response = await _apiService.get(
        api,
        queryParameters: {
          'page': currentPage,
          'limit': pageSize,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data;

        // 提取分页信息
        totalComments.value = data['count'] ?? 0;
        final fetchedPage = data['page'] ?? 1;
        final limit = data['limit'] ?? pageSize;

        // 解析评论
        List<Map<String, dynamic>> commentList =
            List<Map<String, dynamic>>.from(data['results'] ?? []);

        List<Comment> fetchedComments =
            commentList.map((json) => Comment.fromJson(json)).toList();

        // 如果返回的评论为空，设置hasMore为false
        if (fetchedComments.isEmpty) {
          hasMore.value = false;
        } else {
          // 将新评论添加到列表中
          comments.addAll(fetchedComments);
          // 增加页码以便下次获取
          currentPage += 1;

          // 根据获取的评论数量更新hasMore标志
          if (fetchedComments.length < pageSize) {
            hasMore.value = false;
          }
        }

        errorMessage.value = '';
      } else {
        errorMessage.value = '加载评论失败：${response.statusMessage}';
      }
    } catch (e) {
      LogUtils.e('获取评论时出错', tag: 'CommentController', error: e);
      errorMessage.value = '获取评论时出错，请检查网络连接。';
    } finally {
      isLoading.value = false;
      doneFirstTime.value = true;
    }
  }

  // 刷新评论的方法
  Future<void> refreshComments() async {
    await fetchComments(refresh: true);
  }

  // 加载更多评论的方法
  Future<void> loadMoreComments() async {
    if (!isLoading.value && hasMore.value) {
      await fetchComments();
    }
  }
}
