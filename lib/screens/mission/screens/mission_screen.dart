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
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../components/user_mission_state.dart';

class MissionScreen extends StatefulWidget {
  final String chatroomId;
  final String friendId;

  const MissionScreen(
      {super.key, required this.chatroomId, required this.friendId});

  @override
  State<MissionScreen> createState() => _MissionScreenState();
}

class _MissionScreenState extends State<MissionScreen> {
  late Future<MissionModel> _missionOngoing =
      MissionService.getOngoingMission(widget.friendId);
  late Future<List<MissionModel>> _missionCompleted =
      MissionService.getCompletedMissionsWith(widget.friendId);

  String _getText(String currentUserName, String friendName,
      bool hasCurrentUserCompleted, bool hasFriendCompleted) {
    if (!hasCurrentUserCompleted && !hasFriendCompleted) {
      return "미션을 완수한 사람이 없습니다.";
    } else if (hasCurrentUserCompleted) {
      return "아직 $currentUserName님이 미션을 완수하지 않았습니다. 두 명 모두 미션을 완료하면 새로운 미션을 받을 수 있습니다.";
    } else if (hasFriendCompleted) {
      return "아직 $friendName님이 미션을 완수하지 않았습니다. 두 명 모두 미션을 완료하면 새로운 미션을 받을 수 있습니다.";
    }
    return '모두 미션을 완료했습니다.';
  }

  void _refreshData() {
    _missionOngoing = MissionService.getOngoingMission(widget.friendId);
    _missionCompleted =
        MissionService.getCompletedMissionsWith(widget.friendId);
    setState(() {});
  }

  Widget _getCompleteStateInfo(MissionModel missionModel) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.g200,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 20.h),
        child: Center(
          child: Text(
            _getText(
                missionModel.currentUserName!,
                missionModel.friendName!,
                missionModel.hasCurrentUserCompleted,
                missionModel.hasFriendCompleted),
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
    );
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
              child: FutureBuilder(
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
                          return Column(
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
                              Mission(
                                  content: data.mission,
                                  color: data.color,
                                  subColor: data.subColor,
                                  id: data.id),
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
                                        textColor: data.hasCurrentUserCompleted
                                            ? AppColor.g200
                                            : AppColor.g200,
                                        backgroundColor:
                                            data.hasCurrentUserCompleted
                                                ? AppColor.g400
                                                : AppColor.g800,
                                        text: data.hasCurrentUserCompleted
                                            ? "미션 완료"
                                            : "미션 완료하기",
                                        onPressed: data.hasCurrentUserCompleted
                                            ? null
                                            : () {
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return WillPopScope(
                                                        onWillPop: () async {
                                                          await MissionService
                                                              .completeMission(
                                                                  data.currentUserId!,
                                                                  data.friendId);
                                                          _refreshData();
                                                          return true;
                                                        },
                                                        child: ActionDialog(
                                                          buttonColor:
                                                              AppColor.yellow4,
                                                          buttonText: '완료하기',
                                                          content:
                                                              '미션을 완료하겠습니까?',
                                                          onPressed: () {
                                                            MissionService.completeMission(
                                                                    data
                                                                        .currentUserId!,
                                                                    data
                                                                        .friendId)
                                                                .then((value) {
                                                              _refreshData();
                                                            }).then((value) =>
                                                                    Navigator.pop(
                                                                        context));
                                                          },
                                                        ),
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
                                children: [
                                  UserMissionState(
                                    hasCompleted: data.hasFriendCompleted,
                                    imgUrl: data.friendImgUrl,
                                    name: data.friendName!,
                                  ),
                                  UserMissionState(
                                    hasCompleted: data.hasCurrentUserCompleted,
                                    imgUrl: data.currentUserImgUrl!,
                                    name: data.currentUserName!,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 8.h,
                              ),
                              _getCompleteStateInfo(data),
                            ],
                          );
                        }
                        throw Error();
                    }
                  }),
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
                      future: _missionCompleted,
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
