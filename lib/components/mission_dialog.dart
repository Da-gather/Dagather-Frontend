import 'dart:ui';

import 'package:blobs/blobs.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dagather_frontend/utilities/colors.dart';
import 'package:dagather_frontend/utilities/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MissionDialog extends StatelessWidget {
  const MissionDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.r)),
      ),
      contentPadding: const EdgeInsets.all(20).w,
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
                          imageUrl:
                              "https://images.unsplash.com/photo-1605434700731-331ca2458a77?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1365&q=80",
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
                        text: '2023년 11월 23',
                        style: TextStyle(
                          fontFamily: pretendardFont,
                          fontSize: 14.sp,
                          fontVariations: const [
                            FontVariation('wght', 700),
                          ],
                          color: AppColor.blue,
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
                  id: const ["7-4-1234"],
                  styles: BlobStyles(
                    color: AppColor.blue,
                    fillType: BlobFillType.fill,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          Container(
            decoration: BoxDecoration(
                color: AppColor.blueLight,
                borderRadius: BorderRadius.circular(10).r),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 14).h,
              child: Center(
                child: Text(
                  "함께 동네 맛집가서 맛있는 밥 먹기",
                  style: TextStyle(
                    fontFamily: pretendardFont,
                    fontSize: 13.sp,
                    fontVariations: const [
                      FontVariation('wght', 600),
                    ],
                    color: AppColor.blue,
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
