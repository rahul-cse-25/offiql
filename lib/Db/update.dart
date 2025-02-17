import 'package:offiql/Models/user_model.dart';

import '../Utils/debug_purpose.dart';
import 'base.dart';

class DbUpdate {
  static final DbUpdate _instance = DbUpdate._internal();

  DbUpdate._internal();

  factory DbUpdate() {
    return _instance;
  }

  DbHelper dbHelper = DbHelper();

  Future<void> updateUser(UserModel model) async {
    final db = await dbHelper.dataBase;
    try {
      await db.update(userTable, model.toMap(),
          where: 'id=?', whereArgs: [model.id]);
    } catch (error) {
      printRed("Error while updating: $error");
    }
  }
}
