import 'package:get/get.dart';
import 'package:i_iwara/app/models/api_result.model.dart';
import 'package:i_iwara/app/models/page_data.model.dart';
import 'package:i_iwara/app/models/video.model.dart';
import 'package:i_iwara/app/services/video_service.dart';

class SubscriptionVideoController extends GetxController {
  final VideoService _videoService = Get.find();
  
  final RxList<Video> videos = <Video>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool hasMore = true.obs;
  int _currentPage = 0;
  final RxString selectedUserId = ''.obs;
  
  Future<void> loadVideos({bool refresh = false}) async {
    if (!hasMore.value && !refresh || isLoading.value) {
      return;
    }
    
    try {
      isLoading.value = true;

      if (refresh) {
        _currentPage = 0;
        videos.clear();
        hasMore.value = true;
      }
      
      final params = <String, dynamic>{
        if (selectedUserId.isNotEmpty) 'user': selectedUserId.value,
        if (selectedUserId.isEmpty) 'subscribed': true,
      };
      
      ApiResult<PageData<Video>> result = await _videoService.fetchVideosByParams(
        params: params,
        page: _currentPage,
        limit: 20,
      );
      
      if (result.isSuccess && result.data != null) {
        final pageData = result.data!;
        videos.addAll(pageData.results);
        hasMore.value = pageData.results.length == pageData.limit;
        if (hasMore.value) _currentPage++;
      }
    } finally {
      isLoading.value = false;
    }
  }
  
  void updateSelectedUserId(String userId) {
    if (selectedUserId.value != userId) {
      selectedUserId.value = userId;
      loadVideos(refresh: true);
    }
  }

  @override
  void onInit() {
    super.onInit();
    loadVideos();
  }

}