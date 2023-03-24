import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/utils/color_utils.dart';
import '/views/components/body_text.dart';
import '/views/components/header_text.dart';

class ModalSelect extends StatelessWidget {
  const ModalSelect(
      {Key? key,
      required this.list,
      required this.onSelect,
      required this.title,
      this.icons})
      : super(key: key);

  final String title;
  final List<Enum> list;
  final List<String>? icons;
  final Function(Enum) onSelect;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Wrap(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 80,
                height: 6,
                decoration: BoxDecoration(
                    color: colorGrayLight2,
                    borderRadius: BorderRadius.circular(50)),
              ),
              if (title.isNotEmpty) const SizedBox(height: 10),
              if (title.isNotEmpty)
                HeaderText(
                  title,
                  color: colorGrayDark2,
                  align: TextAlign.center,
                ),
              const SizedBox(height: 10),
              Column(
                  children: list.map((e) {
                Enum cat = e;
                return ListTile(
                  leading: icons == null
                      ? null
                      : Image.network(
                          icons![list.indexOf(e)],
                          width: 30,
                        ),
                  title: BodyText(cat.displayName,
                      color: cat.displayName == 'Cancelar'
                          ? Colors.red
                          : colorGrayDark2,
                      textAlign: TextAlign.center),
                  onTap: () {
                    Get.back();
                    cat.onTap();
                  },
                );
              }).toList()),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ],
    );
  }
}

class Enum {
  late int id;
  late String displayName;
  late Function onTap;

  Enum(this.id, this.displayName, this.onTap);
}
