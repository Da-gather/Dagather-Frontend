import 'dart:ui';

import 'package:dagather_frontend/utilities/colors.dart';
import 'package:dagather_frontend/utilities/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ActionDialog extends StatelessWidget {
  final String content;
  final String buttonText;
  final Color buttonColor;
  final void Function() onPressed;

  const ActionDialog(
      {super.key,
      required this.content,
      required this.buttonText,
      required this.buttonColor,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.r)),
      ),
      insetPadding: EdgeInsets.symmetric(horizontal: 50.w),
      contentPadding:
          EdgeInsets.only(right: 20.w, left: 20.w, top: 44.h, bottom: 36.h),
      content: Text(content),
      contentTextStyle: TextStyle(
        fontFamily: pretendardFont,
        fontSize: 15.sp,
        height: 1.55,
        fontVariations: const [
          FontVariation('wght', 700),
        ],
        color: AppColor.g900,
      ),
      actionsPadding: EdgeInsets.only(right: 12.w, left: 12.w, bottom: 12.h),
      actions: [
        Row(
          children: [
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: TextButton.styleFrom(
                  backgroundColor: AppColor.g200,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8).r,
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 14.h,
                  ),
                ),
                child: Text(
                  "취소",
                  style: TextStyle(
                    fontFamily: pretendardFont,
                    fontSize: 13.sp,
                    fontVariations: const [
                      FontVariation('wght', 700),
                    ],
                    color: AppColor.g700,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 8.w,
            ),
            Flexible(
              flex: 2,
              fit: FlexFit.tight,
              child: TextButton(
                onPressed: onPressed,
                style: TextButton.styleFrom(
                  backgroundColor: buttonColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8).r,
                  ),
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                ),
                child: Text(
                  buttonText,
                  style: TextStyle(
                    fontFamily: pretendardFont,
                    fontSize: 13.sp,
                    fontVariations: const [
                      FontVariation('wght', 700),
                    ],
                    color: AppColor.g900,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
