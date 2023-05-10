import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dagather_frontend/models/chat_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../components/chat.dart';
//import 'dart:developer' as developer;

class ChatsScreen extends StatelessWidget {
  ChatsScreen({super.key});

  final _chatsRef = FirebaseFirestore.instance
      .collection('chats')
      .where("users", arrayContains: FirebaseAuth.instance.currentUser!.uid)
      .withConverter<ChatModel>(
        fromFirestore: (snapshots, _) => ChatModel.fromJson(snapshots.data()!),
        toFirestore: (chat, _) => chat.toJson(),
      );

  String _getUserName(ChatModel chatModel) {
    if (FirebaseAuth.instance.currentUser!.uid == chatModel.user1.uid) {
      return chatModel.user2.name;
    } else {
      return chatModel.user1.name;
    }
  }

  String _getImageUrl(ChatModel chatModel) {
    if (FirebaseAuth.instance.currentUser!.uid == chatModel.user1.uid) {
      return chatModel.user2.imgUrl;
    } else {
      return chatModel.user1.imgUrl;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("채팅"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
          child: StreamBuilder(
            stream: _chatsRef.snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                throw Error();
              }
              if (!snapshot.hasData) {
                return const Text("no data");
              } else {
                return ListView.separated(
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snapshot.data!.size,
                  itemBuilder: (context, index) {
                    return Chat(
                      name: _getUserName(snapshot.data!.docs[index].data()),
                      imageUrl: _getImageUrl(snapshot.data!.docs[index].data()),
                      lastMessage:
                          snapshot.data!.docs[index].data().lastMessage,
                      lastTime: snapshot.data!.docs[index].data().lastTime,
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: 12.h,
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
