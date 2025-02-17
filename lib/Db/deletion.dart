import 'base.dart';

class DbDelete{
  static final DbDelete _instance = DbDelete._internal();

  DbDelete._internal();

  factory DbDelete() {
    return _instance;
  }

  DbHelper dbHelper=DbHelper();

  Future<void> deleteUsersData(String userId) async {
    final db = await dbHelper.dataBase;
    await db.delete(userTable, where: "userId=?", whereArgs: [userId]);
  }

  Future<bool> deleteAddressData(String userId) async {
    final db = await dbHelper.dataBase;
    try {
      await db.delete(addressTable, where: "userId=?", whereArgs: [userId]);
      return true;
    } catch (e) {
      return false;
    }
  }
}