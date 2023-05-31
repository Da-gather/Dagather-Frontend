import 'dart:ui';

import 'package:blobs/blobs.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dagather_frontend/utilities/colors.dart';
import 'package:dagather_frontend/utilities/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class MissionDialog extends StatelessWidget {
  final num id;
  final String imgUrl;
  final String date;
  final String content;
  final Color color;
  final Color subColor;

  const MissionDialog({
    super.key,
    required this.id,
    required this.imgUrl,
    required this.date,
    required this.content,
    required this.color,
    required this.subColor,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.r)),
      ),
      contentPadding: const EdgeInsets.all(24).w,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4.r),
                        child: CachedNetworkImage(
                          width: 24.w,
                          height: 24.w,
                          fit: BoxFit.cover,
                          imageUrl: imgUrl,
                          placeholder: (context, url) => Container(
                            color: AppColor.g200,
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                      Text(
                        "와 함께",
                        style: TextStyle(
                          fontFamily: pretendardFont,
                          fontSize: 14.sp,
                          fontVariations: const [
                            FontVariation('wght', 600),
                          ],
                          color: AppColor.g700,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  RichText(
                      text: TextSpan(
                    children: [
                      TextSpan(
                        text: DateFormat('yyyy.MM.dd')
                            .format(DateTime.parse(date)),
                        style: TextStyle(
                          fontFamily: pretendardFont,
                          fontSize: 14.sp,
                          fontVariations: const [
                            FontVariation('wght', 700),
                          ],
                          color: color,
                        ),
                      ),
                      TextSpan(
                        text: "에 미션 달성!",
                        style: TextStyle(
                          fontFamily: pretendardFont,
                          fontSize: 14.sp,
                          fontVariations: const [
                            FontVariation('wght', 600),
                          ],
                          color: AppColor.g700,
                        ),
                      ),
                    ],
                  )),
                ],
              ),
              SizedBox(
                width: 40.w,
                height: 40.w,
                child: Blob.fromID(
                  size: 40.w,
                  id: ["7-4-$id"],
                  styles: BlobStyles(
                    color: color,
                    fillType: BlobFillType.fill,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 24.h,
          ),
          Container(
            decoration: BoxDecoration(
                color: subColor, borderRadius: BorderRadius.circular(10).r),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 10.w),
              child: Center(
                child: Text(
                  content,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: pretendardFont,
                    fontSize: 14.sp,
                    fontVariations: const [
                      FontVariation('wght', 700),
                    ],
                    color: color,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
