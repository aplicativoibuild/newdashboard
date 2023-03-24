import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibuild_dash/constants.dart';
import 'package:ibuild_dash/main.dart';
import 'package:ibuild_dash/models/comment.dart';
import 'package:ibuild_dash/models/data_source.dart';
import 'package:ibuild_dash/responsive.dart';
import 'package:ibuild_dash/utils/color_utils.dart';
import 'package:ibuild_dash/utils/date_utils.dart';
import 'package:ibuild_dash/views/components/body_text.dart';
import 'package:ibuild_dash/views/components/header_text.dart';
import 'package:ibuild_dash/views/components/progress.dart';
import 'package:ibuild_dash/views/widgets/modal_comentario.dart';

class ComentariosScreen extends StatefulWidget {
  const ComentariosScreen({Key? key}) : super(key: key);

  @override
  State<ComentariosScreen> createState() => _ComentariosScreenState();
}

class _ComentariosScreenState extends State<ComentariosScreen> {
  bool loading = false;
  List<Comment> list = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      loading = true;
    });

    list = await partnerService.commentsToAvaliate();

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: loading
          ? const MyProgress()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: Get.height * 0.8,
                  padding: const EdgeInsets.all(0),
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: PaginatedDataTable2(
                    source: MainDataSource<Comment>(list, buildRow: ((e) {
                      return DataRow(cells: [
                        DataCell(Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            HeaderText(
                              formatDataPadrao(e.createdAt),
                              fontSize: 14,
                            ),
                            const SizedBox(height: 5),
                            BodyText(
                              formatHora(e.createdAt),
                              fontSize: 12,
                            )
                          ],
                        )),
                        DataCell(Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            HeaderText(
                              e.username,
                              fontSize: 14,
                              align: TextAlign.start,
                              maxLines: 1,
                            ),
                            const SizedBox(height: 5),
                            BodyText(
                              e.comment,
                              maxLines: 1,
                              fontSize: 12,
                            )
                          ],
                        )),
                        DataCell(
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () async {
                                    await Get.dialog(ModalComentario(e));
                                    getData();
                                  },
                                  icon: const Icon(
                                    Icons.visibility,
                                    color: colorGrayDark2,
                                  ))
                            ],
                          ),
                        ),
                      ]);
                    })),
                    columnSpacing: defaultPadding,
                    empty: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: BodyText('Nenhum comentário'),
                    ),
                    minWidth:
                        Responsive.isMobile(context) ? Get.width * 0.9 : 600,
                    columns: const [
                      DataColumn(
                        label: Text("Data"),
                      ),
                      DataColumn(
                        label: Text("Comentário"),
                      ),
                      DataColumn(
                        label: Text("Ações"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
