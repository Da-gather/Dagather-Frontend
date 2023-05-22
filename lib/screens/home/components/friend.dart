import 'package:cached_network_image/cached_network_image.dart';
import 'package:dagather_frontend/components/base_small_button.dart';
import 'package:dagather_frontend/utilities/colors.dart';
import 'package:dagather_frontend/utilities/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Friend extends StatelessWidget {
  final String imageUrl;
  final String name;
  final void Function() imgOnTapped;
  final void Function() cancelBtnOnTapped;

  const Friend({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.imgOnTapped,
    required this.cancelBtnOnTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12).h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: imgOnTapped,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: CachedNetworkImage(
                    width: 44.w,
                    height: 44.w,
                    fit: BoxFit.cover,
                    imageUrl: imageUrl,
                    placeholder: (context, url) => Container(
                      color: AppColor.g200,
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
              SizedBox(
                width: 12.w,
              ),
              Text(
                name,
                style: FontStyle.friendRequestTextStyle,
              ),
            ],
          ),
          BaseSmallButton(
            textColor: AppColor.g100,
            backgroundColor: AppColor.red,
            onPressed: cancelBtnOnTapped,
            text: "친구 삭제",
          ),
        ],
      ),
    );
  }
}
