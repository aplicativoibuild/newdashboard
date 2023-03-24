import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ibuild_dash/controllers/dashboard_controller.dart';
import 'package:ibuild_dash/controllers/user_controller.dart';
import 'package:ibuild_dash/services/auth_service.dart';
import 'package:ibuild_dash/services/partner_service.dart';
import 'package:ibuild_dash/services/user_service.dart';
import 'package:ibuild_dash/views/pages/splash_screen.dart';

import '/constants.dart';
import '/controllers/MenuController.dart' as menu;
import 'utils/string_utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: kIsWeb
          ? const FirebaseOptions(
              apiKey: "AIzaSyAG-LLM0OrcRv08WaJUCj3ZwTQ_Q0wFVbc",
              authDomain: "ibuild-construir-e-reformar.firebaseapp.com",
              databaseURL: "https://ibuild-construir-e-reformar.firebaseio.com",
              projectId: "ibuild-construir-e-reformar",
              storageBucket: "ibuild-construir-e-reformar.appspot.com",
              messagingSenderId: "524581950994",
              appId: "1:524581950994:web:ef412068ad910ce8d12acb",
              measurementId: "G-2YXGQH1CYL")
          : null);
  Get.lazyPut(() => menu.MenuController(), fenix: true);
  runApp(const MyApp());
}

UserService userService = UserService();
AuthService auth = AuthService();
UserController userController = UserController();
PartnerService partnerService = PartnerService();
DashboardController dashboardController = DashboardController();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'iBuild Admin',
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: bgColor,
        textTheme:
            GoogleFonts.beVietnamProTextTheme(Theme.of(context).textTheme),
        canvasColor: secondaryColor,
      ),
      home: const SplashScreen(),
    );
  }
}

extension SearchExt on String {
  bool search(String o) {
    return StringUtils.removerAcentos(toLowerCase())
        .contains(StringUtils.removerAcentos(o.toLowerCase()));
  }
}
