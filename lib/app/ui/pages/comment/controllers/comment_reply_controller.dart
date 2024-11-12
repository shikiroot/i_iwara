import 'package:get/get.dart';

import '../../../../../utils/constants.dart';
import '../../../../models/comment.model.dart';
import '../../../../services/api_service.dart';

class ReplyController extends GetxController {
  final String? videoId;
  final String? profileId;
  final String parentId;

  var replies = <Comment>[].obs;
  var isLoading = false.obs;
  var hasMore = true.obs;
  var page = 0;
  final int pageSize = 20;

  var errorMessage = ''.obs; // 错误消息变量

  final ApiService _dio = Get.find<ApiService>();

  ReplyController({this.videoId, this.profileId, required this.parentId});

  Future<void> fetchReplies({bool refresh = false}) async {
    if (refresh) {
      page = 0;
      hasMore.value = true;
      replies.clear();
      errorMessage.value = ''; // 清除之前的错误消息
    }

    if (!hasMore.value || isLoading.value) return;

    isLoading.value = true;

    try {
      var api = (videoId != null && videoId!.isNotEmpty)
          ? ApiConstants.videoComments(videoId!)
          : ApiConstants.userComments(profileId!);
      final response = await _dio.get(
        api,
        queryParameters: {
          'parent': parentId,
          'page': page,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data;
        List<Map<String, dynamic>> replyList = List<Map<String, dynamic>>.from(
            data['results'] ?? data['comments'] ?? []);
        List<Comment> fetchedReplies =
            replyList.map((json) => Comment.fromJson(json)).toList();

        if (fetchedReplies.length < pageSize) {
          hasMore.value = false;
        } else {
          page++;
        }

        replies.addAll(fetchedReplies);
        errorMessage.value = ''; // 成功获取数据，清除错误消息
      } else {
        hasMore.value = false;
        errorMessage.value = '加载回复失败：${response.statusMessage}';
      }
    } catch (e) {
      print('获取回复时出错：$e');
      errorMessage.value = '获取回复时出错，请检查网络连接。';
      hasMore.value = false; // 确保停止加载更多
    } finally {
      isLoading.value = false;
    }
  }
}
