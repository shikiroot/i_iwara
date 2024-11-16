import 'dart:async';
import 'package:dio/dio.dart' as dio;
import 'package:dio/io.dart';
import 'package:get/get.dart';
import '../../common/constants.dart';
import '../../utils/logger_utils.dart';
import '../models/api_result.model.dart';
import '../models/captcha.model.dart';
import 'storage_service.dart';

class AuthService extends GetxService {
  final StorageService _storage = StorageService();
  final dio.Dio _dio = dio.Dio(dio.BaseOptions(
    baseUrl: CommonConstants.iwaraApiBaseUrl,
    headers: {'Content-Type': 'application/json'},
  ));

  static const String _tag = '认证服务';

  String? _authToken;

  String? get authToken => _authToken;
  String? _accessToken;

  String? get accessToken => _accessToken;

  bool get hasToken => _authToken != null && _accessToken != null;

  // 刷新token的completer
  Completer<void>? _refreshTokenCompleter;

  // resetProxy
  void resetProxy() {
    _dio.httpClientAdapter = IOHttpClientAdapter();
  }

  // 初始化
  Future<AuthService> init() async {
    _authToken = await _storage.readSecureData(KeyConstants.authToken);
    _accessToken = await _storage.readSecureData(KeyConstants.accessToken);
    LogUtils.d('初始化完成, token: $_authToken, accessToken: $_accessToken', _tag);
    return this;
  }

  // 登录
  Future<ApiResult> login(String email, String password) async {
    try {
      final response = await _dio.post('/user/login', data: {
        'email': email,
        'password': password,
      });

      if (response.statusCode == 200 && response.data['token'] != null) {
        _authToken = response.data['token'];
        await _storage.writeSecureData(KeyConstants.authToken, _authToken!);
        await refreshAccessToken();
        return ApiResult.success();
      } else {
        return ApiResult.fail(response.data['message'] ?? '无效的登录');
      }
    } on dio.DioException catch (e) {
      LogUtils.e('登录失败: ${e.message}', tag: _tag);
      if (e.response != null) {
        final message = e.response?.data['message'] ?? '未知错误';
        return ApiResult.fail(message);
      } else {
        return ApiResult.fail('网络错误');
      }
    } catch (e) {
      LogUtils.e('登录过程中发生意外错误: $e', tag: _tag);
      return ApiResult.fail('未知错误');
    }
  }

  // 登出
  Future<void> logout() async {
    _authToken = null;
    _accessToken = null;
    await _storage.deleteSecureData(KeyConstants.authToken);
    await _storage.deleteSecureData(KeyConstants.accessToken);
    // TODO review
    LogUtils.d('用户已登出', _tag);
  }

  // 刷新token
  Future<bool> refreshAccessToken() async {
    if (_refreshTokenCompleter != null) {
      // 如果已经有一个刷新token的任务在执行，等待其完成
      await _refreshTokenCompleter!.future;
    }

    if (_authToken == null) {
      LogUtils.e('刷新时Auth token为空', tag: _tag);
      throw AuthServiceException('会话已过期');
    }

    _refreshTokenCompleter = Completer<void>();

    try {
      final response = await _dio.post(
        '/user/token',
        options: dio.Options(headers: {'Authorization': 'Bearer $_authToken'}),
      );

      if (response.statusCode == 200 && response.data['accessToken'] != null) {
        _accessToken = response.data['accessToken'];
        await _storage.writeSecureData(KeyConstants.accessToken, _accessToken!);
        LogUtils.d('Access token 刷新成功', _tag);
        _refreshTokenCompleter!.complete();
        _refreshTokenCompleter = null;
        return true;
      } else {
        throw AuthServiceException(response.data['message'] ?? '未知错误');
      }
    } on dio.DioException catch (e) {
      LogUtils.e('刷新token失败: ${e.message}', tag: _tag);
      if (e.response != null && e.response?.statusCode == 401) {
        throw UnauthorizedException('会话已过期');
      } else {
        throw NetworkException('网络错误');
      }
    } catch (e) {
      LogUtils.e('未知错误: $e', tag: _tag);
      throw AuthServiceException('未知错误');
    } finally {
      if (_refreshTokenCompleter != null &&
          !_refreshTokenCompleter!.isCompleted) {
        _refreshTokenCompleter!.complete();
        _refreshTokenCompleter = null;
      }
    }
  }

  // 抓取注册验证码
  Future<ApiResult<Captcha>> fetchCaptcha() async {
    try {
      final response = await _dio.get('/captcha');
      if (response.statusCode == 200) {
        LogUtils.d('成功获取验证码', _tag);
        return ApiResult.success(data: Captcha.fromJson(response.data));
      } else {
        return ApiResult.fail('获取验证码失败');
      }
    } on dio.DioException catch (e) {
      LogUtils.e('抓取验证码失败: ${e.message}', tag: _tag);
      return ApiResult.fail('网络错误');
    } catch (e) {
      LogUtils.e('未知错误: $e', tag: _tag);
      return ApiResult.fail('未知错误');
    }
  }

  // 注册新用户
  Future<ApiResult> register(
      String email, String captchaId, String captchaAnswer) async {
    try {
      final headers = {
        'X-Captcha': '$captchaId:$captchaAnswer',
      };
      final data = {
        'email': email,
        'locale': Get.locale?.countryCode ?? 'en',
      };
      final response = await _dio.post(
        '/user/register',
        data: data,
        options: dio.Options(headers: headers),
      );

      if (response.statusCode == 200 &&
          response.data['message'] == 'register.emailInstructionsSent') {
        LogUtils.d('注册成功，邮件指令已发送', _tag);
        return ApiResult.success();
      } else {
        return ApiResult.fail(response.data['message'] ?? '注册失败');
      }
    } on dio.DioException catch (e) {
      LogUtils.e('注册失败: ${e.message}', tag: _tag);
      if (e.response != null && e.response?.data != null) {
        var errorMessage = e.response!.data['errors']?[0]['message'] ??
            e.response!.data['message'] ??
            '未知错误';
        switch (errorMessage) {
          case 'errors.invalidEmail':
            return ApiResult.fail('无效的电子邮件');
          case 'errors.emailAlreadyExists':
            return ApiResult.fail('电子邮件已存在');
          case 'errors.invalidCaptcha':
            return ApiResult.fail('无效的验证码');
          default:
            return ApiResult.fail(errorMessage);
        }
      } else {
        return ApiResult.fail('网络错误');
      }
    } catch (e) {
      LogUtils.e('注册过程中发生意外错误: $e', tag: _tag);
      return ApiResult.fail('未知错误');
    }
  }
}

// 自定义异常类
class AuthServiceException implements Exception {
  final String message;

  AuthServiceException(this.message);
}

class InvalidCredentialsException extends AuthServiceException {
  InvalidCredentialsException(super.message);
}

class NetworkException extends AuthServiceException {
  NetworkException(super.message);
}

class UnauthorizedException extends AuthServiceException {
  UnauthorizedException(super.message);
}
