import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '/utils/color_utils.dart';

class WRichItem {
  String text;
  Function? onTap;
  Color color;

  WRichItem(this.text, {this.onTap, this.color = colorGrayDark2});
}

class WRichText extends StatelessWidget {
  const WRichText(this.list,
      {Key? key, this.fontSize = 16, this.align = TextAlign.center})
      : super(key: key);

  final List<WRichItem> list;
  final double fontSize;
  final TextAlign align;

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: align,
      text: TextSpan(
          children: list.map((e) {
        return TextSpan(
            text: e.text,
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                if (e.onTap != null) e.onTap!();
              },
            style: TextStyle(
                color: e.color,
                fontSize: fontSize,
                fontWeight:
                    e.onTap != null ? FontWeight.bold : FontWeight.normal));
      }).toList()),
    );
  }
}
