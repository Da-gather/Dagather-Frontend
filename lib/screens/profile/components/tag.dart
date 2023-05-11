import 'dart:ui';

import 'package:dagather_frontend/utilities/colors.dart';
import 'package:dagather_frontend/utilities/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Tag extends StatelessWidget {
  const Tag({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.g200,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        child: Text(
          "책읽기",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: pretendardFont,
            fontSize: 13.sp,
            fontVariations: const [
              FontVariation('wght', 700),
            ],
            color: AppColor.g600,
          ),
        ),
      ),
    );
  }
}
