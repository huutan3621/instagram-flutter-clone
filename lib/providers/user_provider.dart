import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/models/user_model.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  User get getUser => _user!;

  Future<void> refreshUser() async {}
}
