import 'package:flutter/material.dart';

import '/utils/color_utils.dart';

class EmptyPhotoWidget extends StatelessWidget {
  const EmptyPhotoWidget({Key? key, this.width = 40}) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: width,
      decoration: BoxDecoration(
          color: colorGrayLight3, borderRadius: BorderRadius.circular(100)),
      child: const Center(
        child: Icon(
          Icons.photo,
          color: colorGrayDark3,
        ),
      ),
    );
  }
}
