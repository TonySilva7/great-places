import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

class DbUtil {
  static Future<Database> database() async {
    final dbPath = await getDatabasesPath();

    return openDatabase(
      path.join(dbPath, 'places.db'),
      // função que executa quando o banco é criado pela primeira vez
      onCreate: (db, version) => db.execute(
        'CREATE TABLE places (id TEXT PRIMARY KEY, title TEXT, image TEXT)',
      ),
      version: 1,
    );
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DbUtil.database();

    db.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DbUtil.database();
    return db.query(table);
  }

  static Future<void> delete(String table, String id) async {
    final db = await DbUtil.database();
    db.delete(table, where: 'id = ?', whereArgs: [id]);
  }

  static Future<void> deleteAll(String table) async {
    final db = await DbUtil.database();
    db.delete(table);
  }

  static Future<void> update(String table, String id, Map<String, Object> data) async {
    final db = await DbUtil.database();
    db.update(table, data, where: 'id = ?', whereArgs: [id]);
  }
}
