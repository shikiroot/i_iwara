import 'package:get/get.dart';

import '../../../../../utils/constants.dart';
import '../../../../models/video.model.dart';
import '../../../../services/api_service.dart';


// 相关视频
class RelatedVideoController extends GetxController {
  final String videoId;
  final ApiService _apiService = Get.find();

  var videos = <Video>[].obs;
  var isLoading = true.obs;
  var hasError = false.obs;
  var errorMessage = ''.obs;

  RelatedVideoController({required this.videoId});

  @override
  void onInit() {
    super.onInit();
    fetchRelatedVideos();
  }

  Future<void> fetchRelatedVideos() async {
    try {
      isLoading.value = true;
      hasError.value = false;
      errorMessage.value = '';

      final response = await _apiService
          .get('https://api.iwara.tv/video/$videoId/related');

      final data = response.data['results'] as List;
      videos.value = data.map((json) => Video.fromJson(json)).toList();
    } catch (e) {
      hasError.value = true;
      errorMessage.value = '获取视频列表失败: $e';
    } finally {
      isLoading.value = false;
    }
  }

  void retry() {
    fetchRelatedVideos();
  }
}

// 作者的其他视频
class OtherAuthorzVideosController extends GetxController {
  final String videoId;
  final String userId;
  final ApiService _apiService = Get.find();

  var videos = <Video>[].obs;
  var isLoading = true.obs;
  var hasError = false.obs;
  var errorMessage = ''.obs;

  OtherAuthorzVideosController({required this.videoId, required this.userId});

  @override
  void onInit() {
    super.onInit();
    fetchRelatedVideos();
  }

  Future<void> fetchRelatedVideos() async {
    try {
      isLoading.value = true;
      hasError.value = false;
      errorMessage.value = '';

      final response = await _apiService
          .get('${CommonConstants.iwaraApiBaseUrl}${ApiConstants.videos()}', queryParameters: {
        'rating': 'all',
        'user': userId,
        'exclude': videoId,
        'limit': 6
      });

      final data = response.data['results'] as List;
      videos.value = data.map((json) => Video.fromJson(json)).toList();
    } catch (e) {
      hasError.value = true;
      errorMessage.value = '获取视频列表失败: $e';
    } finally {
      isLoading.value = false;
    }
  }

  void retry() {
    fetchRelatedVideos();
  }
}
