import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Models/user_model.dart';
import '../Utils/debug_purpose.dart';

class HomeProvider extends ChangeNotifier {
  static final HomeProvider _instance = HomeProvider._internal();

  factory HomeProvider() {
    return _instance;
  }

  HomeProvider._internal();

  List<UserModel> _users = [];
  List<UserModel> _searchedUsers = [];
  bool _isLoading = false;
  bool _isMenuOpened = false;
  bool _isSearching = false;
  TextEditingController searchController = TextEditingController();

  List<UserModel> get users => _users;

  bool get isSearching => _isSearching;

  List<UserModel> get searchedUsers => _searchedUsers;

  bool get isLoading => _isLoading;

  bool get isMenuOpened => _isMenuOpened;

  set isSearching(bool value) {
    _isSearching = value;
    notifyListeners();
  }

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

  set searchedUsers(List<UserModel> userData) {
    _searchedUsers = userData;
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

  void searchUsers(String query) {
    _searchedUsers = _users
        .where(
          (user) =>
              user.name.toLowerCase().contains(query.toLowerCase()) ||
              user.email.toLowerCase().contains(query.toLowerCase()) ||
              user.phone.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
  }
}
