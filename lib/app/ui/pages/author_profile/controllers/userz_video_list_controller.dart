import 'package:get/get.dart';
import 'package:i_iwara/app/models/page_data.model.dart';
import 'package:i_iwara/utils/logger_utils.dart';

import '../../../../models/api_result.model.dart';
import '../../../../models/video.model.dart';
import '../../../../services/video_service.dart';

class VideoListController extends GetxController {
  late VideoService _videoService;
  final Function({int? count})? onFetchFinished;

  /// 参数
  final Rxn<String> userId = Rxn<String>();
  final Rxn<String> sort = Rxn<String>();

  final RxInt page = 0.obs;
  final RxInt totalCnts = 0.obs;
  final RxList<Video> videos = <Video>[].obs;
  final RxBool isLoading = true.obs;
  var hasMore = true.obs;

  VideoListController({this.onFetchFinished});

  @override
  void onInit() {
    super.onInit();
    _videoService = Get.find<VideoService>();

    // 当sort变化后，重置分页等参数
    ever(sort, (_) {
      fetchVideos(refresh: true);
    });
  }

  Future<void> fetchVideos({bool refresh = false}) async {
    final tempPage = refresh ? 0 : page.value;

    if (!hasMore.value && !refresh) return;

    isLoading(true);
    try {
      ApiResult<PageData<Video>> response = await _videoService
          .fetchVideosByParams(page: tempPage, limit: 20, params: {
        'sort': sort.value,
        'rating': 'all',
        'userId': userId.value,
      });

      LogUtils.d(
          '[视频搜索controller] 查询参数: userId: ${userId.value}, sort: ${sort.value}, page: $tempPage');

      if (!response.isSuccess) {
        Get.snackbar('错误', response.message);
        return;
      }
      final newVideos = response.data!.results;

      if (refresh) {
        videos.clear();
      }

      videos.addAll(newVideos);
      page.value = tempPage + 1;
      hasMore.value = newVideos.isNotEmpty;
      onFetchFinished?.call(count: response.data!.count);
    } finally {
      isLoading(false);
    }
  }
}
