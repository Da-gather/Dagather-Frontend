import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dagather_frontend/models/message_model.dart';
import 'package:dagather_frontend/screens/chat/components/message.dart';
import 'package:dagather_frontend/utilities/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:developer' as developer;

import '../components/chat_app_bar.dart';
import '../components/chat_bottom_bar.dart';

enum MessageType {
  text,
  image,
}

class ChatScreen extends StatelessWidget {
  final String docId;
  final String name;
  final String imgUrl;
  late final Query<MessageModel> _messagesRef;

  ChatScreen(
    String id, {
    super.key,
    required this.name,
    required this.imgUrl,
  })  : docId = id,
        _messagesRef = FirebaseFirestore.instance
            .collection('chats')
            .doc(id)
            .collection('messages')
            .orderBy("created")
            .withConverter<MessageModel>(
              fromFirestore: (snapshots, _) =>
                  MessageModel.fromJson(snapshots.data()!),
              toFirestore: (message, _) => message.toJson(),
            );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.g100,
      appBar: ChatAppBar(
        imgUrl: imgUrl,
        name: name,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: StreamBuilder(
                stream: _messagesRef.snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasError) {
                    developer.log(snapshot.error.toString());
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
                        final MessageModel message =
                            snapshot.data!.docs[index].data();
                        return Message(
                          content: message.content,
                          created: message.created,
                          isMine: message.sender ==
                              FirebaseAuth.instance.currentUser!.uid,
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: 20.h,
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ),
          ChatBottomBar(docId: docId),
        ],
      ),
    );
  }
}
