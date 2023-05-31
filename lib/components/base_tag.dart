import 'dart:ui';

import 'package:dagather_frontend/utilities/colors.dart';
import 'package:dagather_frontend/utilities/fonts.dart';
import 'package:dagather_frontend/utilities/variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BaseTag extends StatelessWidget {
  final TagType type;
  final String text;
  final bool changeColor;

  const BaseTag(
      {super.key,
      required this.text,
      required this.changeColor,
      required this.type});

  Color _getBackgroundColor() {
    if ((type == TagType.purpose) && (changeColor)) {
      return AppColor.green;
    }
    if ((type == TagType.interest) && (changeColor)) {
      return AppColor.blue;
    }
    if ((type == TagType.purpose) && (changeColor)) {
      return AppColor.green;
    }
    return AppColor.g200;
  }

  Color _getTextColor() {
    if ((type == TagType.purpose) && (changeColor)) {
      return AppColor.greenLight;
    }
    if ((type == TagType.interest) && (changeColor)) {
      return AppColor.blueLight;
    }
    return AppColor.g600;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _getBackgroundColor(),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: pretendardFont,
            fontSize: 13.sp,
            fontVariations: const [
              FontVariation('wght', 700),
            ],
            color: _getTextColor(),
          ),
        ),
      ),
    );
  }
}
