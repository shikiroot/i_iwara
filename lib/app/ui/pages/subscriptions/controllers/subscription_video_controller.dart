import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_iwara/app/models/api_result.model.dart';
import 'package:i_iwara/app/models/page_data.model.dart';
import 'package:i_iwara/app/models/video.model.dart';
import 'package:i_iwara/app/services/video_service.dart';
import 'package:i_iwara/utils/widget_extensions.dart';

import '../../../../../utils/proxy/proxy_util.dart';
import '../../../../routes/app_routes.dart';
import '../../../widgets/error_widget.dart';

class SubscriptionVideoController extends GetxController {
  final VideoService _videoService = Get.find();

  final RxList<Video> videos = <Video>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool hasMore = true.obs;
  final Rxn<Widget> errorWidget = Rxn<Widget>();
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

      ApiResult<PageData<Video>> result =
          await _videoService.fetchVideosByParams(
        params: params,
        page: _currentPage,
        limit: 20,
      );

      if (result.isSuccess && result.data != null) {
        final pageData = result.data!;
        videos.addAll(pageData.results);
        hasMore.value = pageData.results.length == pageData.limit;
        if (hasMore.value) _currentPage++;
      } else {
        errorWidget.value = CommonErrorWidget(
          text: '处理请求时出现错误',
          children: [
            if (ProxyUtil.isSupportedPlatform())
              ElevatedButton(
                onPressed: () => {Get.toNamed(Routes.PROXY_SETTINGS_PAGE)},
                child: const Text('检查网络设置'),
              ).paddingRight(10),
            ElevatedButton(
              onPressed: () => loadVideos(refresh: true),
              child: const Text('刷新'),
            ),
          ],
        );
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
