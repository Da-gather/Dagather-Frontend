import 'dart:ui';

import 'package:dagather_frontend/components/app_bar.dart';
import 'package:dagather_frontend/models/user_model.dart';
import 'package:dagather_frontend/screens/home/components/filter_dialog.dart';
import 'package:dagather_frontend/screens/home/components/user_widget.dart';
import 'package:dagather_frontend/screens/home/screens/friend_manage_screen.dart';
import 'package:dagather_frontend/screens/profile/screens/profile_screen.dart';
import 'package:dagather_frontend/services/user_service.dart';
import 'package:dagather_frontend/utilities/colors.dart';
import 'package:dagather_frontend/utilities/fonts.dart';
import 'package:dagather_frontend/utilities/functions.dart';
import 'package:dagather_frontend/utilities/styles.dart';
import 'package:dagather_frontend/utilities/variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:developer' as developer;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<UserModel>> _users = UserService.getUsers();
  String _filterText = '기본 추천';

  void _refreshData(filter) {
    if (filter == ProfileFilterType.basic.name) {
      _users = UserService.getUsers();
      setState(() {});
    } else {
      _users = UserService.getUsers(option: filter);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        "친구 추천",
        actions: [
          IconButton(
              onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FriendManageScreen(),
                    ),
                  ),
              icon: const Icon(Icons.group_rounded))
        ],
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(children: [
          SizedBox(
            height: 8.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "친구 추천 목록",
                style: FontStyle.captionTextStyle,
              ),
              Row(
                children: [
                  Text(
                    _filterText,
                    style: TextStyle(
                      fontFamily: pretendardFont,
                      fontSize: 12.sp,
                      fontVariations: const [
                        FontVariation('wght', 700),
                      ],
                      color: AppColor.g600,
                    ),
                  ),
                  SizedBox(
                    height: 24.w,
                    width: 24.w,
                    child: IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return FilterDialog(
                                onPressed: (filter) {
                                  if (filter == ProfileFilterType.basic.name) {
                                    _filterText = '기본 추천';
                                  } else if (filter ==
                                      ProfileFilterType.nation.name) {
                                    _filterText = '같은 국적';
                                  }

                                  _refreshData(filter);
                                  Navigator.pop(context);
                                },
                              );
                            });
                      },
                      splashRadius: 20.w,
                      padding: const EdgeInsets.all(0),
                      iconSize: 20.w,
                      color: AppColor.g600,
                      icon: const Icon(
                        Icons.filter_list_rounded,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 8.h,
          ),
          FutureBuilder(
              future: _users,
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
                      if (snapshot.data!.isEmpty) {
                        return Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 30.h),
                            child: Text(
                              textAlign: TextAlign.center,
                              "해당하는 사용자가 없습니다",
                              style: FontStyle.emptyNotificationTextStyle,
                            ),
                          ),
                        );
                      } else {
                        return Column(
                          children: [
                            ListView.separated(
                                physics: const ClampingScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: ((context, index) {
                                  final user = snapshot.data![index];

                                  return GestureDetector(
                                    onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ProfileScreen(
                                          uid: user.uid!,
                                        ),
                                      ),
                                    ),
                                    child: UserWidget(
                                      name: user.name!,
                                      age: getAgeFromDateTime(user.birth!)
                                          .toString(),
                                      imageUrl: user.imgUrl!,
                                      purposeTags: user.purposeTags!,
                                      interestTags: user.interestTags!,
                                      region: user.region!,
                                    ),
                                  );
                                }),
                                separatorBuilder: (context, index) {
                                  return SizedBox(
                                    height: 16.h,
                                  );
                                },
                                itemCount: snapshot.data!.length),
                            SizedBox(
                              height: 32.h,
                            ),
                          ],
                        );
                      }
                    }
                }
                throw Error();
              }),
          SizedBox(
            height: 36.h,
          ),
        ]),
      )),
    );
  }
}
