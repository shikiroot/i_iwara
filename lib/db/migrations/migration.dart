import 'package:sqlite3/sqlite3.dart';

/// 迁移基类
abstract class Migration {
  /// 迁移版本
  int get version;

  /// 迁移描述
  String get description;

  /// 执行迁移操作
  void up(Database db);

  /// 回滚迁移操作（可选）
  void down(Database db);
}
