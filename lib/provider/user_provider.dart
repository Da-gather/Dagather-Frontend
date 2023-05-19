import 'package:dagather_frontend/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserProvider with ChangeNotifier {
  UserModel? _user;
  String? _uid;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserModel? get user => _user;
  String? get uid => _uid;

  void setUser(UserModel user) {
    _user = user;
    notifyListeners();
  }

  void setUserId(String uid) {
    _uid = uid;
  }
}
