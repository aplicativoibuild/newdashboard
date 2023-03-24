import 'dart:io';

import 'package:flutter/material.dart';

class PhotoFile extends StatelessWidget {
  final File asset;
  final bool network;
  final double width;
  final double? height;
  final double radius;
  final BoxFit fit;
  final bool firebase;

  const PhotoFile(this.asset,
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
        child: Image.file(
          asset,
          width: width,
          height: height,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
