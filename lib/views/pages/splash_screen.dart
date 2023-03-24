import 'package:flutter/material.dart';
import 'package:ibuild_dash/main.dart';
import 'package:ibuild_dash/utils/color_utils.dart';
import 'package:ibuild_dash/views/components/progress.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    auth.init();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: colorWhite,
      body: MyProgress(),
    );
  }
}
