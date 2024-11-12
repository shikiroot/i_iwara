import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import '../../utils/constants.dart';
import '../../utils/logger_utils.dart';
import '../models/api_result.model.dart';
import '../routes/app_routes.dart';
import 'auth_service.dart';
import '../models/user.model.dart';
import 'api_service.dart';

class UserService extends GetxService {
  final AuthService _authService = Get.find<AuthService>();
  final ApiService _apiService = Get.find<ApiService>();

  final String _tag = '[UserService]';

  Rxn<User?> currentUser = Rxn<User>();

  bool get isLogin => currentUser.value != null;

  String get userAvatar =>
      currentUser.value?.avatar?.avatarUrl ?? CommonConstants.defaultAvatarUrl;

  Future<UserService> init() async {
    LogUtils.d('$_tag 初始化用户服务');
    if (_authService.hasToken) {
      try {
        LogUtils.d('$_tag 存在TOKEN，尝试获取用户资料');
        await fetchUserProfile();
      } on UnauthorizedException {
        LogUtils.d('$_tag TOKEN失效，重新登录');
        await _authService.logout();
        Get.offAllNamed(Routes.LOGIN);
      } on AuthServiceException catch (e) {
        LogUtils.e('$_tag 初始化用户失败', error: e);
        Get.snackbar("错误", e.message);
        await _authService.logout();
        Get.offAllNamed(Routes.LOGIN);
      }
    } else {
      LogUtils.d('$_tag 未登录');
    }
    return this;
  }

  // 抓取用户资料
  Future<void> fetchUserProfile() async {
    try {
      LogUtils.d('$_tag 抓取用户资料'); // 替换 logger.d
      final response = await _apiService.get<Map<String, dynamic>>('/user');
      currentUser.value = User.fromJson(response.data!['user']);
      LogUtils.d('$_tag 用户资料: ${currentUser.value}');
    } on dio.DioException catch (e) {
      LogUtils.e('遭遇网络错误', error: e);
      if (e.response?.statusCode == 401) {
        throw UnauthorizedException("会话已过期，请重新登录");
      } else {
        throw AuthServiceException("抓取用户资料失败");
      }
    } catch (e) {
      LogUtils.e('抓取用户资料失败', error: e);
      throw AuthServiceException("未知错误");
    }
  }

  // 登录
  Future<void> logout() async {
    try {
      await _authService.logout();
      currentUser.value = null;
    } catch (e) {
      LogUtils.e('用户登出失败', error: e);
      throw AuthServiceException("未知错误");
    }
  }

  /// 关注
  Future<ApiResult> followUser(String userId) async {
    // 检查用户ID是否为空
    if (userId.isEmpty) {
      return ApiResult.fail("用户ID不能为空");
    }

    // 登录
    if (!_authService.hasToken) {
      Get.toNamed(Routes.LOGIN);
      return ApiResult.fail("请先登录");
    }

    try {
      await _apiService.post(ApiConstants.userFollowOrUnfollow(userId));
      return ApiResult.success();
    } catch (e) {
      LogUtils.e('关注失败', error: e);
      return ApiResult.fail("关注失败");
    }
  }

  /// 取消关注
  Future<ApiResult> unfollowUser(String userId) async {
    // 检查用户ID是否为空
    if (userId.isEmpty) {
      return ApiResult.fail("用户ID不能为空");
    }

    // 登录
    if (!_authService.hasToken) {
      Get.toNamed(Routes.LOGIN);
      return ApiResult.fail("请先登录");
    }

    try {
      await _apiService.delete(ApiConstants.userFollowOrUnfollow(userId));
      return ApiResult.success();
    } catch (e) {
      LogUtils.e('取消关注失败', error: e);
      return ApiResult.fail("取消关注失败");
    }
  }

  /// 添加朋友
  Future<ApiResult> removeFriend(String userId) async {
    // 检查用户ID是否为空
    if (userId.isEmpty) {
      return ApiResult.fail("用户ID不能为空");
    }

    // 登录
    if (!_authService.hasToken) {
      Get.toNamed(Routes.LOGIN);
      return ApiResult.fail("请先登录");
    }

    try {
      await _apiService.delete(ApiConstants.userAddOrRemoveFriend(userId));
      return ApiResult.success();
    } catch (e) {
      LogUtils.e('移除朋友失败', error: e);
      return ApiResult.fail("移除朋友失败");
    }
  }

  /// 发送朋友申请
  Future<ApiResult> addFriend(String userId) async {
    // 检查用户ID是否为空
    if (userId.isEmpty) {
      return ApiResult.fail("用户ID不能为空");
    }

    // 登录
    if (!_authService.hasToken) {
      Get.toNamed(Routes.LOGIN);
      return ApiResult.fail("请先登录");
    }

    try {
      await _apiService.post(ApiConstants.userAddOrRemoveFriend(userId));
      return ApiResult.success();
    } catch (e) {
      LogUtils.e('发送朋友申请失败', error: e);
      return ApiResult.fail("发送朋友申请失败");
    }
  }
}
