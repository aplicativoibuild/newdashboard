import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibuild_dash/main.dart';
import 'package:ibuild_dash/models/data_source.dart';
import 'package:ibuild_dash/models/partnerNew.dart';
import 'package:ibuild_dash/responsive.dart';
import 'package:ibuild_dash/screens/dashboard/components/header.dart';
import 'package:ibuild_dash/utils/color_utils.dart';
import 'package:ibuild_dash/utils/dialog_utils.dart';
import 'package:ibuild_dash/views/components/body_text.dart';
import 'package:ibuild_dash/views/components/photo_round.dart';
import 'package:ibuild_dash/views/components/progress.dart';
import 'package:ibuild_dash/views/widgets/modal_partner_new.dart';

class ParceirosModifyScreen extends StatefulWidget {
  const ParceirosModifyScreen({Key? key}) : super(key: key);

  @override
  State<ParceirosModifyScreen> createState() => _ParceirosModifyScreenState();
}

class _ParceirosModifyScreenState extends State<ParceirosModifyScreen> {
  String search = "";
  final pageController = PaginatorController();
  int order = 1;

  List<PartnerNew> partners = [];

  bool loading = false;
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      loading = true;
    });

    partners = await partnerService.getModify();

    setState(() {
      loading = false;
    });
  }

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
            child: loading
                ? const MyProgress()
                : PaginatedDataTable2(
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
                    source: MainDataSource<PartnerNew>(
                      filtered,
                      buildRow: (p) {
                        return DataRow(cells: [
                          DataCell(
                              Row(
                                children: [
                                  PhotoRound(
                                    p.companyLogoPublic,
                                    network: true,
                                    radius: 100,
                                  ),
                                  const SizedBox(width: 15),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                                color: colorGrayDark1,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 2),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: BodyText(
                                                p.companyEmail,
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
                                ],
                              ), onTap: () {
                            if (Responsive.isMobile(context)) {
                              Get.to(() => ModalPartnerNew(p));
                            } else {
                              Get.dialog(ModalPartnerNew(p));
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
