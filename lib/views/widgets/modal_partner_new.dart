import 'package:chewie_audio/chewie_audio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibuild_dash/models/partnerNew.dart';
import 'package:ibuild_dash/responsive.dart';
import 'package:ibuild_dash/utils/color_utils.dart';
import 'package:ibuild_dash/utils/dialog_utils.dart';
import 'package:ibuild_dash/utils/string_utils.dart';
import 'package:ibuild_dash/utils/utils.dart';
import 'package:ibuild_dash/views/components/body_text.dart';
import 'package:ibuild_dash/views/components/column_text.dart';
import 'package:ibuild_dash/views/components/header_text.dart';
import 'package:ibuild_dash/views/components/photo_round.dart';
import 'package:ibuild_dash/views/components/progress.dart';
import 'package:ibuild_dash/views/components/tab_view.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:video_player/video_player.dart';

class ModalPartnerNew extends StatefulWidget {
  const ModalPartnerNew(this.partner, {Key? key}) : super(key: key);

  final PartnerNew partner;

  @override
  State<ModalPartnerNew> createState() => _ModalPartnerNewState();
}

class _ModalPartnerNewState extends State<ModalPartnerNew> {
  bool loading = false;
  PartnerNew? partner;
  PartnerNew get p => partner!;

  @override
  void initState() {
    super.initState();
    partner = widget.partner;
  }

  @override
  Widget build(BuildContext context) {
    var child = loading
        ? const MyProgress()
        : partner == null
            ? const Center(child: BodyText('Erro ao buscar parceiro'))
            : Column(
                children: [
                  if (!Responsive.isMobile(context))
                    Row(
                      children: [
                        const Spacer(),
                        const HeaderText('Detalhes do parceiro'),
                        Expanded(
                            child: Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () => Get.back(),
                          ),
                        ))
                      ],
                    ),
                  if (!Responsive.isMobile(context)) const Divider(),
                  if (!Responsive.isMobile(context)) const SizedBox(height: 5),
                  Row(
                    children: [
                      PhotoRound(
                        p.companyLogoPublic,
                        network: true,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                          child:
                              ColumnText('Nome / Razão social', p.companyName)),
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
                        child: const Icon(Icons.more_vert),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: ColumnText('Cpf / Cnpj', p.companyIdentity),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: ColumnText('E-mail', p.companyEmail),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                          flex: 2,
                          child: ColumnText(
                              'Celular', formatCel(p.companyCellphone))),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: TabView([
                      TabChild(
                          Responsive.isMobile(context) ? 'End.' : 'Endereço',
                          colorPrimary,
                          PartnerAdressWidget(p)),
                      TabChild('Mídias', colorPrimary, MidiasPartnerWidget(p)),
                      TabChild(
                          'Serviços', colorPrimary, ServicosPartnerWidget(p)),
                      TabChild('Cidades', colorPrimary, CitiesPartnerWidget(p)),
                    ]),
                  )
                ],
              );
    return Responsive.isMobile(context)
        ? Scaffold(
            backgroundColor: colorWhite,
            appBar: Utils.appBar('Detalhes do parceiro', actions: [
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
                    child: Icon(Icons.more_vert),
                  ))
            ]),
            body: SafeArea(
                child:
                    Container(padding: const EdgeInsets.all(16), child: child)),
          )
        : Dialog(
            backgroundColor: Colors.transparent,
            child: Container(
              width: double.infinity,
              constraints: const BoxConstraints(maxWidth: 600),
              height: Get.height * 0.8,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: colorWhite, borderRadius: BorderRadius.circular(16)),
              child: child,
            ),
          );
  }
}

class PartnerAdressWidget extends StatelessWidget {
  const PartnerAdressWidget(this.p, {Key? key}) : super(key: key);

  final PartnerNew p;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ColumnText('Endereço', '${p.companyAddress1} ${p.companyNumber}'),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: ColumnText('Bairro', p.companyNeighborhood),
              ),
              Expanded(
                child: ColumnText('Complemento', p.companyComplement),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const Expanded(
                child: ColumnText('Cidade', ''),
              ),
              Expanded(
                child: ColumnText('CEP', p.companyPostalcode),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CitiesPartnerWidget extends StatelessWidget {
  const CitiesPartnerWidget(this.p, {Key? key}) : super(key: key);

  final PartnerNew p;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: ListView(
          children: p.companyCitiesSelected
              .map(
                (e) => Container(
                  child: RowItem(e.toString()),
                ),
              )
              .toList()),
    );
  }
}

class ServicosPartnerWidget extends StatelessWidget {
  const ServicosPartnerWidget(this.p, {Key? key}) : super(key: key);

  final PartnerNew p;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (p.companyServicesSelected.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HeaderText('Serviços'),
                const SizedBox(height: 10),
                ...p.companyServicesSelected
                    .map(
                      (e) => RowItem(e.toString()),
                    )
                    .toList()
              ],
            ),
          if (p.companyServicesSelected.isNotEmpty) const SizedBox(height: 10),
          if (p.companyCategoriesPtrSelected.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HeaderText('Categorias'),
                const SizedBox(height: 10),
                ...p.companyCategoriesPtrSelected
                    .map(
                      (e) => RowItem(e.toString()),
                    )
                    .toList()
              ],
            ),
          if (p.companyCategoriesPtrSelected.isNotEmpty)
            const SizedBox(height: 10),
          if (p.companyProfessionsSelected.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HeaderText('Profissões'),
                const SizedBox(height: 10),
                ...p.companyProfessionsSelected
                    .map(
                      (e) => RowItem(e.toString()),
                    )
                    .toList()
              ],
            ),
        ],
      ),
    );
  }
}

class RowItem extends StatelessWidget {
  const RowItem(this.title, {Key? key}) : super(key: key);

  final String? title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
                color: colorPrimary, borderRadius: BorderRadius.circular(16)),
          ),
          const SizedBox(width: 10),
          Expanded(child: BodyText(title ?? "")),
        ],
      ),
    );
  }
}

class MidiasPartnerWidget extends StatefulWidget {
  const MidiasPartnerWidget(this.p, {Key? key}) : super(key: key);
  final PartnerNew p;

  @override
  State<MidiasPartnerWidget> createState() => _MidiasPartnerWidgetState();
}

class _MidiasPartnerWidgetState extends State<MidiasPartnerWidget> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  VideoPlayerController? videoPlayerController;
  ChewieAudioController? chewieAudioController;

  void getData() async {
    if (widget.p.companyAudioRecordPublic.isNotEmpty) {
      videoPlayerController =
          VideoPlayerController.network(widget.p.companyAudioRecordPublic);

      await videoPlayerController!.initialize();

      chewieAudioController = ChewieAudioController(
          videoPlayerController: videoPlayerController!,
          autoPlay: false,
          looping: false,
          allowMuting: false);
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.p.companyImagesPublic.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HeaderText('Imagens'),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: widget.p.companyImagesPublic
                      .map((e) => PhotoRound(
                            e.toString(),
                            network: true,
                            width: 70,
                          ))
                      .toList(),
                ),
                const SizedBox(height: 10),
              ],
            ),
          if (widget.p.companyVideoRecordPublic.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Row(
                  children: const [
                    HeaderText('Vídeo'),
                    SizedBox(width: 10),
                    BodyText(
                      'Toque para abrir',
                      fontSize: 14,
                    )
                  ],
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () async {
                    if (await canLaunchUrlString(
                        widget.p.companyVideoRecordPublic)) {
                      launchUrlString(widget.p.companyVideoRecordPublic);
                    }
                  },
                  child: Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                        color: colorGrayLight3,
                        borderRadius: BorderRadius.circular(8)),
                    child: const Center(
                      child: Icon(Icons.video_call),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          if (chewieAudioController != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                const HeaderText('Áudio'),
                const SizedBox(height: 10),
                ChewieAudio(
                  controller: chewieAudioController!,
                ),
                const SizedBox(height: 10),
              ],
            )
        ],
      ),
    );
  }
}
