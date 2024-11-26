import 'package:sqlite3/common.dart';

/// 迁移基类
abstract class Migration {
  /// 迁移版本
  int get version;

  /// 迁移描述
  String get description;

  /// 执行迁移操作
  void up(CommonDatabase db);

  /// 回滚迁移操作（可选）
  void down(CommonDatabase db);
}
