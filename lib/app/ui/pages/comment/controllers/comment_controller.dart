import 'package:get/get.dart';
import 'package:i_iwara/app/services/app_service.dart';
import 'package:i_iwara/app/ui/pages/comment/controllers/comment_reply_controller.dart';
import 'package:i_iwara/utils/logger_utils.dart';

import '../../../../../common/constants.dart';
import '../../../../models/comment.model.dart';
import '../../../../services/comment_service.dart';

enum CommentType {
  video,
  profile,
  image,
  ;

  const CommentType();

  // 获取完整的API路径
  String getApiEndpoint(String id) => ApiConstants.comments(name, id);
}

class CommentController<T extends CommentType> extends GetxController {
  final String id;
  final T type;

  var comments = <Comment>[].obs;
  var isLoading = false.obs;
  var doneFirstTime = false.obs;
  var errorMessage = ''.obs;
  var currentPage = 0;
  final int pageSize = 20;
  var totalComments = 0.obs;
  var hasMore = true.obs;

  // API 服务实例
  final CommentService _commentService = Get.find<CommentService>();

  CommentController({
    required this.id,
    required this.type,
  });

  @override
  void onInit() {
    super.onInit();
    LogUtils.d('初始化', 'CommentController<${type.toString()}>');
    fetchComments(refresh: true);
  }

  // 从 API 获取评论
  Future<void> fetchComments({bool refresh = false}) async {
    LogUtils.d('获取评论', 'CommentController<${type.toString()}>');

    if (refresh) {
      doneFirstTime.value = false;
      currentPage = 0;
      comments.clear();
      errorMessage.value = '';
      hasMore.value = true;
    }

    if (!hasMore.value || isLoading.value) return;

    isLoading.value = true;

    try {
      final result = await _commentService.getComments(
        type: type.name,
        id: id,
        page: currentPage,
        limit: pageSize,
      );

      if (result.isSuccess) {
        final pageData = result.data!;
        totalComments.value = pageData.count;

        final fetchedComments = pageData.results;

        if (fetchedComments.isEmpty) {
          hasMore.value = false;
        } else {
          comments.addAll(fetchedComments);
          currentPage += 1;
          hasMore.value = fetchedComments.length >= pageSize;
        }

        errorMessage.value = '';
      } else {
        errorMessage.value = result.message;
      }
    } catch (e) {
      LogUtils.e('获取评论时出错',
          tag: 'CommentController<${type.toString()}>', error: e);
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

  // 发表评论
  Future<void> postComment(String body, {String? parentId}) async {
    final result = await _commentService.postComment(
      type: type.name,
      id: id,
      body: body,
      parentId: parentId,
    );

    if (result.isSuccess && result.data != null) {
      if (parentId != null) {
        // 尝试获取replycontroller，如果获取不到，则创建一个
        try {
          final replyController = Get.find<ReplyController>(
            tag: parentId,
          );
          replyController.fetchReplies(refresh: true);
        } catch (e) {
          String? videoId;
          String? profileId;
          String? imageId;
          switch (type) {
            case CommentType.video:
              videoId = id;
              break;
            case CommentType.profile:
              profileId = id;
              break;
            case CommentType.image:
              imageId = id;
              break;
          }
          final replyController = Get.put(
            ReplyController(
              videoId: videoId,
              profileId: profileId,
              imageId: imageId,
              parentId: parentId,
            ),
            tag: parentId,
          );
          replyController.fetchReplies(refresh: true);
        }
      } else {
        // 如果是新评论，添加到列表开头
        comments.insert(0, result.data!);
      }
      totalComments.value++;
      Get.snackbar('成功', '评论发表成功');
      AppService.tryPop();
    } else {
      Get.snackbar('错误', result.message);
    }
  }

  // 删除评论
  Future<void> deleteComment(String commentId) async {
    final result = await _commentService.deleteComment(commentId);
    if (result.isSuccess) {
      comments.removeWhere((comment) => comment.id == commentId);
      totalComments.value--;
      Get.snackbar('成功', '评论已删除');
    } else {
      Get.snackbar('错误', result.message);
    }
  }

  // 编辑评论
  Future<void> editComment(String commentId, String newBody) async {
    final result = await _commentService.editComment(commentId, newBody);
    if (result.isSuccess) {
      final index = comments.indexWhere((comment) => comment.id == commentId);
      if (index != -1) {
        comments[index] = comments[index].copyWith(
          body: newBody,
          updatedAt: DateTime.now(),
        );
        Get.snackbar('成功', '评论已更新');
        AppService.tryPop();
      }
    } else {
      Get.snackbar('错误', result.message);
    }
  }
}
