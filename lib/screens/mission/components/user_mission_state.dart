import 'dart:ui';

import 'package:dagather_frontend/utilities/colors.dart';
import 'package:dagather_frontend/utilities/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserMissionState extends StatelessWidget {
  const UserMissionState({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 36.w,
                height: 36.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  image: const DecorationImage(
                    fit: BoxFit.cover,
                    alignment: FractionalOffset.center,
                    image: NetworkImage(
                        "https://images.unsplash.com/photo-1605434700731-331ca2458a77?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1365&q=80"),
                  ),
                ),
              ),
              SizedBox(
                width: 12.w,
              ),
              Text(
                "Sarah Kim",
                style: TextStyle(
                  fontFamily: pretendardFont,
                  fontSize: 14.sp,
                  fontVariations: const [
                    FontVariation('wght', 500),
                  ],
                  color: AppColor.g800,
                ),
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              color: AppColor.green,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
              child: Text(
                "완료",
                style: TextStyle(
                  fontFamily: pretendardFont,
                  fontSize: 12.sp,
                  fontVariations: const [
                    FontVariation('wght', 700),
                  ],
                  color: AppColor.greenLight,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
