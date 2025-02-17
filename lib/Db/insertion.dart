import 'package:offiql/Models/address_model.dart';
import 'package:offiql/Models/user_model.dart';
import 'package:sqflite/sqflite.dart';

import '../Utils/debug_purpose.dart';
import 'base.dart';

class DbInsert {
  static final DbInsert _instance = DbInsert._internal();

  DbInsert._internal();

  factory DbInsert() {
    return _instance;
  }

  DbHelper dbHelper = DbHelper();

  Future<int> insertUser(UserModel model) async {
    final db = await dbHelper.dataBase;
    try {
      return await db.insert(userTable, model.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (e) {
      printRed("Error: $e");
      rethrow;
    }
  }

  Future<int> insertAddress(Address model) async {
    final db = await dbHelper.dataBase;

    try {
      int id = await db.insert(addressTable, model.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
      return id;
    } catch (error) {
      printRed('Address is not inserted $error');
      return 0;
    }
  }
}
