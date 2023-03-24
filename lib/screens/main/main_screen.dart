import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibuild_dash/main.dart';
import 'package:ibuild_dash/screens/dashboard/components/header.dart';

import '/controllers/MenuController.dart' as menu;
import '/responsive.dart';
import '/screens/dashboard/dashboard_screen.dart';
import 'components/side_menu.dart';

class MainScreen extends StatelessWidget {
  menu.MenuController menuController = Get.find();

  var screens = [
    DashboardScreen(),
    Container(),
    Container(),
    DashboardScreen(),
    DashboardScreen(),
  ];

  MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: menuController.scaffoldKey,
      drawer: const SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              const Expanded(
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: SideMenu(),
              ),
            Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: Obx(() => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Header(
                        title: userController.home.value.title,
                      ),
                      // const SizedBox(height: defaultPadding),
                      Expanded(
                        child: userController.home.value.child,
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
