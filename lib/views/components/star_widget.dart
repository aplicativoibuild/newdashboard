import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '/utils/color_utils.dart';

class StarWidget extends StatelessWidget {
  final int dificuldade;
  final int max;
  final MainAxisAlignment align;

  const StarWidget(this.dificuldade, this.max,
      {this.align = MainAxisAlignment.start});

  @override
  Widget build(BuildContext context) {
    List<Widget> list = [];

    int i;

    for (i = 0; i < dificuldade; i++) {
      list.add(Padding(
        padding: const EdgeInsets.all(0.0),
        child: SvgPicture.asset(
          "assets/svg/star-filled.svg",
          width: 25,
          color: Colors.amber,
        ),
      ));
    }

    for (i = 0; i < (max - dificuldade); i++) {
      list.add(Padding(
        padding: const EdgeInsets.all(0.0),
        child: SvgPicture.asset(
          "assets/svg/star-filled.svg",
          width: 25,
          color: colorGrayLight3,
        ),
      ));
    }
    return Row(
      mainAxisAlignment: align,
      children: list,
    );
  }
}
