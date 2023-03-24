import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ibuild_dash/main.dart';
import 'package:ibuild_dash/utils/color_utils.dart';
import 'package:ibuild_dash/utils/dialog_utils.dart';
import 'package:ibuild_dash/views/components/header_text.dart';

import '/controllers/MenuController.dart' as menu;
import '/responsive.dart';
import '../../../constants.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
    this.title = "",
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        children: [
          if (!Responsive.isDesktop(context))
            IconButton(
              icon: const Icon(
                Icons.menu,
                color: colorBlack,
              ),
              onPressed: () {
                Get.find<menu.MenuController>().controlMenu();
              },
            ),
          if (!Responsive.isMobile(context))
            Expanded(
              child: HeaderText(
                title,
                align: TextAlign.start,
              ),
            ),
          const Spacer(),
          const ProfileCard()
        ],
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (d) {
        DialogUtils.modalSelect(d, [
          ModalAction('Editar perfil', onTap: () => DialogUtils.showEmBreve()),
          ModalAction('Sair', onTap: () async {
            await auth.logout();
            // Get.offAll(() => const LoginScreen());
          }, color: Colors.red),
        ]);
      },
      child: Container(
        margin: const EdgeInsets.only(left: defaultPadding),
        padding: const EdgeInsets.symmetric(
          horizontal: defaultPadding,
          vertical: defaultPadding / 2,
        ),
        decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: Colors.white10),
        ),
        child: Row(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
              child: Text(userController.adm.name.split(" ").first),
            ),
            const Icon(Icons.keyboard_arrow_down),
          ],
        ),
      ),
    );
  }
}

class SearchField extends StatefulWidget {
  const SearchField({Key? key, required this.onChanged}) : super(key: key);

  final Function(String) onChanged;

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: colorWhite, borderRadius: BorderRadius.circular(8)),
      child: TextField(
        controller: controller,
        onChanged: (txt) {
          widget.onChanged(txt);
          setState(() {});
        },
        decoration: InputDecoration(
          hintText: "Buscar",
          fillColor: secondaryColor,
          // filled: true,
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          suffixIcon: InkWell(
            onTap: () {
              controller.clear();
              widget.onChanged('');
              setState(() {});
            },
            child: Container(
              width: 40,
              height: 40,
              margin:
                  const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
              decoration: const BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Center(
                child: controller.text.isNotEmpty
                    ? const Icon(
                        Icons.close,
                        color: colorWhite,
                        size: 16,
                      )
                    : SvgPicture.asset("assets/icons/Search.svg"),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
