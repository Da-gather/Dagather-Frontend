import 'dart:io';
import 'dart:ui';
import 'package:dagather_frontend/components/app_bar.dart';
import 'package:dagather_frontend/components/base_button.dart';
import 'package:dagather_frontend/components/base_tag.dart';
import 'package:dagather_frontend/components/navigation_bar.dart';
import 'package:dagather_frontend/models/tag_model.dart';
import 'package:dagather_frontend/models/user_model.dart';
import 'package:dagather_frontend/services/user_service.dart';
import 'package:dagather_frontend/utilities/colors.dart';
import 'package:dagather_frontend/utilities/fonts.dart';
import 'package:dagather_frontend/utilities/styles.dart';
import 'package:dagather_frontend/utilities/variables.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TutorialStep3Screen extends StatefulWidget {
  final UserModel user;
  final File profileImage;

  const TutorialStep3Screen(
      {super.key, required this.user, required this.profileImage});

  @override
  State<TutorialStep3Screen> createState() => _TutorialStep3ScreenState();
}

class _TutorialStep3ScreenState extends State<TutorialStep3Screen> {
  final TextEditingController _textController = TextEditingController();
  final interestList = interests.map((item) {
    return TagModel(item, false, TagType.interest);
  }).toList();
  final purposeList = purposes.map((item) {
    return TagModel(item, false, TagType.purpose);
  }).toList();

  List<TagModel> _getListWithSelected(List<TagModel> list) {
    return list.where((element) => element.isSelected).toList();
  }

  int _countSelected(List<TagModel> list) {
    return list.where((element) => element.isSelected).length;
  }

  bool _isButtonDisable() {
    return _countSelected(purposeList) == 0 ||
        _countSelected(interestList) < 3 ||
        _countSelected(interestList) > 10 ||
        _textController.text.isEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(""),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 16.h),
              Text(
                "STEP 3/3",
                style: FontStyle.stepTextStyle,
              ),
              SizedBox(height: 8.h),
              Text(
                "이제 마지막 단계에요!\n간단한 자기소개를 해주세요",
                style: FontStyle.titleTextStyle,
              ),
              SizedBox(height: 36.h),
              Text(
                "가입 목적(최소 1개)",
                style: FontStyle.captionTextStyle,
              ),
              SizedBox(height: 8.h),
              Container(
                color: Colors.transparent,
                child: Wrap(
                  direction: Axis.horizontal,
                  alignment: WrapAlignment.start,
                  spacing: 4.w,
                  runSpacing: 4.h,
                  children: List.generate(
                      purposeList.length,
                      (index) => GestureDetector(
                            onTap: () {
                              HapticFeedback.lightImpact();
                              purposeList[index].isSelected =
                                  !purposeList[index].isSelected;
                              setState(() {});
                            },
                            child: BaseTag(
                              type: purposeList[index].type,
                              text: purposeList[index].text,
                              changeColor: purposeList[index].isSelected,
                            ),
                          )),
                ),
              ),
              SizedBox(height: 32.h),
              Text(
                "관심사(최소 3개, 최대 10개)",
                style: FontStyle.captionTextStyle,
              ),
              SizedBox(height: 8.h),
              Container(
                color: Colors.transparent,
                child: Wrap(
                  direction: Axis.horizontal,
                  alignment: WrapAlignment.start,
                  spacing: 4.w,
                  runSpacing: 4.h,
                  children: List.generate(
                      interestList.length,
                      (index) => GestureDetector(
                            onTap: () {
                              if (!interestList[index].isSelected &&
                                  _countSelected(interestList) >= 10) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text('최대 10개까지만 선택 가능합니다'),
                                  duration: Duration(milliseconds: 500),
                                  behavior: SnackBarBehavior.fixed,
                                  backgroundColor: AppColor.g800,
                                ));
                                return;
                              }
                              HapticFeedback.lightImpact();
                              interestList[index].isSelected =
                                  !interestList[index].isSelected;
                              setState(() {});
                            },
                            child: BaseTag(
                              type: interestList[index].type,
                              text: interestList[index].text,
                              changeColor: interestList[index].isSelected,
                            ),
                          )),
                ),
              ),
              SizedBox(height: 32.h),
              Text(
                "자기소개",
                style: FontStyle.captionTextStyle,
              ),
              SizedBox(height: 8.h),
              TextField(
                onChanged: (value) => setState(() {}),
                controller: _textController,
                style: TextStyle(
                  fontFamily: pretendardFont,
                  fontSize: 15.sp,
                  height: 1.55,
                  fontVariations: const [
                    FontVariation('wght', 600),
                  ],
                  color: AppColor.g700,
                ),
                maxLines: 8,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText:
                      '자유롭게 자기소개를 작성해 주세요. 가입 목적 또는 관심사에 대해 좀 더 자세히 알려주셔도 좋아요.',
                  hintStyle: TextStyle(
                    fontFamily: pretendardFont,
                    fontSize: 15.sp,
                    height: 1.55,
                    fontVariations: const [
                      FontVariation('wght', 600),
                    ],
                    color: AppColor.g400,
                  ),
                  filled: true,
                  fillColor: AppColor.g100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.r)),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                ),
              ),
              SizedBox(height: 52.h),
              BaseButton(
                text: "완료",
                isDisable: _isButtonDisable(),
                onPressed: () async {
                  widget.user.purposeTags = _getListWithSelected(purposeList);
                  widget.user.interestTags = _getListWithSelected(interestList);
                  widget.user.introduction = _textController.text;
                  widget.user.uid = FirebaseAuth.instance.currentUser!.uid;

                  await UserService.putUser(widget.user);
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('환영합니다'),
                      duration: Duration(microseconds: 500),
                      behavior: SnackBarBehavior.fixed,
                      backgroundColor: AppColor.g800,
                    ));
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const BaseScaffold()),
                        (route) => false);
                  }
                },
              ),
              SizedBox(height: 36.h),
            ],
          ),
        ),
      )),
    );
  }
}
