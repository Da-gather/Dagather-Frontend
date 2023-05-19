import 'package:cached_network_image/cached_network_image.dart';
import 'package:dagather_frontend/utilities/colors.dart';
import 'package:flutter/material.dart';

class ImageViewerScreen extends StatelessWidget {
  final String url;
  const ImageViewerScreen({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.g900,
      body: Center(
        child: InteractiveViewer(
          child: CachedNetworkImage(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
            imageUrl: url,
            placeholder: (context, url) => Container(
              color: AppColor.g200,
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
      ),
    );
  }
}
