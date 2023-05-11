import 'dart:ui';

import 'package:dagather_frontend/utilities/colors.dart';
import 'package:dagather_frontend/utilities/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BaseAppBar extends StatelessWidget with PreferredSizeWidget {
  final String appBarTitle;

  BaseAppBar(this.appBarTitle, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 56.h,
      iconTheme: const IconThemeData(
        color: AppColor.g800,
      ),
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      title: Text(
        appBarTitle,
      ),
      titleTextStyle: TextStyle(
        fontFamily: pretendardFont,
        fontSize: 15.sp,
        fontVariations: const [
          FontVariation('wght', 700),
        ],
        color: AppColor.g800,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56.h);
}
