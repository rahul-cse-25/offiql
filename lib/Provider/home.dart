import 'package:flutter/cupertino.dart';

class HomeProvider with ChangeNotifier {
  bool _isMenuOpened = false;

  bool get isMenuOpened => _isMenuOpened;

  void toggleMenu(bool value) {
    _isMenuOpened = value;
    notifyListeners();
  }
}
