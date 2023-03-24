import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ibuild_dash/constants.dart';
import 'package:ibuild_dash/utils/color_utils.dart';
import 'package:ibuild_dash/views/components/header_text.dart';

class CardHomeResumo extends StatelessWidget {
  const CardHomeResumo(
      {Key? key,
      required this.title,
      required this.value,
      required this.asset,
      this.onTap})
      : super(key: key);

  final String title;
  final String value;
  final String asset;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(defaultPadding),
        decoration: const BoxDecoration(
          color: secondaryColor,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              asset,
              width: 50,
              color: colorGrayDark2,
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeaderText(
                    title,
                    fontSize: 16,
                    maxLines: 1,
                    align: TextAlign.start,
                    autosize: true,
                  ),
                  const Spacer(),
                  HeaderText(
                    value,
                    fontSize: 25,
                    color: colorPrimary,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
