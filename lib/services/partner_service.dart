import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ibuild_dash/models/comment.dart';
import 'package:ibuild_dash/models/partner.dart';
import 'package:ibuild_dash/models/partnerNew.dart';

class PartnerService {
  Future<List<Comment>> commentsToAvaliate() async {
    List<Comment> list = [];

    try {
      var db = FirebaseFirestore.instance.collection('comments');
      var res = await db
          // .where("approvalAt", isEqualTo: null)
          .where("enable", isEqualTo: false)
          .get();

      for (var s in res.docs) {
        list.add(Comment.fromJson(s.data(), uid: s.id));
      }
    } catch (e) {
      log('erro ao string $e');
    }
    return list;
  }

  Future<bool> updateComment(Comment c) async {
    try {
      var db = FirebaseFirestore.instance.collection('comments');
      await db.doc(c.id.toString()).update(c.toJson());
      return true;
    } catch (e) {
      log('erro ao atualizar comentario $e');
    }
    return false;
  }

  Future<bool> deleteComment(Comment c) async {
    try {
      var db = FirebaseFirestore.instance.collection('comments');

      await db.doc(c.id.toString()).delete();
      return true;
    } catch (e) {
      log('erro ao deletar comment $e');
    }
    return false;
  }

  Future<List<Partner>> getAllResumo() async {
    List<Partner> list = [];

    try {
      var res = await FirebaseFirestore.instance
          .collection('helpers')
          .doc('partners')
          .get();

      if (res.data() != null) {
        for (var s in res.data()!['partners'] ?? []) {
          list.add(Partner.fromJson(s));
        }
      }
    } catch (e) {
      log('erro ao obter partners resumo $e');
    }
    return list;
  }

  Future<List<PartnerNew>> getModify() async {
    List<PartnerNew> list = [];

    try {
      var res =
          await FirebaseFirestore.instance.collection('partnersModify').get();

      for (var s in res.docs) {
        list.add(PartnerNew.fromJson(s.data()));
      }
    } catch (e) {
      log('erro ao obter partners resumo $e');
    }
    return list;
  }

  Future<Partner?> get(String uid) async {
    try {
      var db = FirebaseFirestore.instance.collection('partners');
      var res = await db.doc(uid).get();

      if (res.data() != null) return Partner.fromJson(res.data()!);
    } catch (e) {
      print('Erro ao obter parner1 $e');
      return null;
    }
    return null;
  }
}
