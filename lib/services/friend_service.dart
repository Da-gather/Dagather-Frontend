import 'dart:convert';

import 'package:dagather_frontend/models/friend_model.dart';
import 'package:dagather_frontend/services/api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;

class FriendService {
  static const String friend = "friend";
  static const String list = "list";
  static const String chatroom = "chatroom";

  static Future<List<FriendModel>> getFriends() async {
    final url = Uri.parse('http://${API.baseUrl}${API.version}/$friend/$list');

    Map<String, String> headers = {
      'Authorization': FirebaseAuth.instance.currentUser!.uid,
    };

    List<FriendModel> friendRequestInstances = [];

    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      final Map<String, dynamic> body =
          jsonDecode(utf8.decode(response.bodyBytes));
      if (body["data"] != null) {
        for (var friendRequest in body["data"]) {
          friendRequestInstances
              .add(FriendModel.fromJsonForFriendWidget(friendRequest));
        }
      }
      return friendRequestInstances;
    }

    throw Error();
  }

  static Future<List<FriendModel>> getFriendRequestsBy(int type) async {
    final url =
        Uri.parse('http://${API.baseUrl}${API.version}/$friend/$list/$type');

    Map<String, String> headers = {
      'Authorization': FirebaseAuth.instance.currentUser!.uid,
    };

    List<FriendModel> friendRequestInstances = [];

    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      final Map<String, dynamic> body =
          jsonDecode(utf8.decode(response.bodyBytes));
      developer.log(body["message"]);
      if (body["data"] != null) {
        for (var friendRequest in body["data"]) {
          friendRequestInstances
              .add(FriendModel.fromJsonForFriendWidget(friendRequest));
        }
      }
      return friendRequestInstances;
    }

    throw Error();
  }

  static Future<void> sendFriendRequestTo(id) async {
    final url = Uri.parse('http://${API.baseUrl}${API.version}/$friend');
    Map<String, String> headers = {
      'Authorization': FirebaseAuth.instance.currentUser!.uid,
      'Content-Type': 'application/json',
    };

    final data = {"receiver": id};

    final response = await http.post(
      url,
      headers: headers,
      body: json.encode(data),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> body =
          jsonDecode(utf8.decode(response.bodyBytes));
      developer.log(body["message"]);
      return;
    }

    throw Error();
  }

  static Future<void> createChatroom(int friendId, String chatroomId) async {
    final url =
        Uri.parse('http://${API.baseUrl}${API.version}/$friend/$chatroom');

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    final data = {
      "friendId": friendId,
      "chatroomId": chatroomId,
    };

    final response = await http.patch(
      url,
      headers: headers,
      body: json.encode(data),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> body =
          jsonDecode(utf8.decode(response.bodyBytes));
      developer.log(body["message"]);
      return;
    }

    throw Error();
  }

  static Future<FriendModel> acceptFriend(int friendId) async {
    final url =
        Uri.parse('http://${API.baseUrl}${API.version}/$friend/$friendId');

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    final response = await http.patch(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> body =
          jsonDecode(utf8.decode(response.bodyBytes));
      developer.log(body["message"]);
      return FriendModel.fromJson(body["data"]);
    }
    throw Error();
  }

  static Future<void> deleteFriend(int friendId) async {
    final url =
        Uri.parse('http://${API.baseUrl}${API.version}/$friend/$friendId');

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    final response = await http.delete(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> body =
          jsonDecode(utf8.decode(response.bodyBytes));
      developer.log(body["message"]);
      return;
    }

    throw Error();
  }
}
