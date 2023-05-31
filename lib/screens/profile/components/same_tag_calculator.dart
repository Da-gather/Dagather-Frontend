import 'dart:ui';

import 'package:dagather_frontend/utilities/colors.dart';
import 'package:dagather_frontend/utilities/fonts.dart';
import 'package:dagather_frontend/utilities/variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SameTagCalculator extends StatelessWidget {
  final TagType type;
  final int count;
  const SameTagCalculator({
    super.key,
    required this.type,
    required this.count,
  });

  String _getTypeText() {
    if (type == TagType.purpose) {
      return "가입 목적이";
    }
    if (type == TagType.interest) {
      return "관심사가";
    }
    throw Error();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.redLight,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: Center(
          child: Text(
            count == 0
                ? "겹치는 ${_getTypeText()} 없어도 좋은 친구가 될 수 있어요"
                : "총 $count개의 ${_getTypeText()} 겹치네요",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: pretendardFont,
              fontSize: 13.sp,
              fontVariations: const [
                FontVariation('wght', 700),
              ],
              color: AppColor.red,
            ),
          ),
        ),
      ),
    );
  }
}
