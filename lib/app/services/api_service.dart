// api_service.dart

import 'package:dio/dio.dart' as dio;
import 'package:dio/io.dart';
import 'package:get/get.dart';
import '../../common/constants.dart';
import '../../utils/logger_utils.dart';
import '../routes/app_routes.dart';
import 'auth_service.dart';

class ApiService extends GetxService {
  late dio.Dio _dio;
  final AuthService _authService = Get.find<AuthService>();
  final String _tag = 'ApiService';

  Future<ApiService> init() async {
    _dio = dio.Dio(dio.BaseOptions(
      baseUrl: CommonConstants.iwaraApiBaseUrl,
      connectTimeout: const Duration(seconds: 45000),
      receiveTimeout: const Duration(seconds: 45000),
      headers: {
        'Content-Type': 'application/json',
        'User-Agent':
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36',
      },
    ));

    // 添加拦截器
    _dio.interceptors.add(dio.InterceptorsWrapper(
      onRequest: (options, handler) {
        LogUtils.d(
            '请求: Method: ${options.method} Path: ${options.path} Params: ${options.queryParameters} Body: ${options.data}',
            _tag);
        if (_authService.accessToken != null) {
          options.headers['Authorization'] =
              'Bearer ${_authService.accessToken}';
        }
        return handler.next(options);
      },
      onError: (dio.DioException error, handler) async {
        // 如果返回401，尝试刷新token
        if (error.response?.statusCode == 401) {
          LogUtils.e('遭遇401错误，尝试刷新token', tag: _tag);
          try {
            await _authService.refreshAccessToken();
            final options = error.requestOptions;
            options.headers['Authorization'] =
                'Bearer ${_authService.accessToken}';

            final response = await _dio.fetch(options);
            return handler.resolve(response);
          } on UnauthorizedException {
            await _authService.logout();
            Get.offAllNamed(Routes.LOGIN);
            return;
          } on AuthServiceException catch (e) {
            LogUtils.e(
              '认证服务异常: ${e.message}',
              tag: _tag,
              error: e,
            );
            await _authService.logout();
            Get.offAllNamed(Routes.LOGIN);
            return handler.next(error);
          }
        } else if (error.response?.statusCode == 403) {
          LogUtils.e('遭遇403错误，权限不足', tag: _tag);
          Get.snackbar('权限不足', '您没有权限访问此资源');
          return handler.next(error);
        }
        LogUtils.e('请求失败', tag: _tag, error: error);
        return handler.next(error);
      },
    ));

    return this;
  }

  Future<dio.Response<T>> get<T>(String path,
      {Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    try {
      return await _dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: dio.Options(headers: headers),
      );
    } on dio.DioException catch (e) {
      LogUtils.e('GET请求失败: ${e.message}, Path: $path', tag: _tag, error: e);
      rethrow;
    }
  }

  Future<dio.Response<T>> post<T>(String path,
      {dynamic data, Map<String, dynamic>? queryParameters}) async {
    try {
      return await _dio.post<T>(path,
          data: data, queryParameters: queryParameters);
    } on dio.DioException catch (e) {
      LogUtils.e('POST请求失败: ${e.message}', tag: _tag, error: e);
      rethrow;
    }
  }

  Future<dio.Response<T>> delete<T>(String path,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      return await _dio.delete<T>(path, queryParameters: queryParameters);
    } on dio.DioException catch (e) {
      LogUtils.e('DELETE请求失败: ${e.message}', tag: _tag, error: e);
      rethrow;
    }
  }

  // resetProxy
  void resetPrroxy() {
    _dio.httpClientAdapter = IOHttpClientAdapter();
  }
}
