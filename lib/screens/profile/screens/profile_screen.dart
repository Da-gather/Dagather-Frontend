import 'dart:ui';

import 'package:dagather_frontend/components/app_bar.dart';
import 'package:dagather_frontend/components/base_dialog.dart';
import 'package:dagather_frontend/components/base_medium_button.dart';
import 'package:dagather_frontend/screens/mission/components/missions_container.dart';
import 'package:dagather_frontend/utilities/colors.dart';
import 'package:dagather_frontend/utilities/fonts.dart';
import 'package:dagather_frontend/utilities/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../components/tag.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar("프로필"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 8.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 300.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      image: const DecorationImage(
                        fit: BoxFit.cover,
                        alignment: FractionalOffset.center,
                        image: NetworkImage(
                            "https://images.unsplash.com/photo-1605434700731-331ca2458a77?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1365&q=80"),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Ariana Grande",
                            style: TextStyle(
                              fontFamily: pretendardFont,
                              fontSize: 20.sp,
                              fontVariations: const [
                                FontVariation('wght', 700),
                              ],
                              color: AppColor.g800,
                            ),
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          Row(
                            children: [
                              Text(
                                "🇨🇳  중국",
                                style: TextStyle(
                                  fontFamily: pretendardFont,
                                  fontSize: 14.sp,
                                  fontVariations: const [
                                    FontVariation('wght', 700),
                                  ],
                                  color: AppColor.g600,
                                ),
                              ),
                              SizedBox(
                                width: 6.w,
                              ),
                              Text(
                                "22",
                                style: TextStyle(
                                  fontFamily: pretendardFont,
                                  fontSize: 16.sp,
                                  fontVariations: const [
                                    FontVariation('wght', 700),
                                  ],
                                  color: AppColor.g600,
                                ),
                              ),
                              SizedBox(
                                width: 6.w,
                              ),
                              Text(
                                "여자",
                                style: TextStyle(
                                  fontFamily: pretendardFont,
                                  fontSize: 16.sp,
                                  fontVariations: const [
                                    FontVariation('wght', 700),
                                  ],
                                  color: AppColor.g600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      BaseMidiumButton(
                        textColor: AppColor.g900,
                        backgroundColor: AppColor.yellow4,
                        text: "친구 신청",
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return BaseDialog(
                                  buttonText: '확인',
                                  content: '친구 신청이 완료되었습니다.',
                                  onPressed: () {},
                                );
                              });
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 32.h,
                  ),
                  Text(
                    "자기소개",
                    style: FontStyle.captionTextStyle,
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Text(
                    "안녕하세요! 저는 현재 강남구에 사는 홍길동입니다. 저는 대화가 잘 통하는 친구를 사귀고 싶어요. 같이 다양한 정보를 교류하며 나누고 싶습니다.",
                    style: TextStyle(
                      fontFamily: pretendardFont,
                      fontSize: 15.sp,
                      height: 1.55,
                      letterSpacing: -0.2,
                      fontVariations: const [
                        FontVariation('wght', 500),
                      ],
                      color: AppColor.g800,
                    ),
                  ),
                  SizedBox(
                    height: 32.h,
                  ),
                  Text(
                    "거주지",
                    style: FontStyle.captionTextStyle,
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Text(
                    "서울특별시",
                    style: TextStyle(
                      fontFamily: pretendardFont,
                      fontSize: 15.sp,
                      letterSpacing: -0.2,
                      fontVariations: const [
                        FontVariation('wght', 500),
                      ],
                      color: AppColor.g800,
                    ),
                  ),
                  SizedBox(
                    height: 32.h,
                  ),
                  Text(
                    "거주기간",
                    style: FontStyle.captionTextStyle,
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Text(
                    "3년 이내",
                    style: TextStyle(
                      fontFamily: pretendardFont,
                      fontSize: 15.sp,
                      letterSpacing: -0.2,
                      fontVariations: const [
                        FontVariation('wght', 500),
                      ],
                      color: AppColor.g800,
                    ),
                  ),
                  SizedBox(
                    height: 32.h,
                  ),
                  Text(
                    "가입 목적",
                    style: FontStyle.captionTextStyle,
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Wrap(
                    direction: Axis.horizontal,
                    alignment: WrapAlignment.start,
                    spacing: 4.w,
                    runSpacing: 4.h,
                    children: List.generate(3, (index) => const Tag()),
                  ),
                  SizedBox(
                    height: 32.h,
                  ),
                  Text(
                    "관심사",
                    style: FontStyle.captionTextStyle,
                  ),
                  SizedBox(
                    height: 8.h,
                  ),

                  Container(
                    decoration: BoxDecoration(
                      color: AppColor.redLight,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      child: Center(
                        child: Text(
                          "총 1개의 관심사가 겹치네요",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: pretendardFont,
                            fontSize: 13.sp,
                            fontVariations: const [
                              FontVariation('wght', 700),
                            ],
                            color: AppColor.red,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Wrap(
                      direction: Axis.horizontal,
                      alignment: WrapAlignment.start,
                      spacing: 4.w,
                      runSpacing: 4.h,
                      children: List.generate(8, (index) => const Tag())),
                  // WsmBoxWidget()
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 24.h),
              child: Divider(
                thickness: 8.h,
                color: AppColor.g100,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "미션 전체 통게",
                    style: FontStyle.captionTextStyle,
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColor.blue,
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
                            "30개",
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
                  Row(
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
                          Container(
                            height: 16.h,
                            decoration: BoxDecoration(
                              color: AppColor.red,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                              ).r,
                            ),
                          ),
                          SizedBox(
                            height: 12.h,
                          ),
                          Container(
                            height: 16.h,
                            decoration: BoxDecoration(
                              color: AppColor.yellow4,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                              ).r,
                            ),
                          ),
                          SizedBox(
                            height: 12.h,
                          ),
                          Container(
                            height: 16.h,
                            decoration: BoxDecoration(
                              color: AppColor.green,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                              ).r,
                            ),
                          ),
                          SizedBox(
                            height: 12.h,
                          ),
                          Container(
                            height: 16.h,
                            decoration: BoxDecoration(
                              color: AppColor.blue,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                              ).r,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 32.h,
                  ),
                  Row(
                    children: [
                      Text(
                        "최근에 달성한 미션 10개",
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
                  SizedBox(
                    height: 8.h,
                  ),
                  const MissionsContainer(),
                ],
              ),
            ),
            SizedBox(
              height: 36.h,
            ),
          ],
        ),
      ),
    );
  }
}
