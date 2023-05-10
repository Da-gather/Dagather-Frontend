import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dagather_frontend/utilities/colors.dart';
import 'package:dagather_frontend/utilities/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../screens/chat_screen.dart';

class Chat extends StatelessWidget {
  final String name;
  final String imageUrl;
  final String lastMessage;
  final Timestamp lastTime;

  const Chat({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.lastMessage,
    required this.lastTime,
  });

  void _onTapped(context) {}

  String _formatTimeStamp(Timestamp timestamp) {
    final int createdInNum =
        (timestamp.seconds * 1000 + timestamp.nanoseconds / 1000000).round();
    final DateTime date =
        DateTime.fromMicrosecondsSinceEpoch(createdInNum * 1000);
    String dateString = DateFormat.jm().format(date);
    return dateString;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => ChatScreen())),
      child: Container(
        constraints: BoxConstraints(maxHeight: 102.h),
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 64.w,
                height: 64.w,
                margin: EdgeInsets.only(right: 12.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    alignment: FractionalOffset.center,
                    image: NetworkImage(imageUrl),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    right: 20.w,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Column(
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
                              fontSize: 13.sp,
                              fontVariations: const [
                                FontVariation('wght', 500),
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
                            FontVariation('wght', 300),
                          ],
                          color: AppColor.g400,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Text(
                "읽음",
                style: TextStyle(
                  fontFamily: pretendardFont,
                  fontSize: 10.sp,
                  fontVariations: const [
                    FontVariation('wght', 700),
                  ],
                  color: AppColor.g300,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
