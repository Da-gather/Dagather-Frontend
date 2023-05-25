import 'dart:ui';

import 'package:dagather_frontend/utilities/colors.dart';
import 'package:dagather_frontend/utilities/fonts.dart';
import 'package:dagather_frontend/utilities/variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

typedef FilteringCallback = void Function(String filter);

class FilterDialog extends StatefulWidget {
  final FilteringCallback onPressed;

  const FilterDialog({super.key, required this.onPressed});

  @override
  State<FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  String _filter = ProfileFilterType.basic.name;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.r)),
      ),
      insetPadding: EdgeInsets.symmetric(horizontal: 50.w),
      contentPadding:
          EdgeInsets.only(right: 20.w, left: 20.w, top: 12.h, bottom: 24.h),
      title: const Text('친구 추천 우선 기준'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Radio(
                  value: ProfileFilterType.basic.name,
                  groupValue: _filter,
                  activeColor: AppColor.yellow4,
                  onChanged: (value) {
                    _filter = value!;
                    setState(() {});
                  }),
              Text(
                '기본 추천',
                style: TextStyle(
                  fontFamily: pretendardFont,
                  fontSize: 15.sp,
                  height: 1.55,
                  fontVariations: const [
                    FontVariation('wght', 600),
                  ],
                  color: AppColor.g900,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Radio(
                  value: ProfileFilterType.nation.name,
                  groupValue: _filter,
                  activeColor: AppColor.yellow4,
                  onChanged: (value) {
                    _filter = value!;
                    setState(() {});
                  }),
              Text(
                '같은 국적의 사람',
                style: TextStyle(
                  fontFamily: pretendardFont,
                  fontSize: 15.sp,
                  height: 1.55,
                  fontVariations: const [
                    FontVariation('wght', 600),
                  ],
                  color: AppColor.g900,
                ),
              ),
            ],
          ),
        ],
      ),
      titleTextStyle: TextStyle(
        fontFamily: pretendardFont,
        fontSize: 15.sp,
        fontVariations: const [
          FontVariation('wght', 700),
        ],
        color: AppColor.g900,
      ),
      actionsPadding: EdgeInsets.only(right: 12.w, left: 12.w, bottom: 12.h),
      actions: [
        Row(
          children: [
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: TextButton.styleFrom(
                  backgroundColor: AppColor.g200,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8).r,
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 14.h,
                  ),
                ),
                child: Text(
                  "취소",
                  style: TextStyle(
                    fontFamily: pretendardFont,
                    fontSize: 13.sp,
                    fontVariations: const [
                      FontVariation('wght', 700),
                    ],
                    color: AppColor.g700,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 8.w,
            ),
            Flexible(
              flex: 2,
              fit: FlexFit.tight,
              child: TextButton(
                onPressed: () => widget.onPressed(_filter),
                style: TextButton.styleFrom(
                  backgroundColor: AppColor.yellow4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8).r,
                  ),
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                ),
                child: Text(
                  '적용',
                  style: TextStyle(
                    fontFamily: pretendardFont,
                    fontSize: 13.sp,
                    fontVariations: const [
                      FontVariation('wght', 700),
                    ],
                    color: AppColor.g900,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
