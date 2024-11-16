import 'package:get/get.dart';
import 'package:i_iwara/app/services/gallery_service.dart';
import 'package:i_iwara/app/services/video_service.dart';
import 'package:i_iwara/utils/logger_utils.dart';

import '../../../../../common/enums/media_enums.dart';
import '../../../../models/image.model.dart';
import '../../../../models/video.model.dart';

// 相关xx
class RelatedMediasController extends GetxController {
  final String mediaId;
  final MediaType mediaType;
  final VideoService _videoService = Get.find();
  final GalleryService _galleryService = Get.find();

  var videos = <Video>[].obs;
  var imageModels = <ImageModel>[].obs;
  var isLoading = true.obs;
  var hasError = false.obs;
  var errorMessage = ''.obs;

  RelatedMediasController({required this.mediaId, required this.mediaType});

  @override
  void onInit() {
    super.onInit();
    LogUtils.d('相关初始化', 'RelatedMediasController');
    fetchRelatedMedias();
  }

  Future<void> fetchRelatedMedias() async {
    try {
      isLoading.value = true;
      hasError.value = false;
      errorMessage.value = '';

      switch (mediaType) {
        case MediaType.VIDEO:
          final response =
              await _videoService.fetchRelatedVideosByVideoId(mediaId);
          if (response.isSuccess) {
            videos.value = response.data!.results;
          } else {
            hasError.value = true;
            errorMessage.value = response.message;
          }
        case MediaType.IMAGE:
          final response =
              await _galleryService.fetchRelatedImagesByImageId(mediaId);
          if (response.isSuccess) {
            imageModels.value = response.data!.results;
          } else {
            hasError.value = true;
            errorMessage.value = response.message;
          }
      }
    } finally {
      isLoading.value = false;
    }
  }

  void retry() {
    fetchRelatedMedias();
  }
}

// 作者的其他xx
class OtherAuthorzMediasController extends GetxController {
  final String mediaId;
  final MediaType mediaType;
  final String userId;
  final VideoService _videoService = Get.find();
  final GalleryService _galleryService = Get.find();

  var videos = <Video>[].obs;
  var imageModels = <ImageModel>[].obs;
  var isLoading = true.obs;
  var hasError = false.obs;
  var errorMessage = ''.obs;

  OtherAuthorzMediasController(
      {required this.mediaId, required this.userId, required this.mediaType});

  @override
  void onInit() {
    super.onInit();
    LogUtils.d('作者其他初始化', 'OtherAuthorzMediasController');
    fetchRelatedMedias();
  }

  Future<void> fetchRelatedMedias() async {
    try {
      isLoading.value = true;
      hasError.value = false;
      errorMessage.value = '';

      switch (mediaType) {
        case MediaType.VIDEO:
          final response = await _videoService.fetchAuthorVideos(userId,
              excludeVideoId: mediaId);
          if (response.isSuccess) {
            videos.value = response.data!.results;
          } else {
            hasError.value = true;
            errorMessage.value = response.message;
          }
        case MediaType.IMAGE:
          final response = await _galleryService.fetchAuthorImages(userId,
              excludeImageId: mediaId);
          if (response.isSuccess) {
            imageModels.value = response.data!.results;
          } else {
            hasError.value = true;
            errorMessage.value = response.message;
          }
      }
    } finally {
      isLoading.value = false;
    }
  }

  void retry() {
    fetchRelatedMedias();
  }
}
