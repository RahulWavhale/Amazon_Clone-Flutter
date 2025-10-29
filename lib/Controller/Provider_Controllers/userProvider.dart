import 'package:flutter/material.dart';

import '../../Model/userModel.dart';

class UserProvider extends ChangeNotifier {
  User _user =
      User(id: '', name: '', email: '', password: '', address: '', type: '');

  User get user => _user;

  void setUser(String user) {
    _user = User.fromJson(user);

    notifyListeners();
  }
}
