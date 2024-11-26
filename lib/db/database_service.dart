import 'package:i_iwara/utils/logger_utils.dart';
import 'package:sqlite3/common.dart' show CommonDatabase;

import 'migration_manager.dart';
import 'sqlite3/sqlite3.dart' show openSqliteDb;

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

  late CommonDatabase _db;
  final MigrationManager _migrationManager = MigrationManager();

  /// 初始化数据库
  Future<void> init() async {
    try {
      _db = await openSqliteDb();

      // 运行迁移
      _migrationManager.runMigrations(_db);
    } catch (e) {
      LogUtils.e('数据库初始化失败', tag: 'DatabaseService', error: e);
      throw DatabaseException("数据库初始化失败: $e");
    }
  }

  /// 获取数据库实例
  CommonDatabase get database => _db;

  /// 关闭数据库
  void close() {
    _db.dispose();
    LogUtils.d('数据库已关闭', 'DatabaseService');
  }

}
