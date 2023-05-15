import 'package:dagather_frontend/components/app_bar.dart';
import 'package:dagather_frontend/screens/home/components/friend.dart';
import 'package:dagather_frontend/screens/home/screens/friend_manage_screen.dart';
import 'package:dagather_frontend/screens/profile/screens/profile_screen.dart';
import 'package:dagather_frontend/utilities/colors.dart';
import 'package:dagather_frontend/utilities/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
              SizedBox(
                height: 24.w,
                width: 24.w,
                child: IconButton(
                  onPressed: () {},
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
          SizedBox(
            height: 8.h,
          ),
          Column(
            children: List.generate(
                10,
                (index) => GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProfileScreen(),
                        ),
                      ),
                      child: const Friend(
                        imageUrl:
                            "https://images.unsplash.com/photo-1605434700731-331ca2458a77?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1365&q=80",
                      ),
                    )),
          ),
          SizedBox(
            height: 36.h,
          ),
        ]),
      )),
    );
  }
}
