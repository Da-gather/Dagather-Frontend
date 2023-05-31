import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dagather_frontend/utilities/colors.dart';
import 'package:dagather_frontend/utilities/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserMissionState extends StatelessWidget {
  final String imgUrl;
  final String name;
  final bool hasCompleted;

  const UserMissionState({
    super.key,
    required this.imgUrl,
    required this.name,
    required this.hasCompleted,
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
              ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: CachedNetworkImage(
                  width: 36.w,
                  height: 36.w,
                  fit: BoxFit.cover,
                  imageUrl: imgUrl,
                  placeholder: (context, url) => Container(
                    color: AppColor.g200,
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              SizedBox(
                width: 12.w,
              ),
              Text(
                name,
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
              color: hasCompleted ? AppColor.g700 : AppColor.green,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 10.w),
              child: Text(
                hasCompleted ? "완료" : "진행 중",
                style: TextStyle(
                  fontFamily: pretendardFont,
                  fontSize: 12.sp,
                  fontVariations: const [
                    FontVariation('wght', 700),
                  ],
                  color: AppColor.g100,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
