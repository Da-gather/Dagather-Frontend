import 'dart:ui';

import 'package:dagather_frontend/components/app_bar.dart';
import 'package:dagather_frontend/utilities/colors.dart';
import 'package:dagather_frontend/utilities/fonts.dart';
import 'package:dagather_frontend/utilities/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MissionScreen extends StatelessWidget {
  const MissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar("미션"),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 24.h,
                ),
                Text(
                  "이번 미션",
                  style: FontStyle.captionTextStyle,
                ),
                SizedBox(
                  height: 8.h,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: AppColor.yellow1,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 14.h),
                        child: Row(
                          children: [
                            const Icon(Icons.abc),
                            SizedBox(
                              width: 8.w,
                            ),
                            Text(
                              "미션내용",
                              style: TextStyle(
                                fontFamily: pretendardFont,
                                fontSize: 13.sp,
                                fontVariations: const [
                                  FontVariation('wght', 700),
                                ],
                                color: AppColor.yellow4,
                              ),
                            ),
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text("건너뛰기"),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 36.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.h),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            const Icon(Icons.abc),
                            TextButton(
                              onPressed: () {},
                              child: const Text("미션 완수"),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            const Icon(Icons.abc),
                            TextButton(
                              onPressed: () {},
                              child: const Text("미션 완수"),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 36.h,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: AppColor.g200,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 24.h),
                    child: Center(
                      child: Text(
                        "미션 완수 안함",
                        style: TextStyle(
                          fontFamily: pretendardFont,
                          fontSize: 13.sp,
                          height: 1.5,
                          fontVariations: const [
                            FontVariation('wght', 700),
                          ],
                          color: AppColor.g400,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 24.h,
                ),
              ],
            ),
          ),
          Divider(
            thickness: 8.h,
            color: AppColor.g100,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 24.h,
                ),
                Text(
                  "이번 미션",
                  style: FontStyle.captionTextStyle,
                ),
                SizedBox(
                  height: 8.h,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: AppColor.g100,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 20.h,
                      horizontal: 20.w,
                    ),
                    child: const Center(
                      child: Text(
                        "미션 완수 안함",
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
