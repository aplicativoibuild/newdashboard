import 'package:flutter/material.dart';

import '/utils/color_utils.dart';

class WTextButton extends StatelessWidget {
  final String text;
  final double width;
  final double height;
  final double fontSize;
  final Function? onPressed;
  final Color color;
  final Color primary;
  final Color borderColor;
  final Color disabledColor;
  final Color disabledTextColor;
  final Color iconColor;
  final bool coloredIcon;
  final MainAxisAlignment align;
  final bool disabled;
  final FontWeight fontWeight;

  final String? icon;

  WTextButton(this.text,
      {this.onPressed,
      this.width = double.infinity,
      this.color = colorPrimary,
      this.borderColor = colorPrimary,
      this.disabledColor = colorGrayDark2,
      this.disabledTextColor = colorGrayLight3,
      this.primary = Colors.white,
      this.disabled = false,
      this.icon,
      this.align = MainAxisAlignment.center,
      this.coloredIcon = false,
      this.fontWeight = FontWeight.w600,
      this.iconColor = Colors.white,
      this.fontSize = 14,
      this.height = 50});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onPressed != null && !disabled) onPressed!();
      },
      child: Text(text,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: disabled ? disabledTextColor : color,
              fontSize: fontSize,
              height: 1,
              fontWeight: fontWeight)),
    );
  }
}
