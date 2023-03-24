import 'package:flutter/material.dart';

import '/utils/color_utils.dart';
import '/views/components/body_text.dart';

class ColumnText extends StatelessWidget {
  const ColumnText(this.title, this.body,
      {Key? key, this.titleColor = colorGrayDark1, this.bodyColor = colorBlack})
      : super(key: key);

  final String title;
  final String body;

  final Color titleColor;
  final Color bodyColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BodyText(
          title,
          fontSize: 14,
          color: titleColor,
        ),
        const SizedBox(height: 5),
        SelectableText(
          body,
          style: TextStyle(
            color: bodyColor,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        )
      ],
    );
  }
}
