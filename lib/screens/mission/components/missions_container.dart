import 'package:blobs/blobs.dart';
import 'package:dagather_frontend/components/mission_dialog.dart';
import 'package:dagather_frontend/utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MissionsContainer extends StatelessWidget {
  const MissionsContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
