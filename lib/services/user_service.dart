import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ibuild_dash/models/agent.dart';

class UserService {
  Future<Agent?> getAgent(String uid) async {
    try {
      var res =
          await FirebaseFirestore.instance.collection('agents').doc(uid).get();

      if (res.data() != null) return Agent.fromJson(res.data()!);
    } catch (e) {
      log('erro ao obter agent $e');
    }
    return null;
  }

  Future<List<Agent>> getAllAgents() async {
    List<Agent> list = [];

    try {
      var res = await FirebaseFirestore.instance.collection('agents').get();

      for (var s in res.docs) {
        list.add(Agent.fromJson(s.data()));
      }
    } catch (e) {
      log('erro ao obter agents $e');
    }
    return list;
  }
}
