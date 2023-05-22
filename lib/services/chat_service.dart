import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService {
  static Future<DocumentReference<Object?>> createChatRoomInFireStore(
      Map<String, dynamic> data) async {
    CollectionReference chats = FirebaseFirestore.instance.collection('chats');
    return chats.add(data);
  }

  static void deleteChatRoomInFireStore(String docId) async {
    await FirebaseFirestore.instance.collection("chats").doc(docId).delete();
  }
}
