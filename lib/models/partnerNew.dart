import '/models/partner.dart';

class FilePartner {
  late String path;
  late bool isNew;

  FilePartner(this.path, this.isNew);
}

class PartnerNew {
  String companyName = "";
  String companySlogan = "";
  String companyDescription = "";
  String companyIdentity = "";
  String companyWorkSince = "";
  String companyType = "";
  String companyCellphone = "";
  String companyReferal = "";
  String companyDddCellphone = "";
  String companyDddPhone = "";
  String companyPhone = "";
  String companyEmail = "";
  String companyLogo = "";
  String companyLogoPublic = "";

  String get fullPhone => '$companyDddPhone$companyPhone';
  String get fullCellphone => '$companyDddCellphone$companyCellphone';

  String companyCountry = "";
  String companyPostalcode = "";
  int companyState = 0;
  String companyCity = "";
  String companyNeighborhood = "";
  String companyAddress1 = "";
  String companyNumber = "";
  String companyComplement = "";

  List<FilePartner> files = [];
  FilePartner? video;
  FilePartner? audio;
  FilePartner? logo;

  List<int> companyCitiesSelected = [];
  List<int> companyCategoriesPtrSelected = [];
  List<int> companyServicesSelected = [];
  List<int> companyProfessionsSelected = [];

  List<String> companyImages = [];
  List<String> companyImagesPublic = [];

  String companyAudioRecord = "";
  String companyAudioRecordPublic = "";
  String companyVideoRecord = "";
  String companyVideoRecordPublic = "";

  String userUid = "";

  void clone(Partner p) {
    companyName = p.companyName;
    companyReferal = p.referal ?? "";
    companySlogan = p.slogan ?? "";
    companyDescription = p.description;
    companyIdentity = p.identity ?? "";
    companyWorkSince = p.worksince ?? "";
    companyType = p.type ?? "";
    companyCellphone = p.cellphone
            ?.replaceAll("+55", "")
            .substring(2, p.cellphone!.replaceAll("+55", "").length) ??
        "";

    companyReferal = p.referal ?? "";
    companyDddCellphone =
        p.cellphone?.replaceAll("+55", "").substring(0, 2) ?? "";
    companyDddPhone = p.phone?.replaceAll("+55", "").substring(0, 2) ?? "";
    companyPhone = p.phone
            ?.replaceAll("+55", "")
            .substring(2, p.phone!.replaceAll("+55", "").length) ??
        "";
    companyDddPhone = p.phone?.replaceAll("+55", "").substring(0, 2) ?? "";
    companyEmail = p.email ?? "";
    companyLogo = p.logo ?? "";
    companyLogoPublic = p.logoPublic;
    companyType = p.companyType ?? "P";

    companyCountry = p.country ?? "";
    companyPostalcode = p.postalcode ?? "";
    companyState = p.state;
    companyCity = p.city ?? "";
    companyNeighborhood = p.neighborhood ?? "";
    companyAddress1 = p.address1 ?? "";
    companyNumber = p.number ?? "";
    companyComplement = p.complement ?? "";

    companyAudioRecord = p.audio ?? "";
    companyAudioRecordPublic = p.audioPublic;
    companyVideoRecord = p.video ?? "";
    companyVideoRecordPublic = p.videoPublic;

    companyCitiesSelected
        .addAll(p.cities.map((e) => int.parse(e['id'].toString())).toList());
    companyCategoriesPtrSelected.addAll(
        p.categories.map((e) => int.parse(e['id'].toString())).toList());
    companyServicesSelected
        .addAll(p.services.map((e) => int.parse(e['id'].toString())).toList());
    companyProfessionsSelected.addAll(
        p.professions.map((e) => int.parse(e['id'].toString())).toList());

    companyImages.addAll(p.images.map((e) => e.toString()).toList());
    companyImagesPublic
        .addAll(p.imagesPublic.map((e) => e.toString()).toList());

    for (var f in p.imagesPublic) {
      files.add(FilePartner(f, false));
    }

    if (p.logoPublic.isNotEmpty) {
      logo = FilePartner(p.logoPublic, false);
    }

    if (p.audioPublic.isNotEmpty) {
      audio = FilePartner(p.audioPublic, false);
    }

    if (p.videoPublic.isNotEmpty) {
      video = FilePartner(p.videoPublic, false);
    }
  }

  PartnerNew() {
    companyType = "E";
  }

  PartnerNew.fromJson(Map<String, dynamic> json) {
    companyName = json['companyName'];
    companySlogan = json['companySlogan'];
    companyReferal = json['companyReferal'];
    companyDescription = json['companyDescription'];
    companyIdentity = json['companyIdentity'];
    companyWorkSince = json['companyWorkSince'];
    companyType = json['companyType'];
    companyCellphone = json['companyCellphone'];
    companyDddCellphone = json['companyDddCellphone'];
    companyPhone = json['companyPhone'];
    companyDddPhone = json['companyDddPhone'];
    companyEmail = json['companyEmail'];
    companyLogo = json['companyLogo'];
    companyCountry = json['companyCountry'];
    companyPostalcode = json['companyPostalcode'];
    companyState = json['companyState'];
    companyCity = json['companyCity'];
    companyNeighborhood = json['companyNeighborhood'];
    companyAddress1 = json['companyAddress1'];
    companyNumber = json['companyNumber'];
    companyComplement = json['companyComplement'];

    for (var s in json['companyCitiesSelected'] ?? []) {
      companyCitiesSelected.add(s);
    }

    for (var s in json['companyCategoriesPtrSelected'] ?? []) {
      companyCategoriesPtrSelected.add(s);
    }

    for (var s in json['companyServicesSelected'] ?? []) {
      companyServicesSelected.add(s);
    }
    for (var s in json['companyProfessionsSelected'] ?? []) {
      companyProfessionsSelected.add(s);
    }
    for (var s in json['companyImages'] ?? []) {
      companyImages.add(s);
    }

    for (var s in json['companyImagesPublic'] ?? []) {
      companyImagesPublic.add(s);
    }

    companyAudioRecord = json['companyAudioRecord'];
    companyVideoRecord = json['companyVideoRecord'];
    companyVideoRecordPublic = json['companyVideoRecordPublic'];
    userUid = json['userUid'];
  }

  Map<String, dynamic> toJson() {
    return {
      'companyName': companyName,
      'companyReferal': companyReferal,
      'companySlogan': companySlogan,
      'companyDescription': companyDescription,
      'companyIdentity': companyIdentity,
      'companyWorkSince': companyWorkSince,
      'companyType': companyType,
      'companyCellphone': companyCellphone,
      'companyDddCellphone': companyDddCellphone,
      'companyPhone': companyPhone,
      'companyDddPhone': companyDddPhone,
      'companyEmail': companyEmail,
      'companyLogo': companyLogo,
      'companyLogoPublic': companyLogoPublic,
      'companyCountry': companyCountry,
      'companyPostalcode': companyPostalcode,
      'companyState': companyState,
      'companyCity': companyCity,
      'companyNeighborhood': companyNeighborhood,
      'companyAddress1': companyAddress1,
      'companyNumber': companyNumber,
      'companyComplement': companyComplement,
      'companyCitiesSelected': companyCitiesSelected,
      'companyCategoriesPtrSelected': companyCategoriesPtrSelected,
      'companyServicesSelected': companyServicesSelected,
      'companyProfessionsSelected': companyProfessionsSelected,
      'companyImages': companyImages,
      'companyImagesPublic': companyImagesPublic,
      'companyAudioRecord': companyAudioRecord,
      'companyAudioRecordPublic': companyAudioRecordPublic,
      'companyVideoRecord': companyVideoRecord,
      'companyVideoRecordPublic': companyVideoRecordPublic,
      'userUid': userUid,
    };
  }
}
