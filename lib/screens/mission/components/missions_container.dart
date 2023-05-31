import 'package:blobs/blobs.dart';
import 'package:dagather_frontend/components/information_dialog.dart';
import 'package:dagather_frontend/components/mission_dialog.dart';
import 'package:dagather_frontend/models/mission_model.dart';
import 'package:dagather_frontend/utilities/colors.dart';
import 'package:dagather_frontend/utilities/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class MissionsContainer extends StatelessWidget {
  final List<MissionModel> list;
  final bool hasTitle;

  const MissionsContainer({
    super.key,
    this.hasTitle = true,
    required this.list,
  });

  @override
  Widget build(BuildContext context) {
    return list.isEmpty
        ? hasTitle
            ? const SizedBox.shrink()
            : Padding(
                padding: EdgeInsets.symmetric(vertical: 32.h),
                child: Center(
                  child: Text(
                    "완료한 미션이 아직 없습니다",
                    style: FontStyle.emptyNotificationTextStyle,
                  ),
                ),
              )
        : Column(
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
                                title: "최근에 달성한 미션이란?",
                                content:
                                    '완료한 모든 미션 중 가장 최근에 달성한 미션 10개까지 볼 수 있습니다.',
                              );
                            });
                      },
                      child: Row(
                        children: [
                          Text(
                            "최근에 달성한 미션",
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
                  children: List.generate(list.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return MissionDialog(
                                content: list[index].mission,
                                date: list[index].completedAt!,
                                id: list[index].id,
                                imgUrl: list[index].friendImgUrl,
                                color: list[index].color,
                                subColor: list[index].subColor,
                              );
                            });
                      },
                      child: Blob.fromID(
                        size: 64.w,
                        id: ["7-4-${list[index].id}"],
                        styles: BlobStyles(
                          color: list[index].color,
                          fillType: BlobFillType.fill,
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ],
          );
  }
}
