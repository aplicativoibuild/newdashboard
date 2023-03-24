import 'package:flutter/material.dart';

import '/utils/color_utils.dart';

class LetterImage extends StatelessWidget {
  const LetterImage(this.name, {Key? key}) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: colorPrimary.withOpacity(0.3)),
      child: Center(
          child: Text(
        name[0],
        style: TextStyle(fontSize: 40, color: colorPrimary),
      )),
    );
  }
}
