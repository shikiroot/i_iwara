import 'package:i_iwara/utils/logger_utils.dart';
import 'package:sqlite3/common.dart';
import 'migration.dart';

class MigrationV1Initial extends Migration {
  @override
  int get version => 1;

  @override
  String get description => "初始迁移：创建戒律签到表";

  @override
  void up(CommonDatabase db) {
    // 创建戒律签到记录表
    db.execute('''
      CREATE TABLE IF NOT EXISTS sign_in_records(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id TEXT NOT NULL,
        date TEXT NOT NULL,
        status INTEGER NOT NULL, -- 1为成功签到，0为未能坚持
        reason TEXT, -- 破戒原因，可以为空
        created_at TEXT NOT NULL DEFAULT(datetime('now')),
        updated_at TEXT NOT NULL DEFAULT(datetime('now')),
        FOREIGN KEY(user_id) REFERENCES users(id),
        UNIQUE(user_id, date)
      );
    ''');

    // 创建索引
    db.execute('''
      CREATE INDEX idx_sign_in_records_user_date
      ON sign_in_records(user_id, date);
    ''');

    // 创建触发器：自动更新updated_at
    db.execute('''
      CREATE TRIGGER trigger_sign_in_records_updated_at
      AFTER UPDATE ON sign_in_records
      BEGIN
        UPDATE sign_in_records
        SET updated_at = datetime('now')
        WHERE id = NEW.id;
      END;
    ''');

    db.execute('PRAGMA user_version=1;');
    LogUtils.i('已应用迁移v1：创建戒律签到表');
  }

  @override
  void down(CommonDatabase db) {
    db.execute('DROP TRIGGER IF EXISTS trigger_sign_in_records_updated_at;');
    db.execute('DROP INDEX IF EXISTS idx_sign_in_records_user_date;');
    db.execute('DROP TABLE IF EXISTS sign_in_records;');
    db.execute('PRAGMA user_version=0;');
    LogUtils.i('已回滚迁移v1：删除戒律签到表');
  }
}
