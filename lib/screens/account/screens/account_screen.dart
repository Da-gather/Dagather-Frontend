import 'dart:ui';

import 'package:dagather_frontend/components/action_dialog.dart';
import 'package:dagather_frontend/components/app_bar.dart';
import 'package:dagather_frontend/components/base_medium_button.dart';
import 'package:dagather_frontend/components/mission.dart';
import 'package:dagather_frontend/screens/mission/components/mission_statistics.dart';
import 'package:dagather_frontend/screens/mission/components/missions_container.dart';
import 'package:dagather_frontend/screens/profile/screens/profile_edit_screen.dart';
import 'package:dagather_frontend/screens/profile/screens/profile_screen.dart';
import 'package:dagather_frontend/services/mission_service.dart';
import 'package:dagather_frontend/utilities/colors.dart';
import 'package:dagather_frontend/utilities/fonts.dart';
import 'package:dagather_frontend/utilities/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

  final Future<Map<String, dynamic>> _missionStatistics =
      MissionService.getMissionStatistics(
          FirebaseAuth.instance.currentUser!.uid);

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
                              builder: (context) => ProfileScreen(
                                uid: FirebaseAuth.instance.currentUser!.uid,
                              ),
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
                  FutureBuilder(
                      future: _missionStatistics,
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          case ConnectionState.none:
                            return const Center(
                              child: Text("none"),
                            );
                          case ConnectionState.active:
                          case ConnectionState.done:
                            if (snapshot.hasError) {
                              throw Error();
                            }
                            if (snapshot.hasData) {
                              final statistic = snapshot.data!;

                              return MissionStatistics(
                                  totalCount: statistic["total"],
                                  redCount: statistic["category0"],
                                  yellowCount: statistic["category1"],
                                  greenCount: statistic["category2"],
                                  blueCount: statistic["category3"]);
                            }
                            throw Error();
                        }
                      }),
                  SizedBox(
                    height: 32.h,
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
