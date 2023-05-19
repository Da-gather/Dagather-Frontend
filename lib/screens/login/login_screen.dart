import 'dart:ui';

import 'package:dagather_frontend/components/navigation_bar.dart';
import 'package:dagather_frontend/provider/user_provider.dart';
import 'package:dagather_frontend/utilities/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import '../../utilities/fonts.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  Future<UserCredential> _signInWithGoogle() async {
    final GoogleSignInAccount? user = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth = await user?.authentication;
    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User?> user) {
          if (user.hasData) {
            context.read<UserProvider>().setUserId(user.data!.uid);

            return const BaseScaffold();
          } else {
            return Scaffold(
              body: Stack(
                children: [
                  Positioned(
                    bottom: -130.h,
                    left: -170.w,
                    child: SvgPicture.asset(
                      'assets/images/img_giant_blob_blue.svg',
                    ),
                  ),
                  Positioned(
                    top: -440.h,
                    right: -400.w,
                    child: SvgPicture.asset(
                      'assets/images/img_giant_blob_red.svg',
                    ),
                  ),
                  Positioned(
                    bottom: -200.h,
                    right: -150.w,
                    child: SvgPicture.asset(
                      'assets/images/img_giant_blob_green.svg',
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 36.h, horizontal: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/icons/ic_app_icon_large.svg',
                                width: 80.w,
                              ),
                              SizedBox(
                                height: 12.h,
                              ),
                              Text(
                                "Da:gather",
                                style: TextStyle(
                                  fontFamily: suitFont,
                                  fontSize: 28.sp,
                                  fontVariations: const [
                                    FontVariation('wght', 800),
                                  ],
                                  color: AppColor.blue,
                                ),
                              ),
                              SizedBox(
                                height: 40.h,
                              ),
                            ],
                          ),
                        ),
                        TextButton(
                          onPressed: _signInWithGoogle,
                          style: TextButton.styleFrom(
                            minimumSize: Size(350.w, 55.h),
                            backgroundColor: AppColor.yellow4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8).r,
                            ),
                          ),
                          child: Text(
                            "구글로 로그인/회원가입",
                            style: TextStyle(
                              fontFamily: pretendardFont,
                              fontSize: 15.sp,
                              fontVariations: const [
                                FontVariation('wght', 700),
                              ],
                              color: AppColor.g900,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
