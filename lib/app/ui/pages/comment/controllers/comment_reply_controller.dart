import 'package:get/get.dart';
import 'package:i_iwara/app/ui/pages/comment/controllers/comment_controller.dart';
import 'package:i_iwara/utils/logger_utils.dart';

import '../../../../models/comment.model.dart';
import '../../../../services/comment_service.dart';

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

  final CommentService _commentService = Get.find<CommentService>();

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
      final type = (videoId != null && videoId!.isNotEmpty) 
          ? CommentType.video.name 
          : CommentType.profile.name;
      final id = (videoId != null && videoId!.isNotEmpty) ? videoId! : profileId!;

      final result = await _commentService.getComments(
        type: type,
        id: id,
        parentId: parentId,
        page: page,
        limit: pageSize,
      );

      if (result.isSuccess) {
        final pageData = result.data!;
        final fetchedReplies = pageData.results;

        if (fetchedReplies.length < pageSize) {
          hasMore.value = false;
        } else {
          page++;
        }

        replies.addAll(fetchedReplies);
        errorMessage.value = '';
      } else {
        hasMore.value = false;
        errorMessage.value = result.message;
      }
    } catch (e) {
      LogUtils.e('获取回复时出错', error: e, tag: 'ReplyController');
      errorMessage.value = '获取回复时出错，请检查网络连接。';
      hasMore.value = false;
    } finally {
      isLoading.value = false;
    }
  }
}
