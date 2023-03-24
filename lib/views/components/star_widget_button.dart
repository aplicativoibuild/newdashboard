import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '/utils/color_utils.dart';

class StarWidgetButton extends StatefulWidget {
  final int max;
  final Function(int value) onChanged;

  StarWidgetButton(this.max, this.onChanged);

  @override
  _StarWidgetButtonState createState() => _StarWidgetButtonState();
}

class _StarWidgetButtonState extends State<StarWidgetButton> {
  int dificuldade = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> list = [];

    int j = 0;

    for (int i = 0; i < dificuldade; i++) {
      list.add(GestureDetector(
        onTap: () {
          setState(() {
            dificuldade = i + 1;
          });

          widget.onChanged(dificuldade);
        },
        child: SvgPicture.asset(
          "assets/svg/star-filled.svg",
          width: 40,
          color: Colors.orange,
        ),
      ));
    }

    for (int i = 0; i < (widget.max); i++) {
      if (i < dificuldade) continue;
      list.add(GestureDetector(
        onTap: () {
          setState(() {
            dificuldade = i + 1;
          });

          widget.onChanged(dificuldade);
        },
        child: SvgPicture.asset(
          "assets/svg/star-filled.svg",
          width: 40,
          color: colorGrayDark3,
        ),
      ));
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: list,
    );
  }
}
