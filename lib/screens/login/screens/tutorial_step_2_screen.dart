import 'dart:io';

import 'package:dagather_frontend/components/app_bar.dart';
import 'package:dagather_frontend/components/base_button.dart';
import 'package:dagather_frontend/models/user_model.dart';
import 'package:dagather_frontend/screens/login/screens/tutorial_step_3_screen.dart';
import 'package:dagather_frontend/utilities/colors.dart';
import 'package:dagather_frontend/utilities/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remedi_kopo/remedi_kopo.dart';
import 'package:geocoding/geocoding.dart';

class TutorialStep2Screen extends StatefulWidget {
  final UserModel user;
  final File profileImage;

  const TutorialStep2Screen(
      {super.key, required this.user, required this.profileImage});

  @override
  State<TutorialStep2Screen> createState() => _TutorialStep2ScreenState();
}

class _TutorialStep2ScreenState extends State<TutorialStep2Screen> {
  final TextEditingController _textController = TextEditingController();
  String _address = "";

  List<Location>? locations;

  bool _isButtonDisable() {
    return _textController.text.isEmpty || _address.isEmpty;
  }

  Future<void> getLocations() async {
    locations = await locationFromAddress(_address);

    widget.user.latitude = locations![0].latitude;
    widget.user.longitude = locations![0].longitude;
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
                "STEP 2/3",
                style: FontStyle.stepTextStyle,
              ),
              SizedBox(height: 8.h),
              Text(
                "거주 정보를\n입력해 주세요",
                style: FontStyle.titleTextStyle,
              ),
              SizedBox(height: 36.h),
              Text(
                "한국 거주 기간",
                style: FontStyle.captionTextStyle,
              ),
              SizedBox(height: 8.h),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (value) => setState(() {}),
                      controller: _textController,
                      style: FontStyle.inputTextStyle,
                      maxLines: 1,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.end,
                      decoration: InputDecoration(
                        hintText: '4년 5개월 살았을 경우 5년 이하',
                        hintStyle: FontStyle.hintTextStyle,
                        filled: true,
                        fillColor: AppColor.g100,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.r)),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 20.h),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 12.w,
                  ),
                  Text(
                    "년 이하",
                    style: FontStyle.inputTextStyle,
                  ),
                ],
              ),
              SizedBox(height: 32.h),
              Text(
                "거주지",
                style: FontStyle.captionTextStyle,
              ),
              SizedBox(height: 8.h),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        KopoModel? model = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RemediKopo(),
                          ),
                        );
                        if (model != null) {
                          setState(() {
                            if (model.sido != null &&
                                model.sigungu != null &&
                                model.sido!.isNotEmpty &&
                                model.sigungu!.isNotEmpty) {
                              _address = model.jibunAddress!;
                            } else {
                              throw Error();
                            }
                          });
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColor.g100,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 20.h),
                          child: Text(
                            _address.isEmpty ? '주소를 검색하세요' : _address,
                            style: _address.isEmpty
                                ? FontStyle.hintTextStyle
                                : FontStyle.inputTextStyle,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.search_rounded,
                        size: 24.w,
                        color: AppColor.g600,
                      ),
                      onPressed: () async {
                        KopoModel? model = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RemediKopo(),
                          ),
                        );
                        if (model != null) {
                          setState(() {
                            if (model.sido != null &&
                                model.sigungu != null &&
                                model.sido!.isNotEmpty &&
                                model.sigungu!.isNotEmpty) {
                              _address = model.jibunAddress!;
                            } else {
                              throw Error();
                            }
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 52.h),
              BaseButton(
                text: "다음",
                isDisable: _isButtonDisable(),
                onPressed: () {
                  getLocations();
                  widget.user.period = int.parse(_textController.text);
                  widget.user.address = _address;

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TutorialStep3Screen(
                        profileImage: widget.profileImage,
                        user: widget.user,
                      ),
                    ),
                  );
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
