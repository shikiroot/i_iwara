import 'package:get/get.dart';
import 'package:i_iwara/app/ui/pages/comment/controllers/comment_controller.dart';
import 'package:i_iwara/utils/logger_utils.dart';

import '../../../../models/comment.model.dart';
import '../../../../services/comment_service.dart';

class ReplyController extends GetxController {
  final String? videoId;
  final String? profileId;
  final String? imageId;
  final String parentId;

  var replies = <Comment>[].obs;
  var isLoading = false.obs;
  var hasMore = true.obs;
  var page = 0;
  final int pageSize = 20;

  var errorMessage = ''.obs; // 错误消息变量

  final CommentService _commentService = Get.find<CommentService>();

  ReplyController({this.videoId, this.profileId, this.imageId, required this.parentId});

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
      String type;
      String id;
      if (videoId != null && videoId!.isNotEmpty) {
        type = CommentType.video.name;
        id = videoId!;
      } else if (profileId != null && profileId!.isNotEmpty) {
        type = CommentType.profile.name;
        id = profileId!;
      } else if (imageId != null && imageId!.isNotEmpty) {
        type = CommentType.image.name;
        id = imageId!;
      } else {
        throw Exception('未知的评论类型');
      }


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
