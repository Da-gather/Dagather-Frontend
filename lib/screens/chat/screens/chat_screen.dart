import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dagather_frontend/models/message_model.dart';
import 'package:dagather_frontend/screens/chat/components/message.dart';
import 'package:dagather_frontend/utilities/colors.dart';
import 'package:dagather_frontend/utilities/fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'dart:developer' as developer;

import '../components/chat_app_bar.dart';
import '../components/chat_bottom_bar.dart';

class ChatScreen extends StatelessWidget {
  final String docId;
  final String name;
  final String imgUrl;
  final String uid;
  late final Query<MessageModel> _messagesRef;
  final ScrollController _scrollController = ScrollController();

  ChatScreen(
    String id, {
    super.key,
    required this.name,
    required this.imgUrl,
    required this.uid,
  })  : docId = id,
        _messagesRef = FirebaseFirestore.instance
            .collection('chats')
            .doc(id)
            .collection('messages')
            .orderBy("created", descending: true)
            .withConverter<MessageModel>(
              fromFirestore: (snapshots, _) =>
                  MessageModel.fromJson(snapshots.data()!),
              toFirestore: (message, _) => message.toJson(),
            );

  void _updateReadStatus(messageId) async {
    await FirebaseFirestore.instance
        .collection('chats')
        .doc(docId)
        .collection('messages')
        .doc(messageId)
        .update({"read": true});
  }

  void _resetNotReadMsgCount() async {
    final docRef = FirebaseFirestore.instance.collection('chats').doc(docId);
    docRef.get().then((value) {
      final data = value.data() as Map<String, dynamic>;
      if (data["last_sender"] != FirebaseAuth.instance.currentUser!.uid) {
        FirebaseFirestore.instance
            .collection('chats')
            .doc(docId)
            .update({"msg_not_read": 0});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.g100,
      appBar: ChatAppBar(
        imgUrl: imgUrl,
        name: name,
        chatRoomId: docId,
        friendId: uid,
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: _messagesRef.snapshots(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  case ConnectionState.none:
                    return const Center(
                      child: Text("none"),
                    );
                  case ConnectionState.active:
                  case ConnectionState.done:
                    if (snapshot.hasError) {
                      developer.log(snapshot.error.toString());
                      throw Error();
                    }
                    if (!snapshot.hasData) {
                      developer.log("no data");
                      return const Text("no data");
                    } else {
                      if (snapshot.data!.size == 0) {
                        developer.log("no data");
                        return const NoMessage();
                      } else {
                        _resetNotReadMsgCount();
                        return ListView.separated(
                          reverse: true,
                          controller: _scrollController,
                          physics: const ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data!.size,
                          itemBuilder: (context, index) {
                            final MessageModel message =
                                snapshot.data!.docs[index].data();

                            final Message messageWidget = Message(
                              content: message.content,
                              created: message.created,
                              type: message.type,
                              isMine: message.sender ==
                                  FirebaseAuth.instance.currentUser!.uid,
                              correctSpellModel: message.corrected,
                            );

                            if (message.sender !=
                                FirebaseAuth.instance.currentUser!.uid) {
                              _updateReadStatus(snapshot.data!.docs[index].id);
                            }

                            if (index == 0) {
                              return Padding(
                                padding: EdgeInsets.only(
                                    bottom: 16.h, right: 20.w, left: 20.w),
                                child: messageWidget,
                              );
                            } else if (snapshot.data!.size - 1 == index) {
                              return Padding(
                                padding: EdgeInsets.only(
                                    top: 16.h, right: 20.w, left: 20.w),
                                child: messageWidget,
                              );
                            }
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: messageWidget,
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              height: 20.h,
                            );
                          },
                        );
                      }
                    }
                }
              },
            ),
          ),
          ChatBottomBar(docId: docId),
        ],
      ),
    );
  }
}

class NoMessage extends StatelessWidget {
  const NoMessage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 40.w),
            margin: EdgeInsets.only(top: 16.h, right: 20.w, left: 20.w),
            decoration: BoxDecoration(
                color: AppColor.g200,
                borderRadius: BorderRadius.circular(10.r)),
            child: Text(
              "친구와 대화를 나누고\n미션을 확인하세요!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: pretendardFont,
                fontSize: 12.sp,
                height: 1.55,
                fontVariations: const [
                  FontVariation('wght', 700),
                ],
                color: AppColor.g600,
              ),
            )),
      ],
    );
  }
}
