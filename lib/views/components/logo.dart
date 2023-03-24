import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo(
      {Key? key,
      this.text = false,
      this.white = true,
      this.width = double.infinity})
      : super(key: key);

  final bool text;
  final bool white;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: text
          ? Image.asset(
              "assets/images/${white ? "logo" : "logo"}.png",
              width: width,
            )
          : Image.asset(
              "assets/images/${white ? "simbolo" : "simbolo"}.png",
              width: width,
            ),
    );
  }
}
