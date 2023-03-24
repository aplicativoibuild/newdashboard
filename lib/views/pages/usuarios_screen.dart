import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibuild_dash/constants.dart';
import 'package:ibuild_dash/main.dart';
import 'package:ibuild_dash/models/agent.dart';
import 'package:ibuild_dash/models/data_source.dart';
import 'package:ibuild_dash/responsive.dart';
import 'package:ibuild_dash/utils/string_utils.dart';
import 'package:ibuild_dash/views/components/body_text.dart';
import 'package:ibuild_dash/views/components/header_text.dart';
import 'package:ibuild_dash/views/components/progress.dart';

class UsuariosScreen extends StatefulWidget {
  const UsuariosScreen({Key? key}) : super(key: key);

  @override
  State<UsuariosScreen> createState() => _UsuariosScreenState();
}

class _UsuariosScreenState extends State<UsuariosScreen> {
  bool loading = false;

  List<Agent> list = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      loading = true;
    });

    list = await userService.getAllAgents();

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
                    source: MainDataSource<Agent>(list, buildRow: ((e) {
                      return DataRow(cells: [
                        DataCell(Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            HeaderText(
                              e.name,
                              fontSize: 14,
                            ),
                            const SizedBox(height: 5),
                            BodyText(
                              e.role.capitalize!,
                              fontSize: 12,
                            )
                          ],
                        )),
                        DataCell(Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            HeaderText(
                              e.email,
                              fontSize: 14,
                              align: TextAlign.start,
                              maxLines: 1,
                            ),
                            const SizedBox(height: 5),
                            BodyText(
                              formatCel(e.phone),
                              maxLines: 1,
                              fontSize: 12,
                            )
                          ],
                        )),
                        // DataCell(
                        //   Row(
                        //     children: [
                        //       IconButton(
                        //           onPressed: () async {
                        //             // await Get.dialog(ModalComentario(e));
                        //             getData();
                        //           },
                        //           icon: const Icon(
                        //             Icons.visibility,
                        //             color: colorGrayDark2,
                        //           ))
                        //     ],
                        //   ),
                        // ),
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
                        label: Text("Usuário"),
                      ),
                      DataColumn(
                        label: Text("Contato"),
                      ),
                      // DataColumn(
                      //   label: Text("Ações"),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
