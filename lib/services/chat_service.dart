import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dagather_frontend/models/correct_spell_model.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class ChatService {
  static Future<DocumentReference<Object?>> createChatRoomInFireStore(
      Map<String, dynamic> data) async {
    CollectionReference chats = FirebaseFirestore.instance.collection('chats');
    return chats.add(data);
  }

  static void deleteChatRoomInFireStore(String docId) async {
    await FirebaseFirestore.instance.collection("chats").doc(docId).delete();
  }

  static Future<CorrectSpellModel> checSpellingOfkMessage(String text) async {
    final url = Uri.parse('http://43.201.121.220:8000/api/v1/chat/correct');

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    final data = {
      "chat": text,
    };

    final response = await http.post(
      url,
      headers: headers,
      body: json.encode(data),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> body =
          jsonDecode(utf8.decode(response.bodyBytes));
      final CorrectSpellModel correctSpellModel =
          CorrectSpellModel.fromArray(body['data']);
      return correctSpellModel;
    }

    throw Error();
  }
}
