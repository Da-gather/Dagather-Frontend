import 'dart:ui';

import 'package:dagather_frontend/utilities/colors.dart';
import 'package:dagather_frontend/utilities/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InformationDialog extends StatelessWidget {
  final String title;
  final String content;

  const InformationDialog({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.r)),
      ),
      insetPadding: EdgeInsets.symmetric(horizontal: 50.w),
      title: Text(title),
      titleTextStyle: TextStyle(
        fontFamily: pretendardFont,
        fontSize: 15.sp,
        height: 1.55,
        fontVariations: const [
          FontVariation('wght', 800),
        ],
        color: AppColor.g800,
      ),
      titlePadding: EdgeInsets.only(right: 28.w, left: 28.w, top: 28.h),
      contentPadding:
          EdgeInsets.only(right: 28.w, left: 28.w, top: 4.h, bottom: 28.h),
      content: Text(
        content,
      ),
      contentTextStyle: TextStyle(
        fontFamily: pretendardFont,
        fontSize: 15.sp,
        height: 1.55,
        fontVariations: const [
          FontVariation('wght', 500),
        ],
        color: AppColor.g700,
      ),
    );
  }
}
