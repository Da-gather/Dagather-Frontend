import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dagather_frontend/components/app_bar.dart';
import 'package:dagather_frontend/components/base_dialog.dart';
import 'package:dagather_frontend/components/base_medium_button.dart';
import 'package:dagather_frontend/models/user_model.dart';
import 'package:dagather_frontend/screens/mission/components/mission_statistics.dart';
import 'package:dagather_frontend/screens/mission/components/missions_container.dart';

import 'package:dagather_frontend/services/friend_service.dart';
import 'package:dagather_frontend/services/mission_service.dart';
import 'package:dagather_frontend/services/user_service.dart';
import 'package:dagather_frontend/utilities/colors.dart';
import 'package:dagather_frontend/utilities/fonts.dart';
import 'package:dagather_frontend/utilities/functions.dart';
import 'package:dagather_frontend/utilities/styles.dart';
import 'package:dagather_frontend/utilities/variables.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:developer' as developer;

import '../components/same_tag_calculator.dart';
import '../components/tag.dart';

class ProfileScreen extends StatelessWidget {
  final String uid;
  late Future<UserModel> _user;
  late Future<Map<String, dynamic>> _missionStatistics;

  ProfileScreen({super.key, required this.uid}) {
    _user = UserService.getUserById(uid);
    _missionStatistics = MissionService.getMissionStatistics(uid);
  }

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
                        developer.log(snapshot.error.toString());
                        throw Error();
                      }
                      if (snapshot.hasData) {
                        final user = snapshot.data!;
                        int purposeCount = 0;
                        int interestCount = 0;
                        for (var element in user.purposeTags!) {
                          if (element.changeColor) purposeCount++;
                        }
                        for (var element in user.interestTags!) {
                          if (element.changeColor) interestCount++;
                        }
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12.r),
                                child: CachedNetworkImage(
                                  height: 300.h,
                                  fit: BoxFit.cover,
                                  imageUrl: user.imgUrl,
                                  placeholder: (context, url) => Container(
                                    color: AppColor.g200,
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              ),
                              SizedBox(
                                height: 24.h,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        user.name,
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
                                        height: 4.h,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "🇨🇳 ${user.region}",
                                            style: TextStyle(
                                              fontFamily: pretendardFont,
                                              fontSize: 16.sp,
                                              fontVariations: const [
                                                FontVariation('wght', 600),
                                              ],
                                              color: AppColor.g500,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 6.w,
                                          ),
                                          Text(
                                            '${getAgeFromDateTime(user.birth!).toString()}살',
                                            style: TextStyle(
                                              fontFamily: pretendardFont,
                                              fontSize: 16.sp,
                                              fontVariations: const [
                                                FontVariation('wght', 600),
                                              ],
                                              color: AppColor.g500,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 6.w,
                                          ),
                                          Text(
                                            getGender(user.gender),
                                            style: TextStyle(
                                              fontFamily: pretendardFont,
                                              fontSize: 16.sp,
                                              fontVariations: const [
                                                FontVariation('wght', 600),
                                              ],
                                              color: AppColor.g500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  if (uid !=
                                      FirebaseAuth.instance.currentUser!.uid)
                                    BaseMidiumButton(
                                      textColor: AppColor.g900,
                                      backgroundColor: AppColor.yellow4,
                                      text: "친구 신청",
                                      onPressed: () {
                                        FriendService.sendFriendRequestTo(
                                                user.uid)
                                            .then((value) => showDialog(
                                                barrierDismissible: false,
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return BaseDialog(
                                                    buttonText: '확인',
                                                    content: '친구 신청이 완료되었습니다.',
                                                    onPressed: () {},
                                                  );
                                                }));
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
                                user.introduction!,
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
                                user.address!,
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
                                user.period!,
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
                              if (uid != FirebaseAuth.instance.currentUser!.uid)
                                SameTagCalculator(
                                  count: purposeCount,
                                  type: TagType.purpose,
                                ),
                              SizedBox(
                                height: 8.h,
                              ),
                              Container(
                                color: Colors.transparent,
                                child: Wrap(
                                  direction: Axis.horizontal,
                                  alignment: WrapAlignment.start,
                                  spacing: 4.w,
                                  runSpacing: 4.h,
                                  children: List.generate(
                                      user.purposeTags!.length,
                                      (index) => Tag(
                                            type: user.purposeTags![index].type,
                                            text: user.purposeTags![index].text,
                                            changeColor: user
                                                .purposeTags![index]
                                                .changeColor,
                                          )),
                                ),
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
                              if (uid != FirebaseAuth.instance.currentUser!.uid)
                                SameTagCalculator(
                                  count: interestCount,
                                  type: TagType.interest,
                                ),
                              SizedBox(
                                height: 8.h,
                              ),
                              Container(
                                color: Colors.transparent,
                                child: Wrap(
                                  direction: Axis.horizontal,
                                  alignment: WrapAlignment.start,
                                  spacing: 4.w,
                                  runSpacing: 4.h,
                                  children: List.generate(
                                      user.interestTags!.length,
                                      (index) => Tag(
                                            type:
                                                user.interestTags![index].type,
                                            text:
                                                user.interestTags![index].text,
                                            changeColor: user
                                                .interestTags![index]
                                                .changeColor,
                                          )),
                                ),
                              ),

                              // WsmBoxWidget()
                            ],
                          ),
                        );
                      }
                      throw Error();
                  }
                }),
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
            SizedBox(
              height: 36.h,
            ),
          ],
        ),
      ),
    );
  }
}
