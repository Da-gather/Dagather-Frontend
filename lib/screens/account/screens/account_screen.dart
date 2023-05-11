import 'dart:ui';

import 'package:blobs/blobs.dart';
import 'package:dagather_frontend/components/app_bar.dart';
import 'package:dagather_frontend/components/base_small_button.dart';
import 'package:dagather_frontend/components/mission.dart';
import 'package:dagather_frontend/screens/profile/screens/profile_edit_screen.dart';
import 'package:dagather_frontend/screens/profile/screens/profile_screen.dart';
import 'package:dagather_frontend/utilities/colors.dart';
import 'package:dagather_frontend/utilities/fonts.dart';
import 'package:dagather_frontend/utilities/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../components/account_action.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar("계정 관리"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 8.h,
                  ),
                  SizedBox(
                    height: 52.h,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          width: 52.h,
                          height: 52.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            image: const DecorationImage(
                              fit: BoxFit.cover,
                              alignment: FractionalOffset.center,
                              image: NetworkImage(
                                  "https://images.unsplash.com/photo-1605434700731-331ca2458a77?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1365&q=80"),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 12.w,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "홍길동",
                              style: TextStyle(
                                fontFamily: pretendardFont,
                                fontSize: 16.sp,
                                fontVariations: const [
                                  FontVariation('wght', 700),
                                ],
                                color: AppColor.g800,
                              ),
                            ),
                            SizedBox(
                              height: 4.h,
                            ),
                            Row(
                              children: [
                                Text(
                                  "🇨🇳 중국",
                                  style: TextStyle(
                                    fontFamily: pretendardFont,
                                    fontSize: 14.sp,
                                    fontVariations: const [
                                      FontVariation('wght', 600),
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
                                    fontSize: 14.sp,
                                    fontVariations: const [
                                      FontVariation('wght', 600),
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
                                    fontSize: 14.sp,
                                    fontVariations: const [
                                      FontVariation('wght', 600),
                                    ],
                                    color: AppColor.g600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: BaseSmallButton(
                          textColor: AppColor.g400,
                          backgroundColor: AppColor.g200,
                          text: "프로필 수정",
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ProfileEditScreen(),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      Expanded(
                        child: BaseSmallButton(
                          textColor: AppColor.g300,
                          backgroundColor: AppColor.g600,
                          text: "내 프로필 확인하기",
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ProfileScreen(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
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
                    "진행 중인 미션 모두 보기",
                    style: FontStyle.captionTextStyle,
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  const Mission(),
                  SizedBox(
                    height: 12.h,
                  ),
                  const Mission(),
                  SizedBox(
                    height: 12.h,
                  ),
                  const Mission(),
                  SizedBox(
                    height: 32.h,
                  ),
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
                    "계정",
                    style: FontStyle.captionTextStyle,
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  AccountAction(
                    text: '이메일',
                    secondText: 'ajfl@gmail.com',
                  ),
                  GestureDetector(
                    onTap: FirebaseAuth.instance.signOut,
                    child: AccountAction(
                      text: '로그아웃',
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: AccountAction(
                      text: '회원탈퇴',
                    ),
                  ),
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
                    "기타",
                    style: FontStyle.captionTextStyle,
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  AccountAction(
                    text: '앱 버전',
                    secondText: 'v1.0',
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: AccountAction(
                      text: '신고하기',
                    ),
                  ),
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
