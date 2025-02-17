// import 'package:flutter/material.dart';
// // import '../models/user_model.dart';
//
// class UserProvider extends ChangeNotifier {
//   static final UserProvider _instance = UserProvider._internal();
//
//   factory UserProvider() {
//     return _instance;
//   }
//
//   UserProvider._internal();
//
//   List<UserModel> _users = [];
//   bool _isLoading = false;
//
//   List<UserModel> get users => _users;
//   bool get isLoading => _isLoading;
//
//   // Fetch users from API or local storage
//   Future<void> fetchUsers(List<Map<String, dynamic>> userData) async {
//     _isLoading = true;
//     notifyListeners();
//
//     try {
//       _users = userData.map((user) => UserModel.fromMap(user)).toList();
//     } catch (e) {
//       debugPrint("Error fetching users: $e");
//     }
//
//     _isLoading = false;
//     notifyListeners();
//   }
//
//   // Add new user
//   void addUser(UserModel user) {
//     _users.add(user);
//     notifyListeners();
//   }
//
//   // Update existing user
//   void updateUser(int id, UserModel updatedUser) {
//     int index = _users.indexWhere((user) => user.id == id);
//     if (index != -1) {
//       _users[index] = updatedUser;
//       notifyListeners();
//     }
//   }
//
//   // Delete user
//   void deleteUser(int id) {
//     _users.removeWhere((user) => user.id == id);
//     notifyListeners();
//   }
//
//   // Get user by ID
//   UserModel? getUserById(int id) {
//     return _users.firstWhere((user) => user.id == id, orElse: () => UserModel.empty());
//   }
// }
