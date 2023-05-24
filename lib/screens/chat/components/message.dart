import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dagather_frontend/models/correct_spell_model.dart';
import 'package:dagather_frontend/screens/chat/screens/image_viewer_screen.dart';
import 'package:dagather_frontend/utilities/fonts.dart';
import 'package:dagather_frontend/utilities/styles.dart';
import 'package:dagather_frontend/utilities/variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../utilities/colors.dart';

class Message extends StatefulWidget {
  final String content;
  final Timestamp created;
  final bool isMine;
  final String type;
  final CorrectSpellModel? correctSpellModel;

  const Message({
    super.key,
    required this.content,
    required this.created,
    required this.isMine,
    required this.type,
    this.correctSpellModel,
  });

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  bool hasChecked = false;

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
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (widget.correctSpellModel != null)
              SizedBox(
                width: 28.w,
                height: 28.w,
                child: Center(
                  child: IconButton(
                      padding: const EdgeInsets.all(0),
                      onPressed: () async {
                        hasChecked = !hasChecked;
                        setState(() {});
                      },
                      icon: hasChecked
                          ? Icon(
                              Icons.cancel_rounded,
                              size: 20.w,
                              color: AppColor.g700,
                            )
                          : Icon(
                              Icons.spellcheck_rounded,
                              size: 20.w,
                              color: AppColor.green,
                            )),
                ),
              ),
            SizedBox(
              height: 4.h,
            ),
            Text(
              _formatTimeStamp(widget.created),
              style: FontStyle.timeTextStyle,
            ),
          ],
        ),
        SizedBox(
          width: 6.w,
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
          child: widget.type == MessageType.text.name
              ? Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 12.h,
                    horizontal: 20.w,
                  ),
                  child: Column(
                    children: [
                      Text(
                        widget.content,
                        style: FontStyle.messageTextStyle,
                      ),
                      if (widget.type == MessageType.text.name && hasChecked)
                        (widget.correctSpellModel!.errorCount == 0 ||
                                widget.correctSpellModel!.wordBags.isEmpty)
                            ? Container(
                                margin: EdgeInsets.only(top: 4.h),
                                padding: EdgeInsets.symmetric(
                                    vertical: 3.h, horizontal: 10.w),
                                decoration: BoxDecoration(
                                  color: AppColor.g100,
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                  ).r,
                                ),
                                child: Text('올바른 문장 입니다',
                                    style: TextStyle(
                                      fontFamily: pretendardFont,
                                      fontSize: 14.sp,
                                      height: 1.55,
                                      fontVariations: const [
                                        FontVariation('wght', 500),
                                      ],
                                      color: AppColor.green,
                                    )),
                              )
                            : Container(
                                margin: EdgeInsets.only(top: 4.h),
                                padding: EdgeInsets.symmetric(
                                    vertical: 3.h, horizontal: 10.w),
                                decoration: BoxDecoration(
                                  color: AppColor.g100,
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                  ).r,
                                ),
                                child: Text(
                                    widget.correctSpellModel!.correctText,
                                    style: FontStyle.wrongMessageTextStyle))
                    ],
                  ),
                )
              : Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 12.h,
                    horizontal: 12.w,
                  ),
                  child: ImageContent(content: widget.content),
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
          child: widget.type == MessageType.text.name
              ? Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 12.h,
                    horizontal: 20.w,
                  ),
                  child: Column(
                    children: [
                      Text(
                        widget.content,
                        style: FontStyle.messageTextStyle,
                      ),
                      if (widget.type == MessageType.text.name && hasChecked)
                        (widget.correctSpellModel!.errorCount == 0 ||
                                widget.correctSpellModel!.wordBags.isEmpty)
                            ? Container(
                                margin: EdgeInsets.only(top: 4.h),
                                padding: EdgeInsets.symmetric(
                                    vertical: 3.h, horizontal: 10.w),
                                decoration: BoxDecoration(
                                  color: AppColor.g100,
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                  ).r,
                                ),
                                child: Text('올바른 문장 입니다',
                                    style: TextStyle(
                                      fontFamily: pretendardFont,
                                      fontSize: 14.sp,
                                      height: 1.55,
                                      fontVariations: const [
                                        FontVariation('wght', 500),
                                      ],
                                      color: AppColor.green,
                                    )),
                              )
                            : Container(
                                margin: EdgeInsets.only(top: 4.h),
                                padding: EdgeInsets.symmetric(
                                    vertical: 3.h, horizontal: 10.w),
                                decoration: BoxDecoration(
                                  color: AppColor.g100,
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                  ).r,
                                ),
                                child: Text(
                                    widget.correctSpellModel!.correctText,
                                    style: FontStyle.wrongMessageTextStyle))
                    ],
                  ),
                )
              : Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 12.h,
                    horizontal: 12.w,
                  ),
                  child: ImageContent(content: widget.content),
                ),
        ),
        SizedBox(
          width: 6.w,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.correctSpellModel != null)
              SizedBox(
                width: 28.w,
                height: 28.w,
                child: Center(
                  child: IconButton(
                      padding: const EdgeInsets.all(0),
                      onPressed: () async {
                        hasChecked = !hasChecked;
                        setState(() {});
                      },
                      icon: hasChecked
                          ? Icon(
                              Icons.cancel_rounded,
                              size: 20.w,
                              color: AppColor.g700,
                            )
                          : Icon(
                              Icons.spellcheck_rounded,
                              size: 20.w,
                              color: AppColor.green,
                            )),
                ),
              ),
            SizedBox(
              height: 4.h,
            ),
            Text(
              _formatTimeStamp(widget.created),
              style: FontStyle.timeTextStyle,
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.isMine ? myMessage(context) : otherMessage(context);
  }
}

class ImageContent extends StatelessWidget {
  const ImageContent({
    super.key,
    required this.content,
  });

  final String content;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ImageViewerScreen(
            url: content,
          ),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.r),
        child: CachedNetworkImage(
          width: 160.w,
          height: 160.w,
          fit: BoxFit.cover,
          imageUrl: content,
          placeholder: (context, url) => Container(
            color: AppColor.g200,
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}
