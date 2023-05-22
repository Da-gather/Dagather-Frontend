import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dagather_frontend/screens/mission/screens/mission_screen.dart';
import 'package:dagather_frontend/utilities/colors.dart';
import 'package:dagather_frontend/utilities/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatAppBar extends StatelessWidget with PreferredSizeWidget {
  final String name;
  final String imgUrl;
  final String chatRoomId;
  final String friendId;

  const ChatAppBar({
    super.key,
    required this.name,
    required this.imgUrl,
    required this.chatRoomId,
    required this.friendId,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      flexibleSpace: _appBar(context),
      toolbarHeight: 56.h,
      iconTheme: const IconThemeData(
        color: AppColor.g800,
      ),
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      titleTextStyle: TextStyle(
        fontFamily: pretendardFont,
        fontSize: 15.sp,
        fontVariations: const [
          FontVariation('wght', 700),
        ],
        color: AppColor.g800,
      ),
    );
  }

  Widget _appBar(context) {
    return SafeArea(
      child: Padding(
        padding:
            EdgeInsets.only(right: 20.w, left: 64.w, top: 10.h, bottom: 10.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 8.w),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100.r),
                      child: CachedNetworkImage(
                        width: 32.w,
                        height: 32.w,
                        fit: BoxFit.cover,
                        imageUrl: imgUrl,
                        placeholder: (context, url) => Container(
                          color: AppColor.g200,
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ),
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
                ],
              ),
            ),
            TextButton(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MissionScreen(
                      chatroomId: chatRoomId,
                      friendId: friendId,
                    ),
                  )),
              style: TextButton.styleFrom(
                backgroundColor: AppColor.blueLight,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8).r,
                ),
              ),
              child: Text(
                "미션",
                style: TextStyle(
                  fontFamily: pretendardFont,
                  fontSize: 13.sp,
                  fontVariations: const [
                    FontVariation('wght', 700),
                  ],
                  color: AppColor.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56.h);
}
