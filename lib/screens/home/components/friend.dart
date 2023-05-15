import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dagather_frontend/screens/home/components/friend_tag.dart';
import 'package:dagather_frontend/utilities/colors.dart';
import 'package:dagather_frontend/utilities/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Friend extends StatelessWidget {
  final String imageUrl;
  const Friend({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350.w,
      decoration: BoxDecoration(
        color: AppColor.g100,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
        ).r,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: CachedNetworkImage(
                width: 68.w,
                fit: BoxFit.cover,
                imageUrl: imageUrl,
                placeholder: (context, url) => Container(
                  color: AppColor.g200,
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            SizedBox(
              width: 16.w,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Text(
                        "🇨🇳",
                        style: TextStyle(
                          fontFamily: pretendardFont,
                          fontSize: 12.sp,
                          fontVariations: const [
                            FontVariation('wght', 700),
                          ],
                          color: AppColor.g600,
                        ),
                      ),
                      SizedBox(
                        width: 12.w,
                      ),
                      Text(
                        "Sarah Joy",
                        style: TextStyle(
                          fontFamily: pretendardFont,
                          fontSize: 14.sp,
                          fontVariations: const [
                            FontVariation('wght', 700),
                          ],
                          color: AppColor.g800,
                        ),
                      ),
                      SizedBox(
                        width: 12.w,
                      ),
                      Text(
                        "22",
                        style: TextStyle(
                          fontFamily: pretendardFont,
                          fontSize: 14.sp,
                          fontVariations: const [
                            FontVariation('wght', 600),
                          ],
                          color: AppColor.g600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  Container(
                    color: Colors.transparent,
                    child: Wrap(
                      direction: Axis.horizontal,
                      alignment: WrapAlignment.start,
                      spacing: 4.w,
                      runSpacing: 4.h,
                      children: List.generate(
                          6,
                          (index) => const FriendTag(
                                text: "산책하기",
                              )),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
