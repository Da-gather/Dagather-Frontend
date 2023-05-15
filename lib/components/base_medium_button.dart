import 'dart:ui';

import 'package:dagather_frontend/utilities/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BaseMidiumButton extends StatelessWidget {
  final Color textColor;
  final Color backgroundColor;
  final String text;
  final void Function() onPressed;

  const BaseMidiumButton(
      {super.key,
      required this.textColor,
      required this.backgroundColor,
      required this.text,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8).r,
        ),
        padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: pretendardFont,
          fontSize: 14.sp,
          fontVariations: const [
            FontVariation('wght', 700),
          ],
          color: textColor,
        ),
      ),
    );
  }
}
