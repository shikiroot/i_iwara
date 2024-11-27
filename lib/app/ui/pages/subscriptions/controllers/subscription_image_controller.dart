import 'package:get/get.dart';
import 'package:i_iwara/app/models/api_result.model.dart';
import 'package:i_iwara/app/models/image.model.dart';
import 'package:i_iwara/app/models/page_data.model.dart';
import 'package:i_iwara/app/services/gallery_service.dart';

class SubscriptionImageController extends GetxController {
  final GalleryService _galleryService = Get.find();
  
  // 图片列表
  final RxList<ImageModel> images = <ImageModel>[].obs;
  // 是否正在加载
  final RxBool isLoading = false.obs;
  // 是否还有更多数据
  final RxBool hasMore = true.obs;
  // 当前页码
  int _currentPage = 0;
  // 选中的用户ID
  final RxString selectedUserId = ''.obs;
  
  // 加载图片列表
  Future<void> loadImages({bool refresh = false}) async {
    if (!hasMore.value && !refresh || isLoading.value) {
      return;
    }
    
    try {
      isLoading.value = true;
      
      if (refresh) {
        _currentPage = 0;
        images.clear();
        hasMore.value = true;
      }
      
      final params = <String, dynamic>{
        if (selectedUserId.isNotEmpty) 'user': selectedUserId.value,
        if (selectedUserId.isEmpty) 'subscribed': true,
      };
      
      ApiResult<PageData<ImageModel>> result = await _galleryService.fetchImageModelsByParams(
        params: params,
        page: _currentPage,
        limit: 20,
      );
      
      if (result.isSuccess && result.data != null) {
        final pageData = result.data!;
        images.addAll(pageData.results);
        print('加载完成 resultLength: ${pageData.results.length}, limit: ${pageData.limit}');
        hasMore.value = pageData.results.length == pageData.limit;
        if (hasMore.value) _currentPage++;
      }
    } finally {
      isLoading.value = false;
    }
  }
  
  // 更新选中的用户ID并刷新列表
  void updateSelectedUserId(String userId) {
    if (selectedUserId.value != userId) {
      selectedUserId.value = userId;
      loadImages(refresh: true);
    }
  }

  @override
  void onInit() {
    super.onInit();
    loadImages();  // 控制器初始化时加载数据
  }

} 