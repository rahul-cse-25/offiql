import 'dart:convert';

import 'package:flutter/material.dart';

import '../Models/user_model.dart';

import 'package:http/http.dart' as http;

import '../Utils/debug_purpose.dart';

class HomeProvider extends ChangeNotifier {
  static final HomeProvider _instance = HomeProvider._internal();

  factory HomeProvider() {
    return _instance;
  }

  HomeProvider._internal();

  List<UserModel> _users = [];
  bool _isLoading = false;
  bool _isMenuOpened = false;

  List<UserModel> get users => _users;

  bool get isLoading => _isLoading;

  bool get isMenuOpened => _isMenuOpened;

  void toggleMenu(bool value) {
    _isMenuOpened = value;
    notifyListeners();
  }

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  set users(List<UserModel> userData) {
    _users = userData;
    notifyListeners();
  }

  // Add new user
  void addUser(UserModel user) {
    _users.add(user);
    notifyListeners();
  }

  Future<void> fetchUsers() async {
    if (isLoading) return;
    isLoading = true;
    try {
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
      if (response.statusCode == 200) {
        List<dynamic> userList = json.decode(response.body);

        users = userList.map((user) => UserModel.fromMap(user)).toList();
      } else {
        throw Exception('Failed to load users');
      }
    } catch (e) {
      printRed("Error fetching users: $e");
    } finally {
      isLoading = false;
    }
  }
}
