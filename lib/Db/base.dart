import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

String userTable = "userTable";
String addressTable = "addressTable";

class DbHelper {
  static final DbHelper _instance = DbHelper._internal();

  DbHelper._internal();

  factory DbHelper() {
    return _instance;
  }

  static Database? _database; //instance create

  Future<Database> get dataBase async {
    if (_database != null) return _database!;
    _database = await _initDataBase();

    return _database!;
  }

  Future<Database> _initDataBase() async {
    String dbPath = await getDatabasesPath(); //get the path to store
    String filePath = join(dbPath);

    return await openDatabase(filePath,
        version: 1, onCreate: _onCreate, onConfigure: _onConfigure);
  }

  Future<void> _onCreate(Database db, int version) async {
    //to execute query
    await db.execute('''
    CREATE TABLE $userTable(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      username TEXT NOT NULL,
      email TEXT NOT NULL,
      phone TEXT NOT NULL,
      website TEXT NOT NULL,
      companyName TEXT NOT NULL,
      catchPhrase TEXT NOT NULL,
      bs TEXT NOT NULL
    )
    ''');

    await db.execute('''
    CREATE TABLE $addressTable(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      street TEXT NOT NULL,
      suite TEXT NOT NULL,
      city TEXT NOT NULL,
      zipcode TEXT NOT NULL,
      lat DOUBLE NOT NULL,
      lng DOUBLE NOT NULL,
      FOREIGN KEY (userId) REFERENCES userTable(id) ON DELETE CASCADE
    )
    ''');
  }

  Future<void> _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }
}
