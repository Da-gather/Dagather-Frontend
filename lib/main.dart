import 'package:dagather_frontend/components/navigation_bar.dart';
import 'package:dagather_frontend/utilities/colors.dart';
import 'package:dagather_frontend/utilities/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Da:gather',
          theme: ThemeData(
            fontFamily: pretendardFont,
            primaryColor: AppColor.yellow4,
            primaryColorLight: AppColor.yellow2,
            scaffoldBackgroundColor: Colors.white,
            dividerColor: Colors.transparent,
          ),
          builder: (context, widget) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: widget!,
            );
          },
          home: child,
        );
      },
      child: const BaseScaffold(),
    );
  }
}
