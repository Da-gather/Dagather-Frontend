import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dagather_frontend/models/tag_model.dart';
import 'package:dagather_frontend/screens/home/components/user_widget_tag.dart';
import 'package:dagather_frontend/utilities/colors.dart';
import 'package:dagather_frontend/utilities/fonts.dart';
import 'package:dagather_frontend/utilities/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserWidget extends StatelessWidget {
  final String name;
  final String imageUrl;
  final String age;
  final String region;
  final List<TagModel> purposeTags;
  final List<TagModel> interestTags;
  final List<TagModel> tags;

  UserWidget(
      {super.key,
      required this.imageUrl,
      required this.name,
      required this.age,
      required this.purposeTags,
      required this.interestTags,
      required this.region})
      : tags = List.from(purposeTags)..addAll(interestTags);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350.w,
      decoration: BoxDecoration(
        color: AppColor.g100,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
        ).r,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: CachedNetworkImage(
                width: 72.w,
                height: 90.h,
                fit: BoxFit.cover,
                imageUrl: imageUrl,
                placeholder: (context, url) => Container(
                  color: AppColor.g200,
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            SizedBox(
              width: 20.w,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Text(
                        getRegionEmoji(region),
                        style: TextStyle(
                          fontFamily: pretendardFont,
                          fontSize: 12.sp,
                          fontVariations: const [
                            FontVariation('wght', 700),
                          ],
                          color: AppColor.g600,
                        ),
                      ),
                      SizedBox(
                        width: 6.w,
                      ),
                      Text(
                        name,
                        style: TextStyle(
                          fontFamily: pretendardFont,
                          fontSize: 14.sp,
                          fontVariations: const [
                            FontVariation('wght', 700),
                          ],
                          color: AppColor.g800,
                        ),
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      Text(
                        '$age살',
                        style: TextStyle(
                          fontFamily: pretendardFont,
                          fontSize: 12.sp,
                          fontVariations: const [
                            FontVariation('wght', 600),
                          ],
                          color: AppColor.g500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  Container(
                    color: Colors.transparent,
                    child: Wrap(
                      direction: Axis.horizontal,
                      alignment: WrapAlignment.start,
                      spacing: 4.w,
                      runSpacing: 4.h,
                      children: List.generate(
                          tags.length,
                          (index) => UserWidgetTag(
                                type: tags[index].type,
                                text: tags[index].text,
                                changeColor: tags[index].isSelected,
                              )),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
