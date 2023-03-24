import 'package:flutter/material.dart';
import 'package:ibuild_dash/utils/color_utils.dart';

class PhotoRound extends StatelessWidget {
  final String asset;
  final bool network;
  final double width;
  final double? height;
  final double radius;
  final BoxFit fit;
  final bool firebase;

  const PhotoRound(this.asset,
      {this.network = false,
      this.width = 40,
      this.height,
      this.firebase = false,
      this.fit = BoxFit.cover,
      this.radius = 8});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: asset.isEmpty
            ? Container(
                width: width,
                height: width,
                decoration: BoxDecoration(
                    color: colorGrayLight3,
                    borderRadius: BorderRadius.circular(radius)),
                child: const Center(
                  child: Icon(
                    Icons.photo,
                    color: colorBlack,
                    size: 16,
                  ),
                ),
              )
            : network
                ? Image.network(
                    asset.contains('http') ? asset : asset,
                    width: fit == BoxFit.fitHeight ? null : width,
                    height: height ?? width,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    asset,
                    width: width,
                    height: height,
                    fit: BoxFit.cover,
                  ),
      ),
    );
  }
}
