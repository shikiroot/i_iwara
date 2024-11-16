import 'package:get/get.dart';
import 'package:i_iwara/app/models/api_result.model.dart';
import 'package:i_iwara/app/models/image.model.dart';
import 'package:i_iwara/app/services/gallery_service.dart';
import 'package:i_iwara/utils/logger_utils.dart';

import '../../../../../common/enums/media_enums.dart';
import '../../video_detail/controllers/related_media_controller.dart';

class GalleryDetailController extends GetxController {
  final String imageModelId;
  final GalleryService _galleryService = Get.find();

  GalleryDetailController(this.imageModelId);

  final Rxn<String> errorMessage = Rxn<String>(); // 错误信息
  final Rxn<ImageModel> imageModelInfo = Rxn<ImageModel>(); // 图片模型
  final RxBool isImageModelInfoLoading = true.obs; // 是否正在加载图片模型信息
  final RxBool isCommentSheetVisible = false.obs;
  final RxBool isDescriptionExpanded = false.obs;

  OtherAuthorzMediasController? otherAuthorzImageModelsController;

  @override
  void onInit() {
    super.onInit();
    fetchVideoDetail();
  }

  /// 获取视频详情信息
  void fetchVideoDetail() async {
    try {
      isImageModelInfoLoading.value = true;
      errorMessage.value = null;

      // 获取视频基本信息
      ApiResult<ImageModel> res =
          await _galleryService.fetchGalleryDetail(imageModelId);
      if (!res.isSuccess) {
        errorMessage.value = res.message;
        Get.snackbar('错误', res.message);
        return;
      }
      otherAuthorzImageModelsController ??= OtherAuthorzMediasController(
        mediaId: imageModelId,
        userId: res.data!.user!.id,
        mediaType: MediaType.IMAGE,
      );
      otherAuthorzImageModelsController?.fetchRelatedMedias();
      imageModelInfo.value = res.data;

    } finally {
      LogUtils.d('图片详情信息加载完成', 'GalleryDetailController');
      isImageModelInfoLoading.value = false;
    }
  }
}
