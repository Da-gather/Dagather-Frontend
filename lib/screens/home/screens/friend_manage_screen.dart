import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dagather_frontend/components/app_bar.dart';
import 'package:dagather_frontend/components/base_dialog.dart';
import 'package:dagather_frontend/models/chat_model.dart';
import 'package:dagather_frontend/models/friend_model.dart';
import 'package:dagather_frontend/models/user_model.dart';
import 'package:dagather_frontend/screens/home/components/friend.dart';
import 'package:dagather_frontend/screens/home/components/send_friend_request.dart';
import 'package:dagather_frontend/screens/profile/screens/profile_screen.dart';
import 'package:dagather_frontend/services/chat_service.dart';
import 'package:dagather_frontend/services/friend_service.dart';
import 'package:dagather_frontend/services/user_service.dart';
import 'package:dagather_frontend/utilities/colors.dart';
import 'package:dagather_frontend/utilities/styles.dart';
import 'package:dagather_frontend/utilities/variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../components/receive_friend_request.dart';

class FriendManageScreen extends StatefulWidget {
  const FriendManageScreen({super.key});

  @override
  State<FriendManageScreen> createState() => _FriendManageScreenState();
}

class _FriendManageScreenState extends State<FriendManageScreen> {
  final Future<List<FriendModel>> _receiveFriendRequest =
      FriendService.getFriendRequestsBy(FriendRequestType.receive);

  final Future<List<FriendModel>> _sendFriendRequest =
      FriendService.getFriendRequestsBy(FriendRequestType.send);

  final Future<List<FriendModel>> _friends = FriendService.getFriends();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar("친구/신청 관리"),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
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
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    ListView.separated(
                                        physics: const ClampingScrollPhysics(),
                                        shrinkWrap: true,
                                        itemBuilder: ((context, index) {
                                          final friend = snapshot.data![index];

                                          return GestureDetector(
                                            child: ReceiveFriendRequest(
                                              name: friend.name!,
                                              imageUrl: friend.imgUrl!,
                                              imgOnTapped: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ProfileScreen(
                                                              uid: friend.uid!,
                                                            )));
                                              },
                                              refuseButtonOnTapped: () {
                                                FriendService.deleteFriend(
                                                        friend.id)
                                                    .then((value) => showDialog(
                                                        barrierDismissible:
                                                            false,
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return BaseDialog(
                                                            buttonText: '확인',
                                                            content:
                                                                '친구 신청을 거절했습니다.',
                                                            onPressed: () {},
                                                          );
                                                        }));
                                              },
                                              approveButtonOnTapped: () async {
                                                await _approveFriend(
                                                    friend.id, context);
                                              },
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
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    ListView.separated(
                                        physics: const ClampingScrollPhysics(),
                                        shrinkWrap: true,
                                        itemBuilder: ((context, index) {
                                          final friend = snapshot.data![index];

                                          return GestureDetector(
                                            child: SendFriendRequest(
                                              name: friend.name!,
                                              imageUrl: friend.imgUrl!,
                                              imgOnTapped: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ProfileScreen(
                                                              uid: friend.uid!,
                                                            )));
                                              },
                                              cancelBtnOnTapped: () {
                                                _isLoading = true;
                                                setState(() {});
                                                FriendService.deleteFriend(
                                                        friend.id)
                                                    .then((value) {
                                                  _isLoading = false;
                                                  setState(() {});
                                                });
                                              },
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
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    ListView.separated(
                                        physics: const ClampingScrollPhysics(),
                                        shrinkWrap: true,
                                        itemBuilder: ((context, index) {
                                          final friend = snapshot.data![index];
                                          return GestureDetector(
                                            child: Friend(
                                              name: friend.name!,
                                              imageUrl: friend.imgUrl!,
                                              imgOnTapped: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ProfileScreen(
                                                              uid: friend.uid!,
                                                            )));
                                              },
                                              cancelBtnOnTapped: () {
                                                FriendService.deleteFriend(
                                                        friend.id)
                                                    .then((value) => ChatService
                                                        .deleteChatRoomInFireStore(
                                                            friend.chatroomId!))
                                                    .then((value) => showDialog(
                                                        barrierDismissible:
                                                            false,
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return BaseDialog(
                                                            buttonText: '확인',
                                                            content:
                                                                '친구가 삭제되었습니다.',
                                                            onPressed: () {},
                                                          );
                                                        }));
                                              },
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

  Future<void> _approveFriend(int id, BuildContext context) async {
    final FriendModel friendModel = await FriendService.acceptFriend(id);
    final UserModel sender =
        await UserService.getUserById(friendModel.senderId);
    final UserModel receiver =
        await UserService.getUserById(friendModel.receiverId);

    final ChatModel chatModel = ChatModel.initWithUsers(sender, receiver);
    final DocumentReference documentReference =
        await ChatService.createChatRoomInFireStore(chatModel.toJson());
    await FriendService.createChatroom(id, documentReference.id);
    if (mounted) {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return BaseDialog(
              buttonText: '확인',
              content: '친구 신청이 수락되었습니다.',
              onPressed: () {},
            );
          });
    }
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
