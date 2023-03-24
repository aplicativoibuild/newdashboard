import 'package:flutter/material.dart';

import '/utils/color_utils.dart';

class Badge extends StatelessWidget {
  const Badge(this.txt,
      {Key? key, this.width = 25, this.color = colorAlert, this.fontSize = 14})
      : super(key: key);

  final String txt;
  final double width;
  final Color color;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),
      constraints: BoxConstraints(minWidth: width, minHeight: width),
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(100)),
      child: Center(
        child: Text(
          txt,
          style: TextStyle(color: Colors.white, fontSize: fontSize),
        ),
      ),
    );
  }
}
