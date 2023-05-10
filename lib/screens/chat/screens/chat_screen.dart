import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dagather_frontend/models/message_model.dart';
import 'package:dagather_frontend/screens/chat/components/message.dart';
import 'package:dagather_frontend/utilities/colors.dart';
import 'package:dagather_frontend/utilities/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum MessageQuery {
  id,
  content,
  receiver,
  sender,
  created,
  type,
  read,
}

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});

  final TextEditingController _textController = TextEditingController();

  final _uid = "0yUlf0Iub9R4fM4V8f1FcyQQBfo2";

  final _messagesRef = FirebaseFirestore.instance
      .collection('messages')
      .withConverter<MessageModel>(
        fromFirestore: (snapshots, _) =>
            MessageModel.fromJson(snapshots.data()!),
        toFirestore: (message, _) => message.toJson(),
      )
      .where("receiver",
          whereIn: ["1", "0yUlf0Iub9R4fM4V8f1FcyQQBfo2"]).orderBy("created");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.g100,
      appBar: AppBar(title: const Text("채팅 디테일")),
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
                        return Message(
                          content: snapshot.data!.docs[index].data().content,
                          created: snapshot.data!.docs[index].data().created,
                          isMine:
                              snapshot.data!.docs[index].data().sender == _uid,
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
          Container(
            height: 60.h,
            decoration: const BoxDecoration(
              color: AppColor.g200,
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  color: AppColor.g500,
                  icon: const Icon(Icons.add_a_photo_rounded),
                ),
                Flexible(
                  child: TextField(
                    onChanged: (value) {},
                    controller: _textController,
                    style: TextStyle(
                      fontFamily: pretendardFont,
                      fontSize: 14.sp,
                      fontVariations: const [
                        FontVariation('wght', 400),
                      ],
                      color: AppColor.g900,
                    ),
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '메세지 보내기',
                      hintStyle: TextStyle(
                        fontFamily: pretendardFont,
                        fontSize: 14.sp,
                        fontVariations: const [
                          FontVariation('wght', 300),
                        ],
                        color: AppColor.g500,
                      ),
                      contentPadding: const EdgeInsets.all(18).w,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  color: AppColor.blue,
                  icon: const Icon(Icons.translate_rounded),
                ),
                IconButton(
                  onPressed: () {},
                  color: AppColor.blue,
                  icon: const Icon(Icons.send_rounded),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
