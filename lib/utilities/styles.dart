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
}
