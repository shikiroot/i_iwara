import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:i_iwara/app/services/config_service.dart';
import 'package:i_iwara/common/constants.dart';
import 'package:i_iwara/i18n/strings.g.dart';
import 'package:i_iwara/utils/logger_utils.dart';
import 'package:yaml/yaml.dart';

class VersionService extends GetxService {
  final ConfigService _configService = Get.find();
  final Dio _dio = Dio();

  final currentVersion = ''.obs;
  final latestVersion = ''.obs;
  final hasUpdate = false.obs;
  final isChecking = false.obs;
  final errorMessage = ''.obs;
  
  Future<VersionService> init() async {
    // 从 pubspec.yaml 读取当前版本
    currentVersion.value = const String.fromEnvironment('VERSION', 
      defaultValue: CommonConstants.VERSION);
    return this;
  }

  Future<void> checkUpdate() async {
    try {
      isChecking.value = true;
      errorMessage.value = '';
      
      final response = await _dio.get(
        _configService[ConfigService.REMOTE_REPO_PUB_SPEC_YAML_URL],
      );
      
      if (response.statusCode == 200) {
        final yaml = loadYaml(response.data);
        final remoteVersion = yaml['version']?.toString().split('+')[0];
        
        if (remoteVersion != null) {
          latestVersion.value = remoteVersion;
          hasUpdate.value = _compareVersions(
            currentVersion.value,
            latestVersion.value,
          );
        }
      }
    } catch (e) {
      LogUtils.e('检查更新失败', error: e, tag: 'VersionService');
      errorMessage.value = t.settings.checkForUpdatesFailed;
      hasUpdate.value = false;
    } finally {
      isChecking.value = false;
    }
  }

  bool _compareVersions(String current, String latest) {
    List<int> currentParts = current.split('.')
        .map((e) => int.tryParse(e) ?? 0).toList();
    List<int> latestParts = latest.split('.')
        .map((e) => int.tryParse(e) ?? 0).toList();

    for (int i = 0; i < 3; i++) {
      int currentPart = i < currentParts.length ? currentParts[i] : 0;
      int latestPart = i < latestParts.length ? latestParts[i] : 0;
      
      if (latestPart > currentPart) return true;
      if (latestPart < currentPart) return false;
    }
    
    return false;
  }
} 