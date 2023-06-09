import 'dart:ui';

import 'package:dagather_frontend/components/information_dialog.dart';
import 'package:dagather_frontend/utilities/colors.dart';
import 'package:dagather_frontend/utilities/fonts.dart';
import 'package:dagather_frontend/utilities/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class MissionStatistics extends StatelessWidget {
  final int totalCount;
  final int redCount;
  final int yellowCount;
  final int greenCount;
  final int blueCount;

  const MissionStatistics(
      {super.key,
      required this.totalCount,
      required this.redCount,
      required this.yellowCount,
      required this.greenCount,
      required this.blueCount});

  int _getLargest() {
    int largest = redCount;
    if (yellowCount > largest) largest = yellowCount;
    if (greenCount > largest) largest = greenCount;
    if (blueCount > largest) largest = blueCount;
    return largest;
  }

  @override
  Widget build(BuildContext context) {
    final maxCount = _getLargest();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "미션 전체 통게",
          style: FontStyle.captionTextStyle,
        ),
        totalCount == 0
            ? Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 32.h),
                  child: Text(
                    "완료한 미션이 아직 없습니다",
                    style: FontStyle.emptyNotificationTextStyle,
                  ),
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 8.h,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColor.g700,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 20.h,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "총 완료한 미션 개수",
                            style: TextStyle(
                              fontFamily: pretendardFont,
                              fontSize: 14.sp,
                              fontVariations: const [
                                FontVariation('wght', 600),
                              ],
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "$totalCount개",
                            style: TextStyle(
                              fontFamily: pretendardFont,
                              fontSize: 14.sp,
                              fontVariations: const [
                                FontVariation('wght', 700),
                              ],
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 32.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const InformationDialog(
                              title: "미션의 카테고리는 무엇이 있나요?",
                              content:
                                  '미션의 카테고리는 총 4개가 있으며, 색상으로 구분됩니다. 빨간색은 한국 문화 미션, 노란색은 한국어 학습 미션, 초록색은 일상 미션, 파란색은 취미 미션입니다.',
                            );
                          });
                    },
                    child: Row(
                      children: [
                        Text(
                          "완수한 미션의 카테고리별 비율",
                          style: FontStyle.captionTextStyle,
                        ),
                        SizedBox(
                          width: 4.w,
                        ),
                        SvgPicture.asset(
                          'assets/icons/ic_help_center.svg',
                          width: 16.w,
                        ),
                      ],
                    ),
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
                        horizontal: 20.w,
                        vertical: 24.h,
                      ),
                      child: Column(
                        children: [
                          StatisticBar(
                            color: AppColor.red,
                            count: redCount,
                            maxCount: maxCount,
                          ),
                          SizedBox(
                            height: 12.h,
                          ),
                          StatisticBar(
                            color: AppColor.yellow4,
                            count: yellowCount,
                            maxCount: maxCount,
                          ),
                          SizedBox(
                            height: 12.h,
                          ),
                          StatisticBar(
                            color: AppColor.green,
                            count: greenCount,
                            maxCount: maxCount,
                          ),
                          SizedBox(
                            height: 12.h,
                          ),
                          StatisticBar(
                            color: AppColor.blue,
                            count: blueCount,
                            maxCount: maxCount,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ],
    );
  }
}

class StatisticBar extends StatelessWidget {
  final int count;
  final int maxCount;
  final Color color;
  final num width = 300;

  const StatisticBar({
    super.key,
    required this.color,
    required this.count,
    required this.maxCount,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 16.h,
          width: width.w,
          decoration: BoxDecoration(
            color: AppColor.g200,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ).r,
          ),
        ),
        if (count != 0 && maxCount != 0)
          Container(
            height: 16.h,
            width: (count / maxCount) * width.w,
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ).r,
            ),
          ),
      ],
    );
  }
}
