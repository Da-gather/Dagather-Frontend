import 'dart:ui';

import 'package:dagather_frontend/utilities/colors.dart';
import 'package:dagather_frontend/utilities/fonts.dart';
import 'package:flutter/material.dart';
import 'package:blobs/blobs.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Mission extends StatelessWidget {
  const Mission({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.yellow1,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        child: Row(
          children: [
            Blob.fromID(
              size: 28.w,
              id: const ["7-4-1233"],
              styles: BlobStyles(
                color: AppColor.yellow4,
                fillType: BlobFillType.fill,
              ),
            ),
            SizedBox(
              width: 8.w,
            ),
            Text(
              "동네 맛집 공유하기",
              style: TextStyle(
                fontFamily: pretendardFont,
                fontSize: 14.sp,
                fontVariations: const [
                  FontVariation('wght', 800),
                ],
                color: AppColor.yellow4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
