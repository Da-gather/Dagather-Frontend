import 'dart:ui';

import 'package:dagather_frontend/utilities/colors.dart';
import 'package:dagather_frontend/utilities/fonts.dart';
import 'package:dagather_frontend/utilities/variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserWidgetTag extends StatelessWidget {
  final String text;
  final bool changeColor;
  final String type;

  const UserWidgetTag({
    super.key,
    required this.text,
    required this.changeColor,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: type == TagType.purpose.name
            ? AppColor.greenLight
            : AppColor.blueLight,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: pretendardFont,
            fontSize: 12.sp,
            fontVariations: const [
              FontVariation('wght', 700),
            ],
            color:
                type == TagType.purpose.name ? AppColor.green : AppColor.blue,
          ),
        ),
      ),
    );
  }
}
