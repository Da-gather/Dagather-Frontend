import 'dart:ui';

import 'package:dagather_frontend/utilities/colors.dart';
import 'package:dagather_frontend/utilities/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AccountAction extends StatelessWidget {
  final String text;
  String secondText;

  AccountAction({
    super.key,
    required this.text,
    this.secondText = "",
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: TextStyle(
                fontFamily: pretendardFont,
                fontSize: 14.sp,
                fontVariations: const [
                  FontVariation('wght', 700),
                ],
                color: AppColor.g700,
              ),
            ),
            if (secondText.isNotEmpty)
              Text(
                secondText,
                style: TextStyle(
                  fontFamily: pretendardFont,
                  fontSize: 14.sp,
                  fontVariations: const [
                    FontVariation('wght', 700),
                  ],
                  color: AppColor.g700,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
