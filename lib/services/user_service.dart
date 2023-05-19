import 'dart:convert';

import 'package:dagather_frontend/models/user_model.dart';
import 'package:dagather_frontend/services/api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class UserService {
  static const String profile = "profile";
  static const String list = "list";
  static const String filter = 'filter';

  static Future<List<UserModel>> getUsers() async {
    final url = Uri.parse(
        'http://${API.baseUrl}${API.version}/$profile/$list?$filter=');

    Map<String, String> headers = {
      'Authorization': FirebaseAuth.instance.currentUser!.uid,
    };

    List<UserModel> userInstances = [];

    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      final Map<String, dynamic> body =
          jsonDecode(utf8.decode(response.bodyBytes));
      if (body["data"] != null) {
        for (var user in body["data"]) {
          userInstances.add(UserModel.fromJson(user));
        }
      }
      return userInstances;
    }

    throw Error();
  }

  static Future<UserModel> getUserById(profileId) async {
    final url =
        Uri.parse('http://${API.baseUrl}${API.version}/$profile/$profileId');

    Map<String, String> headers = {
      'Authorization': FirebaseAuth.instance.currentUser!.uid,
    };

    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      final Map<String, dynamic> body =
          jsonDecode(utf8.decode(response.bodyBytes));

      final userModel = UserModel.fromJson(body["data"]);
      return userModel;
    }
    throw Error();
  }
}
