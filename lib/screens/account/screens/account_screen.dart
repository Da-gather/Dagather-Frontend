import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dagather_frontend/components/action_dialog.dart';
import 'package:dagather_frontend/components/app_bar.dart';
import 'package:dagather_frontend/components/base_medium_button.dart';
import 'package:dagather_frontend/components/mission.dart';
import 'package:dagather_frontend/models/mission_model.dart';
import 'package:dagather_frontend/models/user_model.dart';
import 'package:dagather_frontend/screens/mission/components/mission_statistics.dart';
import 'package:dagather_frontend/screens/mission/components/missions_container.dart';
import 'package:dagather_frontend/screens/profile/screens/profile_edit_screen.dart';
import 'package:dagather_frontend/screens/profile/screens/profile_screen.dart';
import 'package:dagather_frontend/services/mission_service.dart';
import 'package:dagather_frontend/services/user_service.dart';
import 'package:dagather_frontend/utilities/colors.dart';
import 'package:dagather_frontend/utilities/fonts.dart';
import 'package:dagather_frontend/utilities/functions.dart';
import 'package:dagather_frontend/utilities/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:url_launcher/url_launcher.dart';

import '../components/account_action.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
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

  Future<UserModel> _user =
      UserService.getUserById(FirebaseAuth.instance.currentUser!.uid);

  Future<Map<String, dynamic>> _missionStatistics =
      MissionService.getMissionStatistics(
          FirebaseAuth.instance.currentUser!.uid);

  Future<List<MissionModel>> _missionRecent =
      MissionService.getRecentMission(FirebaseAuth.instance.currentUser!.uid);

  Future<List<MissionModel>> _missionOngoings =
      MissionService.getOngoingMissions(FirebaseAuth.instance.currentUser!.uid);

  @override
  void initState() {
    super.initState();
    _user = UserService.getUserById(FirebaseAuth.instance.currentUser!.uid);
    _missionStatistics = MissionService.getMissionStatistics(
        FirebaseAuth.instance.currentUser!.uid);
    _missionRecent =
        MissionService.getRecentMission(FirebaseAuth.instance.currentUser!.uid);
    _missionOngoings = MissionService.getOngoingMissions(
        FirebaseAuth.instance.currentUser!.uid);
    setState(() {});
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
                  FutureBuilder(
                      future: _user,
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
                              final user = snapshot.data!;

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  SizedBox(
                                    height: 52.h,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                          child: CachedNetworkImage(
                                            width: 52.h,
                                            height: 52.h,
                                            fit: BoxFit.cover,
                                            imageUrl: user.imgUrl!,
                                            placeholder: (context, url) =>
                                                Container(
                                              color: AppColor.g200,
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 12.w,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              user.name!,
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
                                                  getRegionText(user.region!),
                                                  style: TextStyle(
                                                    fontFamily: pretendardFont,
                                                    fontSize: 14.sp,
                                                    fontVariations: const [
                                                      FontVariation(
                                                          'wght', 600),
                                                    ],
                                                    color: AppColor.g600,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 6.w,
                                                ),
                                                Text(
                                                  getAgeFromDateTime(
                                                          user.birth!)
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontFamily: pretendardFont,
                                                    fontSize: 14.sp,
                                                    fontVariations: const [
                                                      FontVariation(
                                                          'wght', 600),
                                                    ],
                                                    color: AppColor.g600,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 6.w,
                                                ),
                                                Text(
                                                  getGender(user.gender),
                                                  style: TextStyle(
                                                    fontFamily: pretendardFont,
                                                    fontSize: 14.sp,
                                                    fontVariations: const [
                                                      FontVariation(
                                                          'wght', 600),
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
                                              builder: (context) =>
                                                  ProfileEditScreen(
                                                user: user,
                                              ),
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
                                              builder: (context) =>
                                                  ProfileScreen(
                                                uid: FirebaseAuth
                                                    .instance.currentUser!.uid,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            }
                            throw Error();
                        }
                      }),
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
                  FutureBuilder(
                      future: _missionOngoings,
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
                              if (snapshot.data!.isEmpty) {
                                return Center(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 32.h),
                                    child: Text(
                                      "진행 중인 미션이 없습니다",
                                      style:
                                          FontStyle.emptyNotificationTextStyle,
                                    ),
                                  ),
                                );
                              }
                              return ListView.separated(
                                  physics: const ClampingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: ((context, index) {
                                    final mission = snapshot.data![index];

                                    return Mission(
                                      color: mission.color,
                                      content: mission.mission,
                                      id: mission.id,
                                      subColor: mission.subColor,
                                    );
                                  }),
                                  separatorBuilder: (context, index) {
                                    return SizedBox(
                                      height: 12.h,
                                    );
                                  },
                                  itemCount: snapshot.data!.length);
                            }
                            throw Error();
                        }
                      }),
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
                  FutureBuilder(
                      future: _missionRecent,
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
                              return MissionsContainer(
                                list: snapshot.data!,
                              );
                            }
                            throw Error();
                        }
                      }),
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
