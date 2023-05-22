import 'dart:ui';

import 'package:dagather_frontend/utilities/fonts.dart';
import 'package:flutter/material.dart';
import 'package:blobs/blobs.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Mission extends StatelessWidget {
  final num id;
  final String content;
  final Color color;
  final Color subColor;

  const Mission({
    super.key,
    required this.content,
    required this.color,
    required this.subColor,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: subColor,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        child: Row(
          children: [
            Blob.fromID(
              size: 28.w,
              id: ["7-4-$id"],
              styles: BlobStyles(
                color: color,
                fillType: BlobFillType.fill,
              ),
            ),
            SizedBox(
              width: 8.w,
            ),
            Text(
              content,
              style: TextStyle(
                fontFamily: pretendardFont,
                fontSize: 14.sp,
                fontVariations: const [
                  FontVariation('wght', 800),
                ],
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
