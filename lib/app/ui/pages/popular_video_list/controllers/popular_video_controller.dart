import 'package:get/get.dart';
import 'package:i_iwara/app/models/api_result.model.dart';
import 'package:i_iwara/app/models/page_data.model.dart';
import 'package:i_iwara/app/models/video.model.dart';
import 'package:i_iwara/app/services/video_service.dart';

import '../../../../../utils/logger_utils.dart';

class PopularVideoController extends GetxController {
  final String sortId; // 当前controller的排序
  final VideoService _videoService = Get.find<VideoService>(); // 视频服务

  final RxList<Video> videos = <Video>[].obs; // 视频列表
  final RxBool isLoading = false.obs; // 是否正在加载
  final RxBool hasMore = true.obs; // 是否还有更多数据
  final RxBool isInit = true.obs; // 是否是初始化状态

  final int pageSize = 20; // 每页数据量
  int page = 0; // 当前页码

  PopularVideoController({required this.sortId});

  Future<void> fetchVideos({bool refresh = false}) async {
    if (refresh) {
      // 刷新时重置分页和清空数据
      page = 0;
      hasMore.value = true;
    }
    if (!hasMore.value || isLoading.value) return;

    isLoading.value = true;

    try {
      ApiResult<PageData<Video>> result =
          await _videoService.fetchVideosByParams(
        params: {'sort': sortId},
        page: page,
        limit: pageSize,
      );

      if (result.isFail) {
        Get.snackbar('错误', result.message);
        return;
      }

      List<Video> newVideos = result.data!.results;

      if (refresh) {
        videos.value = newVideos;
      } else {
        videos.addAll(newVideos);
      }
      page++;

      if (newVideos.length < pageSize) {
        hasMore.value = false;
      }

      page++;
    } catch (e) {
      LogUtils.e('获取视频列表失败', tag: 'PopularVideoController', error: e);
      Get.snackbar('错误', '处理请求时出现错误');
    } finally {
      isLoading.value = false;
      isInit.value = false;
    }
  }
}
