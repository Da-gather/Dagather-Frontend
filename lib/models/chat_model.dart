import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dagather_frontend/models/user_model.dart';

class ChatModel {
  final UserModel user1, user2;
  final String lastMessage;
  final String lastSender;
  final Timestamp lastTime;
  final int msgNotRead;

  ChatModel.fromJson(Map<String, dynamic> json)
      : lastMessage = json["last_msg"],
        lastSender = json["last_sender"],
        lastTime = json["last_time"],
        msgNotRead = json["msg_not_read"],
        user1 = UserModel.fromJson(json["user_1"]),
        user2 = UserModel.fromJson(json["user_2"]);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['last_msg'] = lastMessage;
    data['last_sender'] = lastSender;
    data['last_time'] = lastTime;
    data['msg_not_read'] = msgNotRead;
    data['user_1'] = user1.toJson();
    data['user_2'] = user2.toJson();
    return data;
  }
}
