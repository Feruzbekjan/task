import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class StorageRepository {
  static StorageRepository? _storageUtil;
  static Database? _database;

  StorageRepository._();

  static Future<Database> getInstanse() async {
    if (_storageUtil == null) {
      final storage = StorageRepository._();
      await storage._init();
      _storageUtil = storage;
    }
    return _database!;
  }

  Future _init() async {
    final databasaPath = await getDatabasesPath();
    final path = join(databasaPath, "my_app");

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          "CREATE TABLE my_music(id INTEGER PRIMARY KEY, title TEXT, album TEXT, artist Text, genre TEXT, source TEXT, image TEXT, trackNumber INTEGER, totalTrackCount INTEGER,  duration INTEGER, site TEXT, path TEXT  )",
        );
      },
    );
  }
}













// import 'package:shared_preferences/shared_preferences.dart';

// class StorageRepository {
//   static StorageRepository? _storageUtil;
//   static SharedPreferences? _preferences;

//   static Future<StorageRepository> getInstance() async {
//     if (_storageUtil == null) {
//       final secureStorage = StorageRepository._();
//       await secureStorage._init();
//       _storageUtil = secureStorage;
//     }
//     return _storageUtil!;
//   }

//   StorageRepository._();
//   Future _init() async {
//     _preferences = await SharedPreferences.getInstance();
//   }

//   static bool getStatus() {
//     return _preferences?.getBool("isAuthentificated") ?? false;
//   }

//   static Future<bool?> setStatus(bool value) async {
//     return await _preferences?.setBool("isAuthentificated", value);
//   }
// }
