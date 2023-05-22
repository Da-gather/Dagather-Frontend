import 'dart:ui';

import 'package:dagather_frontend/components/action_dialog.dart';
import 'package:dagather_frontend/components/app_bar.dart';
import 'package:dagather_frontend/components/base_medium_button.dart';
import 'package:dagather_frontend/components/mission.dart';
import 'package:dagather_frontend/models/mission_model.dart';
import 'package:dagather_frontend/screens/mission/components/missions_container.dart';
import 'package:dagather_frontend/services/mission_service.dart';
import 'package:dagather_frontend/utilities/colors.dart';
import 'package:dagather_frontend/utilities/fonts.dart';
import 'package:dagather_frontend/utilities/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../components/user_mission_state.dart';

class MissionScreen extends StatelessWidget {
  final String chatroomId;
  final String friendId;

  late Future<MissionModel> _missionOngoing;
  late Future<List<MissionModel>> _missionRecent;

  MissionScreen({super.key, required this.chatroomId, required this.friendId}) {
    _missionOngoing = MissionService.getOngoingMission(friendId);
    _missionRecent =
        MissionService.getRecentMission(FirebaseAuth.instance.currentUser!.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar("미션"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 8.h,
                  ),
                  Text(
                    "이번 미션",
                    style: FontStyle.captionTextStyle,
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  FutureBuilder(
                      future: _missionOngoing,
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
                              final data = snapshot.data!;
                              return Mission(
                                  content: data.mission,
                                  color: data.color,
                                  subColor: data.subColor,
                                  id: data.id);
                            }
                            throw Error();
                        }
                      }),
                  SizedBox(
                    height: 8.h,
                  ),
                  Row(
                    children: [
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: BaseMidiumButton(
                            textColor: AppColor.g400,
                            backgroundColor: AppColor.g200,
                            text: "건너뛰기",
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return ActionDialog(
                                      buttonColor: AppColor.red,
                                      buttonText: '건너뛰기',
                                      content:
                                          '미션을 건너뛰시겠습니까?\n상대방의 미션도 자동으로 변경되니 상대방과의 충분한 상의 후 다음 미션으로 변경하시길 바랍니다.',
                                      onPressed: () {},
                                    );
                                  });
                            }),
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      Flexible(
                        flex: 3,
                        fit: FlexFit.tight,
                        child: BaseMidiumButton(
                            textColor: AppColor.g200,
                            backgroundColor: AppColor.g800,
                            text: "미션 완료하기",
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return ActionDialog(
                                      buttonColor: AppColor.yellow4,
                                      buttonText: '완료하기',
                                      content: '미션을 완료하겠습니까?',
                                      onPressed: () {},
                                    );
                                  });
                            }),
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
                      padding: EdgeInsets.symmetric(
                          horizontal: 32.w, vertical: 20.h),
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
            Padding(
              padding: EdgeInsets.symmetric(vertical: 24.h),
              child: Divider(
                thickness: 8.h,
                color: AppColor.g100,
              ),
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
                                hasTitle: false,
                                list: snapshot.data!,
                              );
                            }
                            throw Error();
                        }
                      }),
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
