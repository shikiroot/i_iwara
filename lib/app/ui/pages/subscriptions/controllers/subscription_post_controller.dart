import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_iwara/app/models/api_result.model.dart';
import 'package:i_iwara/app/models/page_data.model.dart';
import 'package:i_iwara/app/models/post.model.dart';
import 'package:i_iwara/app/routes/app_routes.dart';
import 'package:i_iwara/app/services/post_service.dart';
import 'package:i_iwara/app/ui/widgets/error_widget.dart';
import 'package:i_iwara/i18n/strings.g.dart' as slang;
import 'package:i_iwara/utils/proxy/proxy_util.dart';
import 'package:i_iwara/utils/widget_extensions.dart';

class SubscriptionPostController extends GetxController {
  final PostService _postService = Get.find();
  
  final RxList<PostModel> posts = <PostModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool hasMore = true.obs;
  final RxString selectedUserId = ''.obs;
  final Rxn<Widget> errorWidget = Rxn<Widget>();
  
  int _currentPage = 0;

  Future<void> loadPosts({bool refresh = false}) async {
    if (!hasMore.value && !refresh || isLoading.value) {
      return;
    }
    
    try {
      isLoading.value = true;
      
      if (refresh) {
        _currentPage = 0;
        posts.clear();
        hasMore.value = true;
      }
      
      final params = <String, dynamic>{
        if (selectedUserId.isNotEmpty) 'user': selectedUserId.value,
        if (selectedUserId.isEmpty) 'subscribed': true,
      };
      
      ApiResult<PageData<PostModel>> result = await _postService.fetchPostList(
        params: params,
        page: _currentPage,
        limit: 20,
      );
      
      if (result.isSuccess && result.data != null) {
        final pageData = result.data!;
        posts.addAll(pageData.results);
        hasMore.value = pageData.results.length == pageData.limit;
        if (hasMore.value) _currentPage++;
      } else {
        errorWidget.value = CommonErrorWidget(
          text: slang.t.errors.errorOccurredWhileProcessingRequest,
          children: [
            if (ProxyUtil.isSupportedPlatform())
              ElevatedButton(
                onPressed: () => {Get.toNamed(Routes.PROXY_SETTINGS_PAGE)},
                child: Text(slang.t.common.checkNetworkSettings),
              ).paddingRight(10),
            ElevatedButton(
              onPressed: () => loadPosts(refresh: true),
              child: Text(slang.t.common.refresh),
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
      loadPosts(refresh: true);
    }
  }

  @override
  void onInit() {
    super.onInit();
    loadPosts();
  }
} 