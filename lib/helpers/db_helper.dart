import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DbHelper {
  static Future<sql.Database> database() async {
    // create a database path
    final dbpath = await sql.getDatabasesPath();
    // open the database or create new if now available
    return sql.openDatabase(path.join(dbpath, 'places.db'),
        onCreate: (db, version) {
      //execute the database query
      return db.execute(
          'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT)');
    }, version: 1);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    // insert the data to the database
    final db = await DbHelper.database();
    db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DbHelper.database();
    return db.query(table);
  }
}
