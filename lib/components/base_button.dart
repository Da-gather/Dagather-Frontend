import 'dart:ui';

import 'package:dagather_frontend/utilities/colors.dart';
import 'package:dagather_frontend/utilities/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BaseButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  final bool isDisable;

  const BaseButton(
      {super.key,
      required this.text,
      required this.onPressed,
      this.isDisable = true});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: !isDisable ? onPressed : null,
      style: TextButton.styleFrom(
        minimumSize: Size(350.w, 55.h),
        backgroundColor: AppColor.yellow4,
        disabledBackgroundColor: AppColor.g200,
        foregroundColor: AppColor.g900,
        disabledForegroundColor: AppColor.g300,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8).r,
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: pretendardFont,
          fontSize: 15.sp,
          fontVariations: const [
            FontVariation('wght', 700),
          ],
        ),
      ),
    );
  }
}
