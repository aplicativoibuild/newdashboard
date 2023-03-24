import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibuild_dash/main.dart';
import 'package:ibuild_dash/models/main_route.dart';
import 'package:ibuild_dash/views/components/progress.dart';
import 'package:ibuild_dash/views/pages/parceiros_ativos_screen.dart';
import 'package:ibuild_dash/views/pages/parceiros_modify_screen.dart';
import 'package:ibuild_dash/views/pages/parceiros_novos_screen.dart';
import 'package:ibuild_dash/views/widgets/card_home_resumo.dart';

import '/responsive.dart';
import '../../constants.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    if (dashboardController.stream == null) dashboardController.init();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Obx(() => dashboardController.loading.value
          ? const MyProgress()
          : SingleChildScrollView(
              primary: false,
              padding: const EdgeInsets.all(defaultPadding),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 5,
                        child: Column(
                          children: [
                            GridView(
                              shrinkWrap: true,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: size.width < 650 ? 2 : 4,
                                crossAxisSpacing: defaultPadding,
                                mainAxisExtent: 90,
                                mainAxisSpacing: defaultPadding,
                                childAspectRatio: Responsive.isMobile(context)
                                    ? size.width < 650 && size.width > 350
                                        ? 1.3
                                        : 1
                                    : size.width < 1400
                                        ? 1.1
                                        : 1.4,
                              ),
                              children: [
                                CardHomeResumo(
                                    title: 'Parceiros',
                                    value: dashboardController.partnersCount
                                        .toString(),
                                    onTap: () {
                                      userController.homePage.value = 'Ativos';
                                      userController.home.value = MainRoute(
                                          'Parceiros ativos',
                                          const ParceirosAtivosScreen());
                                    },
                                    asset: 'assets/svg/profissoes/17.svg'),
                                CardHomeResumo(
                                    title: 'Novos parceiros',
                                    value: dashboardController.partnersNew
                                        .toString(),
                                    onTap: () {
                                      userController.homePage.value = 'Novos';
                                      userController.home.value = MainRoute(
                                          'Novos parceiros',
                                          const ParceirosNovosScreen());
                                    },
                                    asset: 'assets/svg/user.svg'),
                                CardHomeResumo(
                                    title: 'Alterações de parceiros',
                                    value: dashboardController.partnersModify
                                        .toString(),
                                    onTap: () {
                                      userController.homePage.value =
                                          'Alteração';
                                      userController.home.value = MainRoute(
                                          'Alterações em parceiros',
                                          const ParceirosModifyScreen());
                                    },
                                    asset: 'assets/svg/partner.svg'),
                              ],
                            ),
                            if (Responsive.isMobile(context))
                              const SizedBox(height: defaultPadding),
                          ],
                        ),
                      ),
                      if (!Responsive.isMobile(context))
                        const SizedBox(width: defaultPadding),
                      // On Mobile means if the screen is less than 850 we dont want to show it
                      if (!Responsive.isMobile(context))
                        Expanded(
                          flex: 2,
                          child: Container(),
                        ),
                    ],
                  )
                ],
              ),
            )),
    );
  }
}
