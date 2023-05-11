import 'dart:ui';

import 'package:dagather_frontend/components/app_bar.dart';
import 'package:dagather_frontend/utilities/colors.dart';
import 'package:dagather_frontend/utilities/fonts.dart';
import 'package:dagather_frontend/utilities/styles.dart';
import 'package:flutter/material.dart';
import 'package:blobs/blobs.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../components/mission.dart';
import '../components/user_mission_state.dart';

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
                const Mission(),
                SizedBox(
                  height: 8.h,
                ),
                Row(
                  children: [
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          backgroundColor: AppColor.g200,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8).r,
                          ),
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                        ),
                        child: Text(
                          "건너뛰기",
                          style: TextStyle(
                            fontFamily: pretendardFont,
                            fontSize: 14.sp,
                            fontVariations: const [
                              FontVariation('wght', 600),
                            ],
                            color: AppColor.g400,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 4.w,
                    ),
                    Flexible(
                      flex: 3,
                      fit: FlexFit.tight,
                      child: TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          backgroundColor: AppColor.g800,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8).r,
                          ),
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                        ),
                        child: Text(
                          "미션 완료하기",
                          style: TextStyle(
                            fontFamily: pretendardFont,
                            fontSize: 14.sp,
                            fontVariations: const [
                              FontVariation('wght', 700),
                            ],
                            color: AppColor.g200,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 32.h,
                ),
                Text(
                  "이번 미션 완수 현황",
                  style: FontStyle.captionTextStyle,
                ),
                SizedBox(
                  height: 8.h,
                ),
                Column(
                  children: const [
                    UserMissionState(),
                    UserMissionState(),
                  ],
                ),
                SizedBox(
                  height: 8.h,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: AppColor.g200,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 32.w, vertical: 20.h),
                    child: Center(
                      child: Text(
                        "아직 윤지애님이 미션을 완수하지 않았습니다. 두 명 모두 미션을 완료하면 새로운 미션을 받을 수 있습니다.",
                        textAlign: TextAlign.center,
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
              ],
            ),
          ),
          SizedBox(
            height: 24.h,
          ),
          Divider(
            thickness: 8.h,
            color: AppColor.g100,
          ),
          SizedBox(
            height: 24.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "완료한 미션 모아보기",
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
                  child: GridView(
                    physics: const ClampingScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 20.h,
                    ),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                      crossAxisSpacing: 8.h,
                      mainAxisSpacing: 16.h,
                    ),
                    children: [
                      Blob.fromID(
                        size: 64.w,
                        id: const ["7-4-1234"],
                        styles: BlobStyles(
                          color: AppColor.green,
                          fillType: BlobFillType.fill,
                        ),
                      ),
                      Blob.fromID(
                        size: 64.w,
                        id: const ["7-4-1235"],
                        styles: BlobStyles(
                          color: AppColor.red,
                          fillType: BlobFillType.fill,
                        ),
                      ),
                      Blob.fromID(
                        size: 64.w,
                        id: const ["7-4-1236"],
                        styles: BlobStyles(
                          color: AppColor.yellow4,
                          fillType: BlobFillType.fill,
                        ),
                      ),
                      Blob.fromID(
                        size: 64.w,
                        id: const ["7-4-1237"],
                        styles: BlobStyles(
                          color: AppColor.red,
                          fillType: BlobFillType.fill,
                        ),
                      ),
                      Blob.fromID(
                        size: 64.w,
                        id: const ["7-4-1238"],
                        styles: BlobStyles(
                          color: AppColor.blue,
                          fillType: BlobFillType.fill,
                        ),
                      ),
                      Blob.fromID(
                        size: 64.w,
                        id: const ["7-4-1239"],
                        styles: BlobStyles(
                          color: AppColor.yellow4,
                          fillType: BlobFillType.fill,
                        ),
                      ),
                      Blob.fromID(
                        size: 64.w,
                        id: const ["7-4-1240"],
                        styles: BlobStyles(
                          color: AppColor.green,
                          fillType: BlobFillType.fill,
                        ),
                      ),
                    ],
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
