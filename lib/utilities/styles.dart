import 'dart:ui';

import 'package:dagather_frontend/utilities/colors.dart';
import 'package:dagather_frontend/utilities/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FontStyle {
  static var captionTextStyle = TextStyle(
    fontFamily: pretendardFont,
    fontSize: 12.sp,
    fontVariations: const [
      FontVariation('wght', 700),
    ],
    color: AppColor.g400,
  );

  static var stepTextStyle = TextStyle(
    fontFamily: pretendardFont,
    fontSize: 13.sp,
    fontVariations: const [
      FontVariation('wght', 700),
    ],
    color: AppColor.g500,
  );

  static var titleTextStyle = TextStyle(
    fontFamily: pretendardFont,
    fontSize: 24.sp,
    height: 1.45,
    fontVariations: const [
      FontVariation('wght', 700),
    ],
    color: AppColor.g800,
  );

  static var inputTextStyle = TextStyle(
    fontFamily: pretendardFont,
    fontSize: 15.sp,
    fontVariations: const [
      FontVariation('wght', 600),
    ],
    color: AppColor.g700,
  );

  static var hintTextStyle = TextStyle(
    fontFamily: pretendardFont,
    fontSize: 15.sp,
    fontVariations: const [
      FontVariation('wght', 600),
    ],
    color: AppColor.g400,
  );

  static var timeTextStyle = TextStyle(
    fontFamily: pretendardFont,
    fontSize: 12.sp,
    fontVariations: const [
      FontVariation('wght', 400),
    ],
    color: AppColor.g400,
  );

  static var messageTextStyle = TextStyle(
    fontFamily: pretendardFont,
    fontSize: 14.sp,
    height: 1.55,
    fontVariations: const [
      FontVariation('wght', 500),
    ],
    color: AppColor.g800,
  );

  static var friendRequestTextStyle = TextStyle(
    fontFamily: pretendardFont,
    fontSize: 15.sp,
    fontVariations: const [
      FontVariation('wght', 700),
    ],
    color: AppColor.g800,
  );

  static var emptyNotificationTextStyle = TextStyle(
    fontFamily: pretendardFont,
    fontSize: 16.sp,
    height: 1.55,
    fontVariations: const [
      FontVariation('wght', 600),
    ],
    color: AppColor.g600,
  );
}
