import 'dart:io';
import 'package:dagather_frontend/components/app_bar.dart';
import 'package:dagather_frontend/components/base_button.dart';
import 'package:dagather_frontend/models/user_model.dart';
import 'package:dagather_frontend/screens/login/screens/tutorial_step_2_screen.dart';
import 'package:dagather_frontend/utilities/colors.dart';
import 'package:dagather_frontend/utilities/functions.dart';
import 'package:dagather_frontend/utilities/styles.dart';
import 'package:dagather_frontend/utilities/variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class TutorialStep1Screen extends StatefulWidget {
  const TutorialStep1Screen({super.key});

  @override
  State<TutorialStep1Screen> createState() => _TutorialStep1ScreenState();
}

class _TutorialStep1ScreenState extends State<TutorialStep1Screen> {
  DateTime? _date;
  GenderType? _gender;
  String? _region;
  File? _profileImage;
  bool _isMenSelected = false;
  bool _isWomenSelected = false;
  final UserModel _user = UserModel();

  final TextEditingController _textController = TextEditingController();
  final ImagePicker picker = ImagePicker();

  bool _isButtonDisable() {
    return _profileImage == null ||
        _date == null ||
        _gender == null ||
        _region == null ||
        _textController.text.isEmpty;
  }

  void _changeGenderButtonState(selected) {
    if (selected == GenderType.man) {
      if (_isWomenSelected) {
        _isWomenSelected = false;
      }
      _isMenSelected = true;
      _gender = GenderType.man;
    }

    if (selected == GenderType.woman) {
      if (_isMenSelected) {
        _isMenSelected = false;
      }
      _isWomenSelected = true;
      _gender = GenderType.woman;
    }
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
                "STEP 1/3",
                style: FontStyle.stepTextStyle,
              ),
              SizedBox(height: 8.h),
              Text(
                "안녕하세요!\n기본 정보를 입력해 주세요",
                style: FontStyle.titleTextStyle,
              ),
              SizedBox(height: 36.h),
              Text(
                "이름",
                style: FontStyle.captionTextStyle,
              ),
              SizedBox(height: 8.h),
              TextField(
                onChanged: (value) => setState(() {}),
                controller: _textController,
                style: FontStyle.inputTextStyle,
                maxLines: 1,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  hintText: '이름을 입력해 주세요.',
                  hintStyle: FontStyle.hintTextStyle,
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
              SizedBox(height: 32.h),
              Text(
                "성별",
                style: FontStyle.captionTextStyle,
              ),
              SizedBox(height: 8.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        HapticFeedback.lightImpact();
                        setState(() {
                          _changeGenderButtonState(GenderType.man);
                        });
                      },
                      style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 20.h),
                          backgroundColor:
                              _isMenSelected ? AppColor.g700 : AppColor.g100,
                          shape: RoundedRectangleBorder(
                            borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10))
                                .r,
                          )),
                      child: Text(
                        "남자",
                        style: FontStyle.hintTextStyle,
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        HapticFeedback.lightImpact();
                        setState(() {
                          _changeGenderButtonState(GenderType.woman);
                        });
                      },
                      style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 20.h),
                          backgroundColor:
                              _isWomenSelected ? AppColor.g700 : AppColor.g100,
                          shape: RoundedRectangleBorder(
                            borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10))
                                .r,
                          )),
                      child: Text(
                        "여자",
                        style: FontStyle.hintTextStyle,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 32.h),
              Text(
                "생년월일",
                style: FontStyle.captionTextStyle,
              ),
              SizedBox(height: 8.h),
              GestureDetector(
                onTap: () async {
                  HapticFeedback.lightImpact();
                  final selectedDate = await showDatePicker(
                    context: context,
                    initialDate: _date != null ? _date! : DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (selectedDate != null) {
                    setState(() {
                      _date = selectedDate;
                    });
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColor.g100,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _date != null
                              ? DateFormat('yyyy.MM.dd').format(_date!)
                              : "생년월일 선택",
                          style: _date != null
                              ? FontStyle.inputTextStyle
                              : FontStyle.hintTextStyle,
                        ),
                        Icon(
                          Icons.calendar_month_rounded,
                          color: AppColor.g400,
                          size: 24.w,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 32.h),
              Text(
                "국적",
                style: FontStyle.captionTextStyle,
              ),
              SizedBox(height: 8.h),
              DropdownButtonHideUnderline(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColor.g100,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 6.h, horizontal: 20.w),
                    child: DropdownButton(
                      hint: Text(
                        "국적 선택",
                        style: FontStyle.hintTextStyle,
                      ),
                      enableFeedback: true,
                      value: _region,
                      elevation: 0,
                      style: FontStyle.inputTextStyle,
                      icon: Icon(
                        Icons.arrow_drop_down_rounded,
                        color: AppColor.g400,
                        size: 24.w,
                      ),
                      borderRadius: BorderRadius.circular(10.r),
                      items: countries.map((item) {
                        return DropdownMenuItem<String>(
                          value: item["code"],
                          child: Text('${item["emoji"]!}  ${item["name"]!}'),
                        );
                      }).toList(),
                      onChanged: (dynamic value) {
                        setState(() {
                          _region = value;
                        });
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(height: 32.h),
              Text(
                "사진",
                style: FontStyle.captionTextStyle,
              ),
              SizedBox(height: 8.h),
              GestureDetector(
                onTap: () async {
                  HapticFeedback.lightImpact();
                  final image =
                      await picker.pickImage(source: ImageSource.gallery);
                  if (image != null) {
                    _profileImage = File(image.path);
                    setState(() {});
                  }
                },
                child: _profileImage == null
                    ? Container(
                        height: 300.h,
                        decoration: BoxDecoration(
                          color: AppColor.g100,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add_photo_alternate_rounded,
                              color: AppColor.g400,
                              size: 40.w,
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            Text(
                              "눌러서 사진 선택",
                              style: FontStyle.hintTextStyle,
                            ),
                          ],
                        ),
                      )
                    : ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)).r,
                        child: Container(
                          height: 300.h,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              alignment: FractionalOffset.center,
                              image:
                                  Image.file(File(_profileImage!.path)).image,
                            ),
                          ),
                        ),
                      ),
              ),
              SizedBox(height: 52.h),
              BaseButton(
                text: "다음",
                isDisable: _isButtonDisable(),
                onPressed: () {
                  _user.name = _textController.text;
                  _user.gender = getGenderBool(_gender!);
                  _user.birth = _date;
                  _user.region = _region;
                  _user.imgUrl = _profileImage!.path;

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TutorialStep2Screen(
                              user: _user,
                              profileImage: _profileImage!,
                            )),
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
