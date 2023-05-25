import 'dart:io';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dagather_frontend/components/app_bar.dart';
import 'package:dagather_frontend/components/base_button.dart';
import 'package:dagather_frontend/components/base_tag.dart';
import 'package:dagather_frontend/components/navigation_bar.dart';
import 'package:dagather_frontend/models/tag_model.dart';
import 'package:dagather_frontend/models/user_model.dart';
import 'package:dagather_frontend/services/user_service.dart';
import 'package:dagather_frontend/utilities/colors.dart';
import 'package:dagather_frontend/utilities/fonts.dart';
import 'package:dagather_frontend/utilities/functions.dart';
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
  late TextEditingController _periodTextController;
  late TextEditingController _introductionTextController;

  late List<TagModel> _interestList;
  late List<TagModel> _purposeList;

  late GenderType _gender;
  bool _isMenSelected = false;
  bool _isWomenSelected = false;

  late DateTime _date;
  late String _region;
  late String _address;

  File? _profileImage;
  List<Location>? locations;

  final ImagePicker picker = ImagePicker();

  bool _isButtonDisable() {
    return _nameTextController.text.isEmpty ||
        _periodTextController.text.isEmpty ||
        _introductionTextController.text.isEmpty ||
        _countSelected(_purposeList) == 0 ||
        _countSelected(_interestList) < 5 ||
        _countSelected(_interestList) > 10;
  }

  @override
  void initState() {
    super.initState();
    _user = widget.user;

    // 사용자 이름
    _nameTextController = TextEditingController(text: _user.name!);

    // 자기소개
    _periodTextController =
        TextEditingController(text: _user.period.toString());

    // 자기소개
    _introductionTextController =
        TextEditingController(text: _user.introduction!);

    // 생년월일
    _date = _user.birth!;

    // 국적
    _region = _user.region!;

    // 거주지
    _address = _user.address!;

    // 관심사
    _interestList = interests.map((item) {
      if (_user.interestTags!.map((element) => element.text).contains(item)) {
        return TagModel(item, true, TagType.interest);
      }
      return TagModel(item, false, TagType.interest);
    }).toList();

    //가입 목적
    _purposeList = purposes.map((item) {
      if (_user.purposeTags!.map((element) => element.text).contains(item)) {
        return TagModel(item, true, TagType.purpose);
      }
      return TagModel(item, false, TagType.purpose);
    }).toList();

    // 성별
    if (_user.gender!) {
      _isWomenSelected = true;
      _gender = GenderType.woman;
    } else {
      _isMenSelected = true;
      _gender = GenderType.man;
    }
  }

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

  void _setAddress() async {
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
                    initialDate: _date,
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
                          DateFormat('yyyy.MM.dd').format(_date),
                          style: FontStyle.inputTextStyle,
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
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(10.r),
                        child: CachedNetworkImage(
                          height: 300.h,
                          fit: BoxFit.cover,
                          imageUrl: _user.imgUrl!,
                          placeholder: (context, url) => Container(
                            color: AppColor.g200,
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
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
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (value) => setState(() {}),
                      controller: _periodTextController,
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
                      onTap: _setAddress,
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColor.g100,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 20.h),
                          child: Text(
                            _address,
                            style: FontStyle.inputTextStyle,
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
                      onPressed: _setAddress,
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
                      _purposeList.length,
                      (index) => GestureDetector(
                            onTap: () {
                              HapticFeedback.lightImpact();
                              _purposeList[index].isSelected =
                                  !_purposeList[index].isSelected;
                              setState(() {});
                            },
                            child: BaseTag(
                              type: _purposeList[index].type,
                              text: _purposeList[index].text,
                              changeColor: _purposeList[index].isSelected,
                            ),
                          )),
                ),
              ),
              SizedBox(height: 32.h),
              Text(
                "관심사(최소 5개, 최대 10개)",
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
                      _interestList.length,
                      (index) => GestureDetector(
                            onTap: () {
                              if (!_interestList[index].isSelected &&
                                  _countSelected(_interestList) >= 10) {
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
                              _interestList[index].isSelected =
                                  !_interestList[index].isSelected;
                              setState(() {});
                            },
                            child: BaseTag(
                              type: _interestList[index].type,
                              text: _interestList[index].text,
                              changeColor: _interestList[index].isSelected,
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
                text: "수정하기",
                isDisable: _isButtonDisable(),
                onPressed: () async {
                  if (_profileImage != null) {
                    final String newImgUrl =
                        await UserService.getImageUrlBy(_profileImage!.path);
                    widget.user.imgUrl = newImgUrl;
                  }

                  widget.user.name = _nameTextController.text;
                  widget.user.gender = getGenderBool(_gender);
                  widget.user.birth = _date;
                  widget.user.region = _region;
                  widget.user.period = int.parse(_periodTextController.text);
                  widget.user.address = _address;
                  widget.user.purposeTags = _getListWithSelected(_purposeList);
                  widget.user.interestTags =
                      _getListWithSelected(_interestList);
                  widget.user.introduction = _introductionTextController.text;

                  await UserService.putUser(widget.user);
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('프로필 정보를 변경했습니다'),
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
