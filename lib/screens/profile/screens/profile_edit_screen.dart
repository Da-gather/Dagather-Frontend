import 'dart:io';
import 'dart:ui';

import 'package:dagather_frontend/components/app_bar.dart';
import 'package:dagather_frontend/components/base_button.dart';
import 'package:dagather_frontend/components/base_tag.dart';
import 'package:dagather_frontend/components/navigation_bar.dart';
import 'package:dagather_frontend/models/tag_model.dart';
import 'package:dagather_frontend/models/user_model.dart';
import 'package:dagather_frontend/utilities/colors.dart';
import 'package:dagather_frontend/utilities/fonts.dart';
import 'package:dagather_frontend/utilities/styles.dart';
import 'package:dagather_frontend/utilities/variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:remedi_kopo/remedi_kopo.dart';
import 'package:geocoding/geocoding.dart';

class ProfileEditScreen extends StatefulWidget {
  UserModel user;

  ProfileEditScreen({
    super.key,
    required this.user,
  });

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  late UserModel _user;
  late TextEditingController _nameTextController;
  late TextEditingController _introductionTextController;

  @override
  void initState() {
    super.initState();
    _user = widget.user;
    _nameTextController = TextEditingController(text: _user.name!);
    _introductionTextController =
        TextEditingController(text: _user.introduction!);
  }

  File? _profileImage;
  List<Location>? locations;
  DateTime? _date;
  GenderType? _gender;

  bool _isMenSelected = false;
  bool _isWomenSelected = false;

  final interestList = interests.map((item) {
    return TagModel(item, false, TagType.interest);
  }).toList();
  final purposeList = purposes.map((item) {
    return TagModel(item, false, TagType.purpose);
  }).toList();

  final ImagePicker picker = ImagePicker();

  List<TagModel> _getListWithSelected(List<TagModel> list) {
    return list.where((element) => element.isSelected).toList();
  }

  int _countSelected(List<TagModel> list) {
    return list.where((element) => element.isSelected).length;
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

  bool _isButtonDisable() {
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar("프로필 수정"),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 16.h),
              Text(
                "이름",
                style: FontStyle.captionTextStyle,
              ),
              SizedBox(height: 8.h),
              TextField(
                onChanged: (value) => setState(() {}),
                controller: _nameTextController,
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
                    initialDate: _date ?? DateTime.now(),
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
                      value: widget.user.region,
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
                          widget.user.region = value;
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
              SizedBox(height: 32.h),
              Text(
                "한국 거주 기간",
                style: FontStyle.captionTextStyle,
              ),
              SizedBox(height: 8.h),
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
                              widget.user.address = model.jibunAddress!;
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
                            widget.user.address!.isEmpty
                                ? '주소를 검색하세요'
                                : widget.user.address!,
                            style: widget.user.address!.isEmpty
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
                              widget.user.address = model.jibunAddress!;
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
              SizedBox(height: 32.h),
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
                controller: _introductionTextController,
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
                text: "다음",
                isDisable: _isButtonDisable(),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const BaseScaffold()),
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
