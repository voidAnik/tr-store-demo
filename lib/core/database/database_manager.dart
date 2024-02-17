import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseManager {
  static Database? _db;
  static const String _dbName = 'store.db';
  static const int _version = 1;

  static Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await openDatabase(
      join(await getDatabasesPath(), _dbName),
      version: _version,
    );
    return _db!;
  }
}
