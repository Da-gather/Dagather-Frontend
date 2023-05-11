import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dagather_frontend/models/message_model.dart';
import 'package:dagather_frontend/utilities/colors.dart';
import 'package:dagather_frontend/utilities/fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatBottomBar extends StatefulWidget {
  final String docId;

  const ChatBottomBar({super.key, required this.docId});

  @override
  State<ChatBottomBar> createState() => _ChatBottomBarState();
}

class _ChatBottomBarState extends State<ChatBottomBar> {
  final TextEditingController _textController = TextEditingController();

  void sendMessage() async {
    final MessageModel data = MessageModel(
        content: _textController.text,
        sender: FirebaseAuth.instance.currentUser!.uid,
        type: "text",
        read: false,
        created: Timestamp.now());

    await FirebaseFirestore.instance
        .collection('chats')
        .doc(widget.docId)
        .collection('messages')
        .withConverter<MessageModel>(
          fromFirestore: (snapshots, _) =>
              MessageModel.fromJson(snapshots.data()!),
          toFirestore: (message, _) => message.toJson(),
        )
        .add(data);
    _textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
              onChanged: (value) {
                setState(() {});
              },
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
            disabledColor: AppColor.g300,
            onPressed: _textController.text.isNotEmpty ? sendMessage : null,
            color: AppColor.blue,
            icon: const Icon(Icons.send_rounded),
          ),
        ],
      ),
    );
  }
}
