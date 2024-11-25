import 'dart:io';

import 'package:i_iwara/common/constants.dart';
import 'package:i_iwara/utils/logger_utils.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';

import 'migration_manager.dart';

/// 数据库异常
class DatabaseException implements Exception {
  final String message;

  DatabaseException(this.message);

  @override
  String toString() => '数据库异常: $message';
}

/// 数据库服务
class DatabaseService {
  // 单例模式
  static final DatabaseService _instance = DatabaseService._internal();

  factory DatabaseService() => _instance;

  DatabaseService._internal();

  late Database _db;
  final MigrationManager _migrationManager = MigrationManager();

  Future<void> init() async {
    try {
      Directory documentsDirectory = await getApplicationDocumentsDirectory();
      String appDirPath =
          join(documentsDirectory.path, CommonConstants.applicationName);

      // 确保应用目录存在
      final appDir = Directory(appDirPath);
      if (!await appDir.exists()) {
        await appDir.create(recursive: true);
      }

      String path = join(appDirPath, "i_iwara.db");
      LogUtils.i('数据库路径：$path', 'DatabaseService');

      // 打开数据库，如果不存在则创建
      _db = sqlite3.open(path);
      LogUtils.d('数据库已打开，路径：$path', 'DatabaseService');

      // 运行迁移
      _migrationManager.runMigrations(_db);
    } catch (e) {
      LogUtils.e('数据库初始化失败', tag: 'DatabaseService', error: e);
      throw DatabaseException("数据库初始化失败: $e");
    }
  }

  /// 获取数据库实例
  Database get database => _db;

  /// 关闭数据库
  void close() {
    _db.dispose();
    LogUtils.d('数据库已关闭', 'DatabaseService');
  }

  /// 删除旧数据库【仅用于开发】
  Future<void> deleteOldDatabase() async {
    try {
      Directory documentsDirectory = await getApplicationDocumentsDirectory();
      String appDirPath =
          join(documentsDirectory.path, CommonConstants.applicationName);

      String path = join(appDirPath, "i_iwara.db");
      File oldDb = File(path);
      if (await oldDb.exists()) {
        await oldDb.delete();
        LogUtils.d('删除旧数据库成功', 'DatabaseService');
      }
    } catch (e) {
      LogUtils.e('删除旧数据库失败', error: e);
    }
  }
}
