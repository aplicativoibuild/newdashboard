import 'package:flutter/material.dart';

import '/utils/color_utils.dart';

class MyProgress extends StatelessWidget {
  const MyProgress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 50,
        child: Center(
          child: CircularProgressIndicator(
            color: colorPrimary,
          ),
        ),
      ),
    );
  }
}
