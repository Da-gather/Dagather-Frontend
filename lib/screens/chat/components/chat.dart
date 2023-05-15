import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dagather_frontend/utilities/colors.dart';
import 'package:dagather_frontend/utilities/fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../screens/chat_screen.dart';
import 'dart:developer' as developer;

class Chat extends StatelessWidget {
  final String id;
  final String name;
  final String imageUrl;
  final String lastMessage;
  final String lastSender;
  final Timestamp lastTime;
  final int notReadCount;

  const Chat({
    super.key,
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.lastMessage,
    required this.lastTime,
    required this.notReadCount,
    required this.lastSender,
  });

  String _formatTimeStamp(Timestamp timestamp) {
    final int createdInNum =
        (timestamp.seconds * 1000 + timestamp.nanoseconds / 1000000).round();
    final DateTime date =
        DateTime.fromMicrosecondsSinceEpoch(createdInNum * 1000);
    String dateString = DateFormat.jm().format(date);
    return dateString;
  }

  Widget _getReadWidget() {
    developer.log(lastSender);
    developer.log(FirebaseAuth.instance.currentUser!.uid);
    developer
        .log((lastSender == FirebaseAuth.instance.currentUser!.uid).toString());

    if (lastSender == FirebaseAuth.instance.currentUser!.uid) {
      return Text(
        "전송",
        style: TextStyle(
          fontFamily: pretendardFont,
          fontSize: 10.sp,
          fontVariations: const [
            FontVariation('wght', 700),
          ],
          color: AppColor.g300,
        ),
      );
    } else {
      if (notReadCount != 0) {
        return NotRead(notReadCount);
      } else {
        return Text(
          "읽음",
          style: TextStyle(
            fontFamily: pretendardFont,
            fontSize: 10.sp,
            fontVariations: const [
              FontVariation('wght', 700),
            ],
            color: AppColor.g400,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ChatScreen(
                    id,
                    name: name,
                    imgUrl: imageUrl,
                  ))),
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.g100,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
          ).r,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 18.w,
            horizontal: 16.w,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(right: 12.w),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: CachedNetworkImage(
                    width: 68.w,
                    height: 68.w,
                    fit: BoxFit.cover,
                    imageUrl: imageUrl,
                    placeholder: (context, url) => Container(
                      color: AppColor.g200,
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: 68.w,
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: 20.w,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              name,
                              style: TextStyle(
                                fontFamily: pretendardFont,
                                fontSize: 15.sp,
                                fontVariations: const [
                                  FontVariation('wght', 700),
                                ],
                                color: AppColor.g800,
                              ),
                            ),
                            SizedBox(
                              height: 4.h,
                            ),
                            Text(
                              lastMessage,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: pretendardFont,
                                fontSize: 14.sp,
                                fontVariations: const [
                                  FontVariation('wght', 600),
                                ],
                                color: AppColor.g700,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          _formatTimeStamp(lastTime),
                          style: TextStyle(
                            fontFamily: pretendardFont,
                            fontSize: 12.sp,
                            fontVariations: const [
                              FontVariation('wght', 400),
                            ],
                            color: AppColor.g400,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              _getReadWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class NotRead extends StatelessWidget {
  final int num;
  const NotRead(
    this.num, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 8.w,
          height: 8.w,
          decoration: const BoxDecoration(
            color: AppColor.red,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(
          width: 4.w,
        ),
        Text(
          num.toString(),
          style: TextStyle(
            fontFamily: pretendardFont,
            fontSize: 12.sp,
            fontVariations: const [
              FontVariation('wght', 700),
            ],
            color: AppColor.red,
          ),
        ),
      ],
    );
  }
}
