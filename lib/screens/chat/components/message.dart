import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dagather_frontend/utilities/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../utilities/colors.dart';

class Message extends StatelessWidget {
  final String content;
  final Timestamp created;
  final bool isMine;

  const Message({
    super.key,
    required this.content,
    required this.created,
    required this.isMine,
  });

  String _formatTimeStamp(Timestamp timestamp) {
    final int createdInNum =
        (timestamp.seconds * 1000 + timestamp.nanoseconds / 1000000).round();
    final DateTime date =
        DateTime.fromMicrosecondsSinceEpoch(createdInNum * 1000);
    String dateString = DateFormat.jm().format(date);
    return dateString;
  }

  Widget myMessage(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          margin: EdgeInsets.only(right: 6.w),
          child: Text(
            _formatTimeStamp(created),
            style: FontStyle.timeTextStyle,
          ),
        ),
        Container(
          constraints: BoxConstraints(maxWidth: 270.w),
          decoration: BoxDecoration(
            color: AppColor.g200,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            ).r,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 12.h,
              horizontal: 20.w,
            ),
            child: Text(
              content,
              style: FontStyle.messageTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget otherMessage(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          constraints: BoxConstraints(maxWidth: 270.w),
          decoration: BoxDecoration(
            color: AppColor.g300,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ).r,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 12.h,
              horizontal: 20.w,
            ),
            child: Text(
              content,
              style: FontStyle.messageTextStyle,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 6.w),
          child: Text(
            _formatTimeStamp(created),
            style: FontStyle.timeTextStyle,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return isMine ? myMessage(context) : otherMessage(context);
  }
}
