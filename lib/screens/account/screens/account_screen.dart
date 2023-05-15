import 'dart:ui';

import 'package:dagather_frontend/components/action_dialog.dart';
import 'package:dagather_frontend/components/app_bar.dart';
import 'package:dagather_frontend/components/base_medium_button.dart';
import 'package:dagather_frontend/components/information_dialog.dart';
import 'package:dagather_frontend/components/mission.dart';
import 'package:dagather_frontend/screens/mission/components/missions_container.dart';
import 'package:dagather_frontend/screens/profile/screens/profile_edit_screen.dart';
import 'package:dagather_frontend/screens/profile/screens/profile_screen.dart';
import 'package:dagather_frontend/utilities/colors.dart';
import 'package:dagather_frontend/utilities/fonts.dart';
import 'package:dagather_frontend/utilities/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../components/account_action.dart';

class AccountScreen extends StatelessWidget {
  AccountScreen({super.key});

  final Uri _url = Uri.parse(
      'https://docs.google.com/forms/d/e/1FAIpQLSf-fWUDEmkrM0LlUxjnSciKaC0j9Ty7Pb4tt4SQp3kx9_zhYg/viewform');

  Future<void> _launchUrl() async {
    if (!await launchUrl(
      _url,
      mode: LaunchMode.inAppWebView,
    )) {
      throw Exception('Could not launch $_url');
    }
  }

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
                        child: BaseMidiumButton(
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
                        child: BaseMidiumButton(
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
                      GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const InformationDialog(
                                  title: "미션의 카테고리는 무엇이 있나요?",
                                  content:
                                      '미션의 카테고리는 총 4개가 있으며, 색상으로 구분됩니다. 빨간색은 000, 노란색은 000, 초록색은 000, 파란색은 000입니다.',
                                );
                              });
                        },
                        child: SvgPicture.asset(
                          'assets/icons/ic_help_center.svg',
                          width: 16.w,
                        ),
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
                      GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const InformationDialog(
                                  title: "최근에 달성한 미션 10개란?",
                                  content:
                                      '완료한 모든 미션 중 가장 최근에 달성한 미션 10개까지 볼 수 있습니다.',
                                );
                              });
                        },
                        child: SvgPicture.asset(
                          'assets/icons/ic_help_center.svg',
                          width: 16.w,
                        ),
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
                    secondText: FirebaseAuth.instance.currentUser!.email!,
                  ),
                  GestureDetector(
                    onTap: FirebaseAuth.instance.signOut,
                    child: AccountAction(
                      text: '로그아웃',
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return ActionDialog(
                              buttonColor: AppColor.red,
                              buttonText: '탈퇴하기',
                              content:
                                  'Da:gather를 정말 탈퇴하시겠습니까?\n탈퇴하면 모든 정보가 삭제되며 복구가 불가능합니다.',
                              onPressed: () {},
                            );
                          });
                    },
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
                    onTap: _launchUrl,
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
