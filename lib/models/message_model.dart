import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String content;
  final String receiver;
  final String sender;
  final String type;
  final bool read;
  final Timestamp created;

  MessageModel.fromJson(Map<String, dynamic> json)
      : content = json["content"],
        receiver = json["receiver"],
        sender = json["sender"],
        type = json["type"],
        read = json["read"],
        created = json["created"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['content'] = content;
    data['receiver'] = receiver;
    data['sender'] = sender;
    data['type'] = type;
    data['read'] = read;
    data['created'] = created;
    return data;
  }
}
