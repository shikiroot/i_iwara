import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

import 'package:i_iwara/utils/logger_utils.dart';

class StorageService {
  static final StorageService _instance = StorageService._internal();

  factory StorageService() => _instance;

  StorageService._internal();

  late final GetStorage _box;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Future<void> init() async {
    await GetStorage.init();
    _box = GetStorage();
  }

  //==================== 非安全存储 ====================
  Future<void> writeData(String key, dynamic value) async {
    await _box.write(key, value);
  }

  T? readData<T>(String key) {
    return _box.read<T>(key);
  }

  Future<void> deleteData(String key) async {
    await _box.remove(key);
  }

  Future<void> clearAll() async {
    await _box.erase();
    await _secureStorage.deleteAll();
  }

  //==================== 安全存储 ====================
  Future<void> writeSecureData(String key, String value) async {
    await _secureStorage.write(key: key, value: value);
  }

  Future<String?> readSecureData(String key) async {
    try {
      return await _secureStorage.read(key: key);
    } on PlatformException catch (e) {
      // 处理解密错误
      if (e.message?.contains('BAD_DECRYPT') ?? false) {
        LogUtils.w('安全存储解密失败，正在清理所有数据');
        await _secureStorage.deleteAll();
      }
      return null;
    } catch (e) {
      LogUtils.e('读取安全存储数据失败: $e');
      return null;
    }
  }

  Future<void> deleteSecureData(String key) async {
    await _secureStorage.delete(key: key);
  }

  Future<void> writeSecureObject(String key, Map<String, dynamic> value) async {
    final string = json.encode(value);
    await writeSecureData(key, string);
  }

  Future<Map<String, dynamic>?> readSecureObject(String key) async {
    try {
      final string = await readSecureData(key);
      if (string == null) return null;
      return json.decode(string) as Map<String, dynamic>;
    } catch (e) {
      LogUtils.e('读取安全存储对象失败: $e');
      return null;
    }
  }
}
