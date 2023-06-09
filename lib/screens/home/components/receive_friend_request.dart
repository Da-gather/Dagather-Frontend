import 'package:cached_network_image/cached_network_image.dart';
import 'package:dagather_frontend/components/base_small_button.dart';
import 'package:dagather_frontend/utilities/colors.dart';
import 'package:dagather_frontend/utilities/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReceiveFriendRequest extends StatelessWidget {
  final String name;
  final String imageUrl;
  final void Function() imgOnTapped;
  final void Function() refuseButtonOnTapped;
  final void Function() approveButtonOnTapped;

  const ReceiveFriendRequest({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.imgOnTapped,
    required this.refuseButtonOnTapped,
    required this.approveButtonOnTapped,
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
          Row(
            children: [
              BaseSmallButton(
                textColor: AppColor.g100,
                backgroundColor: AppColor.g300,
                onPressed: refuseButtonOnTapped,
                text: "거절",
              ),
              SizedBox(
                width: 4.w,
              ),
              BaseSmallButton(
                textColor: AppColor.greenLight,
                backgroundColor: AppColor.green,
                onPressed: approveButtonOnTapped,
                text: "수락",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
