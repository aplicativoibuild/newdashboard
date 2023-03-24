import 'package:contextmenu/contextmenu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibuild_dash/responsive.dart';

import '/utils/color_utils.dart';
import '/views/components/body_text.dart';
import '/views/components/ghost_button.dart';
import '/views/components/header_text.dart';
import '/views/components/primary_button.dart';
import '/views/components/textformfield/custom_text_field.dart';

class ModalAction {
  late String title;
  Function? onTap;
  Color color;

  ModalAction(this.title, {this.onTap, this.color = colorGrayDark1});
}

class DialogUtils {
  static Future modalSelectWeb(TapDownDetails d, List<ModalAction> list,
      {double width = 200}) async {
    showContextMenu(
        d.globalPosition,
        Get.context!,
        (context) => list
            .map((e) => ListTile(
                onTap: () {
                  Get.back();
                  if (e.onTap != null) e.onTap!();
                },
                title: BodyText(e.title,
                    textAlign: TextAlign.start, fontSize: 14, color: e.color)))
            .toList(),
        16.0,
        width);
  }

  static Future modalSelect(TapDownDetails d, List<ModalAction> list) async {
    if (!Responsive.isMobile(Get.context!)) {
      modalSelectWeb(d, list);
      return;
    }
    await Get.bottomSheet(
        Wrap(
          children: [
            Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(16))),
              padding: const EdgeInsets.all(16),
              child: Column(
                children: list
                    .map((e) => Container(
                          decoration: BoxDecoration(
                              border: list.last == e
                                  ? null
                                  : const Border(
                                      bottom: BorderSide(
                                          color: colorGrayLight3, width: 0.5))),
                          child: ListTile(
                            onTap: () {
                              Get.back();
                              if (e.onTap != null) e.onTap!();
                            },
                            title: BodyText(
                              e.title,
                              color: e.color,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ))
                    .toList(),
              ),
            )
          ],
        ),
        isScrollControlled: true,
        backgroundColor: Colors.transparent);
  }

  static Future<bool> confirmDestaque(
      String first, String destaque, String last) async {
    bool res = false;

    await showDialog(
        context: Get.context!,
        builder: (context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            child: Container(
              width: 300,
              height: 200,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BodyText(
                    first,
                    padding: 8,
                    textAlign: TextAlign.center,
                  ),
                  HeaderText(
                    destaque,
                    fontSize: 18,
                  ),
                  BodyText(
                    last,
                    padding: 8,
                    textAlign: TextAlign.center,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GhostButton(
                        "Cancelar",
                        width: 120,
                        onPressed: () {
                          res = false;
                          Get.back();
                        },
                      ),
                      PrimaryButton(
                        "Sim",
                        width: 120,
                        onPressed: () {
                          res = true;
                          Get.back();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });

    return res;
  }

  static Future<bool> confirmDelete(
      BuildContext context, String title, String body) async {
    bool res = false;

    await showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            child: Container(
              width: 300,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  HeaderText(
                    title,
                    fontSize: 20,
                  ),
                  BodyText(
                    body,
                    padding: 8,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GhostButton(
                        "Cancelar",
                        width: 125,
                        onPressed: () {
                          res = false;
                          Get.back();
                        },
                      ),
                      PrimaryButton(
                        "Sim",
                        width: 125,
                        onPressed: () {
                          res = true;
                          Get.back();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });

    return res;
  }

  static Future showEmBreve() async {
    showErro('Quase lá', 'Em breve :)');
  }

  static Future<void> showErro(String title, String body) async {
    await Get.dialog(Wrap(
      runAlignment: WrapAlignment.center,
      children: [
        Dialog(
          child: Container(
            width: 400,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                HeaderText(
                  title,
                  fontSize: 20,
                ),
                const SizedBox(height: 20),
                BodyText(
                  body,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                PrimaryButton(
                  "OK",
                  onPressed: () => Get.back(),
                )
              ],
            ),
          ),
        )
      ],
    ));
  }

  static Future<void> showDestaque(
      String first, String destaque, String last) async {
    await Get.dialog(Dialog(
      child: Container(
        height: 180,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const HeaderText(
              "Atenção",
              fontSize: 20,
            ),
            BodyText(
              first,
              textAlign: TextAlign.center,
            ),
            HeaderText(
              destaque,
              fontSize: 16,
            ),
            BodyText(
              last,
              textAlign: TextAlign.center,
            ),
            PrimaryButton(
              "OK",
              onPressed: () => Get.back(),
            )
          ],
        ),
      ),
    ));
  }

  static Future<String> getString(
      BuildContext context, String label, String valor) async {
    String res = valor;

    Future<void> future = showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        FocusNode focus = FocusNode();
        focus.requestFocus();
        return Container(
            margin: MediaQuery.of(context).viewInsets,
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(12))),
            height: 178.0,
            child: Column(
              children: [
                CustomTextField(
                  validate: (t) {},
                  focusNode: focus,
                  label: label,
                  fontSize: 14,
                  initialValue: valor,
                  onSubmit: (txt) {
                    res = txt;
                    Navigator.pop(context);
                  },
                  onChanged: (txt) {
                    res = txt;
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GhostButton(
                      "Cancelar",
                      width: 120,
                      height: 40,
                      onPressed: () {
                        res = '';
                        Get.back();
                      },
                    ),
                    const SizedBox(width: 20),
                    PrimaryButton(
                      "Salvar",
                      width: 120,
                      height: 40,
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  ],
                )
              ],
            ));
      },
    );
    await future;
    return res;
  }
}
