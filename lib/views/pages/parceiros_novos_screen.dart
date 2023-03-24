import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibuild_dash/main.dart';
import 'package:ibuild_dash/models/data_source.dart';
import 'package:ibuild_dash/models/partner.dart';
import 'package:ibuild_dash/responsive.dart';
import 'package:ibuild_dash/screens/dashboard/components/header.dart';
import 'package:ibuild_dash/utils/color_utils.dart';
import 'package:ibuild_dash/utils/dialog_utils.dart';
import 'package:ibuild_dash/views/components/body_text.dart';
import 'package:ibuild_dash/views/components/photo_round.dart';
import 'package:ibuild_dash/views/widgets/modal_partner.dart';

class ParceirosNovosScreen extends StatefulWidget {
  const ParceirosNovosScreen({Key? key}) : super(key: key);

  @override
  State<ParceirosNovosScreen> createState() => _ParceirosNovosScreenState();
}

class _ParceirosNovosScreenState extends State<ParceirosNovosScreen> {
  String search = "";
  final pageController = PaginatorController();
  int order = 1;

  List<Partner> partners = [];

  changeOrder(int o) {
    pageController.goToFirstPage();
    setState(() {
      order = o;
    });
  }

  filter() {
    var tmp = partners;

    if (order == 1) {
      tmp.sort(((a, b) => a.companyName.compareTo(b.companyName)));
    }
    if (order == 2) {
      tmp.sort(((a, b) => b.companyName.compareTo(a.companyName)));
    }
    if (order == 3) tmp.sort(((a, b) => a.id > b.id ? 1 : -1));
    if (order == 4) tmp.sort(((a, b) => a.id > b.id ? -1 : 1));

    return tmp.where((e) => e.companyName.search(search)).toList();
  }

  @override
  Widget build(BuildContext context) {
    var filtered = filter();
    return Container(
      padding: const EdgeInsets.all(16),
      constraints: const BoxConstraints(maxWidth: 600),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Row(
              children: [
                Expanded(
                  child: SearchField(
                    onChanged: (txt) {
                      pageController.goToFirstPage();
                      setState(() {
                        search = txt;
                      });
                    },
                  ),
                ),
                InkWell(
                    onTapDown: (d) {
                      DialogUtils.modalSelect(d, [
                        ModalAction('Nome - Crescente',
                            onTap: () => changeOrder(1)),
                        ModalAction('Nome - Decrescente',
                            onTap: () => changeOrder(2)),
                        ModalAction('ID - Crescente',
                            onTap: () => changeOrder(3)),
                        ModalAction('ID - Decrescente',
                            onTap: () => changeOrder(4)),
                      ]);
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.sort_by_alpha),
                    ))
              ],
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: PaginatedDataTable2(
              // header: Container(),

              autoRowsToHeight: true,
              controller: pageController,
              columns: const [
                DataColumn2(
                    size: ColumnSize.L,
                    label: SizedBox(child: BodyText('Parceiro'))),
              ],
              dataRowHeight: 60,
              horizontalMargin: 12,
              empty: Container(
                padding: const EdgeInsets.all(16),
                child: const BodyText('Nenhum parceiro'),
              ),
              source: MainDataSource<Partner>(
                filtered,
                buildRow: (p) {
                  return DataRow(cells: [
                    DataCell(
                        Row(
                          children: [
                            PhotoRound(
                              p.logoPublic,
                              network: true,
                              radius: 100,
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      // if (p.subscribed)
                                      //   SvgPicture.asset(
                                      //     'assets/svg/verified.svg',
                                      //     color: colorPrimary,
                                      //     width: 18,
                                      //   ),
                                      // if (p.subscribed) const SizedBox(width: 5),
                                      Expanded(
                                        child: BodyText(
                                          p.companyName,
                                          maxLines: 1,
                                          autosize: true,
                                          color: p.subscribed
                                              ? colorPrimary
                                              : colorGrayDark1,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 2),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 35,
                                        child: BodyText(
                                          p.id.toString(),
                                          fontSize: 12,
                                          color: colorGrayDark3,
                                        ),
                                      ),
                                      Expanded(
                                        child: BodyText(
                                          p.email ?? "",
                                          maxLines: 1,
                                          fontSize: 12,
                                          autosize: true,
                                          color: colorGrayDark2,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                                onTapDown: (d) {
                                  DialogUtils.modalSelect(d, [
                                    ModalAction('Enviar notificação',
                                        onTap: () => DialogUtils.showEmBreve()),
                                    ModalAction('Enviar orçamento',
                                        onTap: () => DialogUtils.showEmBreve()),
                                    ModalAction('Incluir assinatura',
                                        onTap: () => DialogUtils.showEmBreve()),
                                  ]);
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(Icons.more_vert,
                                      color: colorGrayDark2),
                                ))
                          ],
                        ), onTap: () {
                      if (Responsive.isMobile(context)) {
                        Get.to(() => ModalPartner(p));
                      } else {
                        Get.dialog(ModalPartner(p));
                      }
                    }),
                  ]);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
