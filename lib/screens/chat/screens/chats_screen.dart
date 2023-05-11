import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dagather_frontend/components/app_bar.dart';
import 'package:dagather_frontend/models/chat_model.dart';
import 'package:dagather_frontend/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../components/chat.dart';

class ChatsScreen extends StatelessWidget {
  ChatsScreen({super.key});

  final _chatsRef = FirebaseFirestore.instance
      .collection('chats')
      .where("users", arrayContains: FirebaseAuth.instance.currentUser!.uid)
      .withConverter<ChatModel>(
        fromFirestore: (snapshots, _) => ChatModel.fromJson(snapshots.data()!),
        toFirestore: (chat, _) => chat.toJson(),
      );

  UserModel _getUser(ChatModel chatModel) {
    if (FirebaseAuth.instance.currentUser!.uid == chatModel.user1.uid) {
      return chatModel.user2;
    } else {
      return chatModel.user1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar("채팅"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 8.h,
              ),
              StreamBuilder(
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
                        final ChatModel chat =
                            snapshot.data!.docs[index].data();
                        return Chat(
                          id: snapshot.data!.docs[index].id,
                          name: _getUser(chat).name,
                          imageUrl: _getUser(chat).imgUrl,
                          lastMessage: chat.lastMessage,
                          lastTime: chat.lastTime,
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
            ],
          ),
        ),
      ),
    );
  }
}
