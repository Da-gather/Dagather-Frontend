import 'package:blobs/blobs.dart';
import 'package:dagather_frontend/components/information_dialog.dart';
import 'package:dagather_frontend/components/mission_dialog.dart';
import 'package:dagather_frontend/utilities/colors.dart';
import 'package:dagather_frontend/utilities/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class MissionsContainer extends StatelessWidget {
  final bool hasTitle;

  const MissionsContainer({
    super.key,
    this.hasTitle = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (hasTitle)
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const InformationDialog(
                          title: "최근에 달성한 미션 10개란?",
                          content: '완료한 모든 미션 중 가장 최근에 달성한 미션 10개까지 볼 수 있습니다.',
                        );
                      });
                },
                child: Row(
                  children: [
                    Text(
                      "최근에 달성한 미션 10개",
                      style: FontStyle.captionTextStyle,
                    ),
                    SizedBox(
                      width: 4.w,
                    ),
                    SvgPicture.asset(
                      'assets/icons/ic_help_center.svg',
                      width: 16.w,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 8.h,
              ),
            ],
          ),
        Container(
          decoration: BoxDecoration(
            color: AppColor.g100,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: GridView(
            physics: const ClampingScrollPhysics(),
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
              vertical: 20.h,
            ),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              crossAxisSpacing: 8.h,
              mainAxisSpacing: 16.h,
            ),
            children: [
              GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const MissionDialog();
                      });
                },
                child: Blob.fromID(
                  size: 64.w,
                  id: const ["7-4-1234"],
                  styles: BlobStyles(
                    color: AppColor.green,
                    fillType: BlobFillType.fill,
                  ),
                ),
              ),
              Blob.fromID(
                size: 64.w,
                id: const ["7-4-1235"],
                styles: BlobStyles(
                  color: AppColor.red,
                  fillType: BlobFillType.fill,
                ),
              ),
              Blob.fromID(
                size: 64.w,
                id: const ["7-4-1236"],
                styles: BlobStyles(
                  color: AppColor.yellow4,
                  fillType: BlobFillType.fill,
                ),
              ),
              Blob.fromID(
                size: 64.w,
                id: const ["7-4-1237"],
                styles: BlobStyles(
                  color: AppColor.red,
                  fillType: BlobFillType.fill,
                ),
              ),
              Blob.fromID(
                size: 64.w,
                id: const ["7-4-1238"],
                styles: BlobStyles(
                  color: AppColor.blue,
                  fillType: BlobFillType.fill,
                ),
              ),
              Blob.fromID(
                size: 64.w,
                id: const ["7-4-1239"],
                styles: BlobStyles(
                  color: AppColor.yellow4,
                  fillType: BlobFillType.fill,
                ),
              ),
              Blob.fromID(
                size: 64.w,
                id: const ["7-4-1240"],
                styles: BlobStyles(
                  color: AppColor.green,
                  fillType: BlobFillType.fill,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
