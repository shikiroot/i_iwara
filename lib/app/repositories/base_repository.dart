
import '../../db/database_service.dart';

abstract class BaseRepository {
  final DatabaseService databaseService = DatabaseService();

  BaseRepository();
}