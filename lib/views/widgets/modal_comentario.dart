import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibuild_dash/main.dart';
import 'package:ibuild_dash/models/comment.dart';
import 'package:ibuild_dash/models/partner.dart';
import 'package:ibuild_dash/utils/color_utils.dart';
import 'package:ibuild_dash/utils/date_utils.dart';
import 'package:ibuild_dash/utils/dialog_utils.dart';
import 'package:ibuild_dash/views/components/body_text.dart';
import 'package:ibuild_dash/views/components/column_text.dart';
import 'package:ibuild_dash/views/components/ghost_button.dart';
import 'package:ibuild_dash/views/components/header_text.dart';
import 'package:ibuild_dash/views/components/photo_round.dart';
import 'package:ibuild_dash/views/components/primary_button.dart';
import 'package:ibuild_dash/views/components/progress.dart';
import 'package:ibuild_dash/views/components/star_widget.dart';

class ModalComentario extends StatefulWidget {
  const ModalComentario(this.comment, {Key? key}) : super(key: key);

  final Comment comment;

  @override
  State<ModalComentario> createState() => _ModalComentarioState();
}

class _ModalComentarioState extends State<ModalComentario> {
  Comment get c => widget.comment;
  late Partner partner;

  bool loading = false;
  bool saving = false;
  bool deleting = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      loading = true;
    });

    partner = (await partnerService.get(c.partnerId.toString()))!;

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runAlignment: WrapAlignment.center,
      children: [
        Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            width: 500,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: colorWhite, borderRadius: BorderRadius.circular(16)),
            child: loading
                ? const MyProgress()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(child: HeaderText('Ver comentário ${c.id}')),
                      const SizedBox(height: 5),
                      const Divider(
                        color: colorGrayLight3,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          ColumnText('Data', formatDataPadrao(c.createdAt)),
                          const SizedBox(width: 60),
                          ColumnText('Hora', formatHora(c.createdAt)),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          PhotoRound(
                            c.imageUrl,
                            network: true,
                          ),
                          const SizedBox(width: 10),
                          Expanded(child: ColumnText('Cliente', c.username)),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          PhotoRound(
                            partner.logoPublic,
                            network: true,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                              child:
                                  ColumnText('Parceiro', partner.companyName)),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const BodyText(
                        'Nota',
                        fontSize: 14,
                        color: colorGrayDark1,
                      ),
                      const SizedBox(height: 10),
                      StarWidget(c.rank.toInt(), 5),
                      const SizedBox(height: 20),
                      ColumnText('Comentário', c.comment),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          deleting
                              ? const SizedBox(width: 150, child: MyProgress())
                              : GhostButton(
                                  'Apagar',
                                  width: 150,
                                  onPressed: () async {
                                    if (saving) return;
                                    if (await DialogUtils.confirmDelete(
                                        context,
                                        'Atenção',
                                        'Deseja realmente apagar o comentário?')) {
                                      setState(() {
                                        saving = true;
                                      });

                                      if (await partnerService
                                          .deleteComment(c)) {
                                        Get.back();
                                      } else {
                                        setState(() {
                                          saving = false;
                                        });
                                      }
                                    }
                                  },
                                ),
                          const SizedBox(width: 10),
                          saving
                              ? const SizedBox(width: 150, child: MyProgress())
                              : PrimaryButton(
                                  'Aprovar',
                                  width: 150,
                                  onPressed: () async {
                                    if (deleting) return;
                                    setState(() {
                                      saving = true;
                                    });

                                    c.approvalAt = DateTime.now();
                                    c.approvalBy = userController.adm.name;
                                    c.enable = true;

                                    if (await partnerService.updateComment(c)) {
                                      Get.back();
                                    } else {
                                      setState(() {
                                        saving = false;
                                      });
                                    }
                                  },
                                )
                        ],
                      ),
                    ],
                  ),
          ),
        )
      ],
    );
  }
}
