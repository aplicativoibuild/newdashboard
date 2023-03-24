import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:ibuild_dash/main.dart';
import 'package:ibuild_dash/models/partner.dart';

class DashboardController {
  RxInt partnersCount = RxInt(0);
  RxInt partnersModify = RxInt(0);
  RxInt partnersNew = RxInt(0);
  RxInt commentsToAvaliate = RxInt(0);

  RxBool loading = RxBool(false);

  StreamSubscription? stream;
  var partners = <Partner>[].obs;

  void init() {
    stream = FirebaseFirestore.instance
        .collection('dashboard')
        .doc('resumo')
        .snapshots()
        .listen((event) {
      if (event.data() != null) {
        var data = event.data()!;

        partnersModify.value = data['partnersModify'] ?? 0;
        partnersNew.value = data['partnersNew'] ?? 0;
        commentsToAvaliate.value = data['commentsToAvaliate'] ?? 0;
      }
    });

    getData();
  }

  void getData() async {
    loading.value = true;
    partners.clear();
    partners.addAll(await partnerService.getAllResumo());
    partnersCount.value = partners.length;
    loading.value = false;
  }
}
