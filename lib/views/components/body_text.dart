import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '/utils/color_utils.dart';

class BodyText extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;
  final double padding;
  final TextAlign textAlign;
  final int? maxLines;
  final TextDecoration textDecoration;
  final bool autosize;

  const BodyText(this.text,
      {this.color = colorGrayDark2,
      this.fontSize = 16,
      this.maxLines,
      this.autosize = false,
      this.textDecoration = TextDecoration.none,
      this.fontWeight = FontWeight.w400,
      this.padding = 0,
      this.textAlign = TextAlign.start});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: autosize
          ? AutoSizeText(
              text,
              textAlign: textAlign,
              maxLines: maxLines,
              style: TextStyle(
                color: color,
                fontWeight: fontWeight,
                fontSize: fontSize,
              ),
            )
          : Text(
              text,
              maxLines: maxLines,
              overflow: maxLines != null ? TextOverflow.ellipsis : null,
              textAlign: textAlign,
              style: TextStyle(
                  fontWeight: fontWeight,
                  fontSize: fontSize,
                  color: color,
                  decoration: textDecoration),
            ),
    );
  }
}
