import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:get/get.dart';
import 'package:i_iwara/app/models/api_result.model.dart';
import 'package:i_iwara/app/services/config_service.dart';
import 'package:i_iwara/utils/logger_utils.dart';

class TranslationService extends GetxService {
  final ConfigService _configService = Get.find();
  final Dio _dio = Dio();

  Future<ApiResult<String>> translate(String text, {String? targetLanguage}) async {
    try {
      final response = await _dio.get(
        "https://translate.googleapis.com/translate_a/t",
        queryParameters: {
          "client": "gtx",
          "sl": "auto",
          "tl": targetLanguage ?? _configService.currentTranslationLanguage,
          "dt": "t",
          "q": text,
        },
      );
      
      String res =  response.data[0][0] as String;
      return ApiResult.success(message: '翻译成功', data: res);
    } catch (e) {
      LogUtils.e('翻译失败', tag: 'TranslationService', error: e);
      return ApiResult.fail('翻译失败');
    }
  }

  void resetProxy() {
    _dio.httpClientAdapter = IOHttpClientAdapter();
  }
} 