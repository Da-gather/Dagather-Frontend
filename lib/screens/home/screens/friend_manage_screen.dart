import 'package:dagather_frontend/components/app_bar.dart';
import 'package:dagather_frontend/models/user_model.dart';
import 'package:dagather_frontend/screens/home/components/friend.dart';
import 'package:dagather_frontend/screens/home/components/send_friend_request.dart';
import 'package:dagather_frontend/services/friend_service.dart';
import 'package:dagather_frontend/utilities/colors.dart';
import 'package:dagather_frontend/utilities/styles.dart';
import 'package:dagather_frontend/utilities/variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../components/receive_friend_request.dart';

class FriendManageScreen extends StatelessWidget {
  FriendManageScreen({super.key});

  final Future<List<UserModel>> _receiveFriendRequest =
      FriendService.getFriendRequestsBy(FriendRequestType.receive);
  final Future<List<UserModel>> _sendFriendRequest =
      FriendService.getFriendRequestsBy(FriendRequestType.send);
  final Future<List<UserModel>> _friends = FriendService.getFriends();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar("친구/신청 관리"),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 8.h,
                  ),
                  Text(
                    "친구 신청 받은 목록",
                    style: FontStyle.captionTextStyle,
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                ],
              ),
            ),
            FutureBuilder(
              future: _receiveFriendRequest,
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
                            padding: EdgeInsets.symmetric(vertical: 32.h),
                            child: Text(
                              textAlign: TextAlign.center,
                              "받은 친구 신청이 없습니다",
                              style: FontStyle.emptyNotificationTextStyle,
                            ),
                          ),
                        );
                      } else {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              ListView.separated(
                                  physics: const ClampingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: ((context, index) {
                                    final user = snapshot.data![index];

                                    return GestureDetector(
                                      child: ReceiveFriendRequest(
                                        name: user.name,
                                        imageUrl: user.imgUrl,
                                        imgOnTapped: () {},
                                      ),
                                    );
                                  }),
                                  separatorBuilder: (context, index) {
                                    return SizedBox(
                                      height: 0.h,
                                    );
                                  },
                                  itemCount: snapshot.data!.length),
                            ],
                          ),
                        );
                      }
                    }
                    throw Error();
                }
              },
            ),
            const RequestDivder(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "친구 신청한 목록",
                    style: FontStyle.captionTextStyle,
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                ],
              ),
            ),
            FutureBuilder(
              future: _sendFriendRequest,
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
                            padding: EdgeInsets.symmetric(vertical: 32.h),
                            child: Text(
                              textAlign: TextAlign.center,
                              "보낸 친구 신청이 없습니다",
                              style: FontStyle.emptyNotificationTextStyle,
                            ),
                          ),
                        );
                      } else {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              ListView.separated(
                                  physics: const ClampingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: ((context, index) {
                                    final user = snapshot.data![index];

                                    return GestureDetector(
                                      child: SendFriendRequest(
                                        name: user.name,
                                        imageUrl: user.imgUrl,
                                        imgOnTapped: () {},
                                      ),
                                    );
                                  }),
                                  separatorBuilder: (context, index) {
                                    return SizedBox(
                                      height: 0.h,
                                    );
                                  },
                                  itemCount: snapshot.data!.length),
                            ],
                          ),
                        );
                      }
                    }
                    throw Error();
                }
              },
            ),
            const RequestDivder(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "친구 목록",
                    style: FontStyle.captionTextStyle,
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                ],
              ),
            ),
            FutureBuilder(
              future: _friends,
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
                            padding: EdgeInsets.symmetric(vertical: 32.h),
                            child: Text(
                              textAlign: TextAlign.center,
                              "아직 친구가 없습니다.",
                              style: FontStyle.emptyNotificationTextStyle,
                            ),
                          ),
                        );
                      } else {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              ListView.separated(
                                  physics: const ClampingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: ((context, index) {
                                    final user = snapshot.data![index];

                                    return GestureDetector(
                                      child: Friend(
                                        name: user.name,
                                        imageUrl: user.imgUrl,
                                        imgOnTapped: () {},
                                      ),
                                    );
                                  }),
                                  separatorBuilder: (context, index) {
                                    return SizedBox(
                                      height: 0.h,
                                    );
                                  },
                                  itemCount: snapshot.data!.length),
                            ],
                          ),
                        );
                      }
                    }
                    throw Error();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class RequestDivder extends StatelessWidget {
  const RequestDivder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 24.h, bottom: 32.h),
      child: Divider(
        thickness: 8.h,
        color: AppColor.g100,
      ),
    );
  }
}
