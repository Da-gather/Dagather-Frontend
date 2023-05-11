import 'dart:ui';

import 'package:dagather_frontend/screens/mission/screens/mission_screen.dart';
import 'package:dagather_frontend/utilities/colors.dart';
import 'package:dagather_frontend/utilities/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatAppBar extends StatelessWidget with PreferredSizeWidget {
  final String name;
  final String imgUrl;

  const ChatAppBar({
    super.key,
    required this.name,
    required this.imgUrl,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      flexibleSpace: _appBar(),
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
      actions: [
        IconButton(
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MissionScreen(),
              )),
          icon: Icon(
            Icons.more_vert_rounded,
            size: 24.w,
            color: AppColor.g600,
          ),
        ),
      ],
    );
  }

  Widget _appBar() {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(left: 64.w, top: 14.h, bottom: 14.h),
        child: Row(
          children: [
            CircleAvatar(
              radius: 16.w,
              backgroundImage: NetworkImage(imgUrl),
            ),
            SizedBox(
              width: 8.w,
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
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56.h);
}
