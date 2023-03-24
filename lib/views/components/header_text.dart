import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '/utils/color_utils.dart';

class HeaderText extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;
  final double padding;
  final TextAlign align;
  final int? maxLines;
  final bool autosize;

  const HeaderText(this.text,
      {this.color = colorBlack,
      this.fontSize = 16,
      this.fontWeight = FontWeight.w700,
      this.padding = 0,
      this.maxLines,
      this.autosize = false,
      this.align = TextAlign.center});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: autosize
          ? AutoSizeText(
              text,
              textAlign: align,
              maxLines: maxLines,
              style: TextStyle(
                color: color,
                fontWeight: fontWeight,
                fontSize: fontSize,
              ),
            )
          : Text(
              text,
              textAlign: align,
              maxLines: maxLines,
              overflow: maxLines != null ? TextOverflow.ellipsis : null,
              style: TextStyle(
                  color: color, fontWeight: fontWeight, fontSize: fontSize),
            ),
    );
  }
}
