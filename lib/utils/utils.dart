import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '/utils/color_utils.dart';
import '/views/components/body_text.dart';

class Utils {
  static AppBar appBar(String txt, {List<Widget> actions = const []}) {
    return AppBar(
      title: BodyText(
        txt,
        color: colorBlack,
        fontWeight: FontWeight.bold,
      ),
      centerTitle: true,
      leading: InkWell(
        onTap: () {
          Get.back();
        },
        child: Center(
          child: SvgPicture.asset(
            'assets/svg/left.svg',
            width: 25,
            color: colorGrayDark1,
          ),
        ),
      ),
      iconTheme: IconThemeData(color: colorBlack),
      elevation: 1,
      actions: actions,
      backgroundColor: colorWhite,
    );
  }
}
