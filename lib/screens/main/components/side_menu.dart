import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ibuild_dash/controllers/MenuController.dart' as menu;
import 'package:ibuild_dash/main.dart';
import 'package:ibuild_dash/models/main_route.dart';
import 'package:ibuild_dash/screens/dashboard/dashboard_screen.dart';
import 'package:ibuild_dash/utils/color_utils.dart';
import 'package:ibuild_dash/views/components/body_text.dart';
import 'package:ibuild_dash/views/components/header_text.dart';
import 'package:ibuild_dash/views/components/logo.dart';
import 'package:ibuild_dash/views/pages/comentarios_screen.dart';
import 'package:ibuild_dash/views/pages/parceiros_ativos_screen.dart';
import 'package:ibuild_dash/views/pages/parceiros_modify_screen.dart';
import 'package:ibuild_dash/views/pages/parceiros_novos_screen.dart';
import 'package:ibuild_dash/views/pages/usuarios_screen.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Logo(
                  width: 120,
                  text: true,
                ),
                const SizedBox(height: 20),
                const HeaderText(
                  'Painel administrativo',
                  color: colorBlack,
                  fontSize: 16,
                  align: TextAlign.start,
                ),
                const SizedBox(height: 10),
                BodyText(
                  'Olá, ${userController.adm.name}',
                  color: colorGrayDark3,
                ),
              ],
            ),
          ),
          DrawerListTile(
            title: "Dashboard",
            svgSrc: "assets/icons/menu_dashbord.svg",
            route: () => MainRoute('Dashboard', DashboardScreen()),
          ),
          DrawerListTile(
            title: "Parceiros",
            svgSrc: "assets/icons/menu_profile.svg",
            route: () => MainRoute('Dashboard', Container()),
            children: [
              DrawerListTile(
                title: "Ativos",
                svgSrc: "",
                route: () => MainRoute(
                    'Parceiros ativos', const ParceirosAtivosScreen()),
              ),
              DrawerListTile(
                title: "Novos",
                svgSrc: "",
                route: () =>
                    MainRoute('Novos parceiros', const ParceirosNovosScreen()),
              ),
              DrawerListTile(
                title: "Alteração",
                svgSrc: "",
                route: () => MainRoute(
                    'Alterações em parceiros', const ParceirosModifyScreen()),
              ),
              DrawerListTile(
                title: "Comentários",
                svgSrc: "",
                route: () => MainRoute(
                    'Aprovação de comentários', const ComentariosScreen()),
              ),
            ],
          ),
          DrawerListTile(
            title: "Orçamentos",
            svgSrc: "assets/icons/menu_doc.svg",
            route: () => MainRoute('Dashboard', Container()),
          ),
          DrawerListTile(
            title: "Usuários",
            svgSrc: "assets/icons/menu_profile.svg",
            route: () => MainRoute('Usuários', const UsuariosScreen()),
          ),
          DrawerListTile(
            title: "Configurações",
            svgSrc: "assets/icons/menu_setting.svg",
            route: () => MainRoute('Dashboard', Container()),
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile(
      {Key? key,
      // For selecting those three line once press "Command+D"
      required this.title,
      required this.svgSrc,
      required this.route,
      this.children = const []})
      : super(key: key);

  final String title, svgSrc;
  final MainRoute Function() route;
  final List<DrawerListTile> children;

  @override
  Widget build(BuildContext context) {
    return children.isEmpty
        ? buildTile(this)
        : ExpansionTile(
            title: Row(
              children: [
                SvgPicture.asset(
                  svgSrc,
                  color: colorBlack,
                  height: 16,
                ),
                const SizedBox(width: 25),
                Text(
                  title,
                  style: const TextStyle(color: colorBlack),
                ),
              ],
            ),
            children: children.map((e) => buildTile(e)).toList());
  }

  Widget buildTile(DrawerListTile e) {
    return Obx(() => ListTile(
          tileColor: userController.homePage.value == e.title
              ? colorPrimary.withOpacity(0.1)
              : null,
          onTap: () {
            Get.find<menu.MenuController>().controlMenu();
            userController.homePage.value = e.title;
            userController.home.value = e.route();
          },
          horizontalTitleGap: 0.0,
          leading: SvgPicture.asset(
            e.svgSrc,
            color: colorBlack,
            height: 16,
          ),
          title: Text(
            e.title,
            style: const TextStyle(color: colorBlack),
          ),
        ));
  }
}
