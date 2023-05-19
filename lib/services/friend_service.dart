import 'dart:convert';

import 'package:dagather_frontend/models/user_model.dart';
import 'package:dagather_frontend/services/api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;

class FriendService {
  static const String friend = "friend";
  static const String list = "list";

  static Future<List<UserModel>> getFriends() async {
    final url = Uri.parse('http://${API.baseUrl}${API.version}/$friend/$list');

    Map<String, String> headers = {
      'Authorization': FirebaseAuth.instance.currentUser!.uid,
    };

    List<UserModel> friendRequestInstances = [];

    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      final Map<String, dynamic> body =
          jsonDecode(utf8.decode(response.bodyBytes));
      if (body["data"] != null) {
        for (var friendRequest in body["data"]) {
          friendRequestInstances
              .add(UserModel.fromJsonForFriend(friendRequest));
        }
      }
      return friendRequestInstances;
    }

    throw Error();
  }

  static Future<List<UserModel>> getFriendRequestsBy(int type) async {
    final url =
        Uri.parse('http://${API.baseUrl}${API.version}/$friend/$list/$type');

    Map<String, String> headers = {
      'Authorization': FirebaseAuth.instance.currentUser!.uid,
    };

    List<UserModel> friendRequestInstances = [];

    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      final Map<String, dynamic> body =
          jsonDecode(utf8.decode(response.bodyBytes));
      developer.log(body["message"]);
      if (body["data"] != null) {
        for (var friendRequest in body["data"]) {
          friendRequestInstances
              .add(UserModel.fromJsonForFriend(friendRequest));
        }
      }
      return friendRequestInstances;
    }

    throw Error();
  }

  static Future<void> sendFriendRequestTo(id) async {
    final url = Uri.parse('http://${API.baseUrl}${API.version}/$friend');

    final data = {
      "sender": FirebaseAuth.instance.currentUser!.uid,
      "receiver": id,
    };

    await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode(data),
    );
  }

  static Future<void> cancelFriendRequest(id) async {
    final url = Uri.parse('http://${API.baseUrl}${API.version}/$friend/$id');

    await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode("data"),
    );
  }
}
