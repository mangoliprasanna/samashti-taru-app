import 'package:path/path.dart';
import 'package:samashti_app/data/data_contract.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static DBHelper _dbHelper;
  static Database _database;

  DBHelper.createInstance();

   factory DBHelper() {
    if (_dbHelper == null) {
      _dbHelper = DBHelper.createInstance();
    }
    return _dbHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    print("Returning Database instance");
    return _database;
  }

   Future<Database> initializeDatabase() async {
     print("Database initialize");
    String path = join(await getDatabasesPath(), SamashtiDb.DATABASE_NAME);
    return openDatabase(path, version: SamashtiDb.DATABASE_VERSION,
        onCreate: (db, version) {
          db.execute(UserTable.createStatement);
          db.execute(PostTable.createStatement);
      return db;
    });
  }
}