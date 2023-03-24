import 'package:chewie_audio/chewie_audio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibuild_dash/main.dart';
import 'package:ibuild_dash/models/partner.dart';
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
import 'package:ibuild_dash/views/components/star_widget.dart';
import 'package:ibuild_dash/views/components/tab_view.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:video_player/video_player.dart';

class ModalPartner extends StatefulWidget {
  const ModalPartner(this.partner, {Key? key}) : super(key: key);

  final Partner partner;

  @override
  State<ModalPartner> createState() => _ModalPartnerState();
}

class _ModalPartnerState extends State<ModalPartner> {
  bool loading = false;
  Partner? partner;
  Partner get p => partner!;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      loading = true;
    });

    partner = await partnerService.get(widget.partner.id.toString());

    setState(() {
      loading = false;
    });
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
                        p.logoPublic,
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
                        child: ColumnText('Cpf / Cnpj', p.identity ?? ""),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const BodyText(
                              'Ranking',
                              fontSize: 14,
                            ),
                            const SizedBox(height: 5),
                            StarWidget(p.ranking.toInt(), 5)
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: ColumnText('E-mail', p.email ?? ""),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                          flex: 2,
                          child: ColumnText(
                              'Celular', formatCel(p.cellphone ?? ""))),
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

  final Partner p;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ColumnText('Endereço', '${p.address1 ?? ""} ${p.number}'),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: ColumnText('Bairro', p.neighborhood ?? ""),
              ),
              Expanded(
                child: ColumnText('Complemento', p.complement ?? "-"),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: ColumnText(
                    'Cidade',
                    p.cities.firstWhereOrNull((element) =>
                            element['id']?.toString() == p.city)?['city'] ??
                        p.city),
              ),
              Expanded(
                child: ColumnText('CEP', p.postalcode ?? "-"),
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

  final Partner p;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: ListView(
          children: p.cities
              .map(
                (e) => Container(
                  child: RowItem(e['city']?.toString()),
                ),
              )
              .toList()),
    );
  }
}

class ServicosPartnerWidget extends StatelessWidget {
  const ServicosPartnerWidget(this.p, {Key? key}) : super(key: key);

  final Partner p;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (p.services.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HeaderText('Serviços'),
                const SizedBox(height: 10),
                ...p.services
                    .map(
                      (e) => RowItem(e['title']?.toString()),
                    )
                    .toList()
              ],
            ),
          if (p.services.isNotEmpty) const SizedBox(height: 10),
          if (p.categories.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HeaderText('Categorias'),
                const SizedBox(height: 10),
                ...p.categories
                    .map(
                      (e) => RowItem(e['title']?.toString()),
                    )
                    .toList()
              ],
            ),
          if (p.categories.isNotEmpty) const SizedBox(height: 10),
          if (p.professions.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HeaderText('Profissões'),
                const SizedBox(height: 10),
                ...p.professions
                    .map(
                      (e) => RowItem(e['title']?.toString()),
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
  final Partner p;

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
    if (widget.p.audioPublic.isNotEmpty) {
      videoPlayerController =
          VideoPlayerController.network(widget.p.audioPublic);

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
          if (widget.p.imagesPublic.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HeaderText('Imagens'),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: widget.p.imagesPublic
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
          if (widget.p.videoPublic.isNotEmpty)
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
                    if (await canLaunchUrlString(widget.p.videoPublic)) {
                      launchUrlString(widget.p.videoPublic);
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
