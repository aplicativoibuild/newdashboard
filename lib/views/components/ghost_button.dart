import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '/utils/color_utils.dart';

class GhostButton extends StatelessWidget {
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

  final String? icon;

  GhostButton(this.text,
      {this.onPressed,
      this.width = double.infinity,
      this.color = colorPrimary,
      this.borderColor = colorPrimary,
      this.disabledColor = colorGrayLight3,
      this.disabledTextColor = colorGrayDark3,
      this.primary = Colors.white,
      this.disabled = false,
      this.icon,
      this.align = MainAxisAlignment.center,
      this.coloredIcon = false,
      this.iconColor = Colors.white,
      this.fontSize = 16,
      this.height = 50});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onPressed != null && !disabled) onPressed!();
      },
      child: Container(
        width: width,
        height: height,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        decoration: BoxDecoration(
            color: disabled ? disabledColor : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
                width: 1, color: disabled ? disabledColor : borderColor)),
        child: Row(
          mainAxisAlignment: align,
          children: [
            if (icon != null)
              SvgPicture.asset(
                icon!,
                color: coloredIcon ? null : iconColor,
                height: height * 0.4,
              ),
            if (icon != null) SizedBox(width: 15),
            Expanded(
              child: Text(text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: disabled ? disabledTextColor : color,
                      fontSize: fontSize,
                      height: 1,
                      fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      ),
    );
  }
}
