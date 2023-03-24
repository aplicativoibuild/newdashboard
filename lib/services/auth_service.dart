import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:ibuild_dash/main.dart';
import 'package:ibuild_dash/screens/login_screen.dart';
import 'package:ibuild_dash/screens/main/main_screen.dart';
import 'package:ibuild_dash/utils/dialog_utils.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  AuthService();
  StreamSubscription? stream;

  void init() async {
    stream = FirebaseAuth.instance.idTokenChanges().listen((User? user) async {
      if (user == null) {
        print('User is currently signed out!');
        Get.offAll(() => const LoginScreen());
      } else {
        userController.agent = await userService.getAgent(user.uid);

        Get.offAll(() => MainScreen());
      }
    });
  }

  Future<bool> hasSession() async {
    try {
      if (FirebaseAuth.instance.currentUser != null) {
        await _populateCurrentUser(FirebaseAuth.instance.currentUser!);
        return true;
      } else {
        return false;
      }
    } on Exception catch (e) {
      log('Erro:$e');
      return false;
    }
  }

  Future _populateCurrentUser(User user) async {
    var agent = await userService.getAgent(user.uid);

    if (agent != null) {
      userController.agent = agent;
    }
  }

  Future setSession() async {
    try {
      if (FirebaseAuth.instance.currentUser != null) {
        await _populateCurrentUser(FirebaseAuth.instance.currentUser!);
        return true;
      } else {
        return false;
      }
    } on FirebaseAuthException catch (e) {
      log('Erro:${e.code}');
      return e.code;
    }
  }

  Future<bool> loginWithEmail(String email, String senha) async {
    try {
      UserCredential authResult =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email.trim(),
        password: senha.trim(),
      );

      //if (authResult.user.emailVerified) {
      await _populateCurrentUser(authResult.user!);

      return true;
      //} else {
      //return "Email não verificado";
      //}
    } on FirebaseAuthException catch (e) {
      log('Erro:${e.code}');
      DialogUtils.showErro('Erro', errosFirebase(e.toString()));
      return false;
    }
  }

  String errosFirebase(String erro) {
    if (erro.contains('email-already-in-use')) return "E-mail já utilizado!";
    if (erro.contains('too-many-requests')) {
      return "Muitas tentativas! Aguarde alguns minutos";
    }
    if (erro.contains('invalid-verification-code')) {
      return "Código SMS inválido!";
    }
    if (erro.contains('invalid-email')) return "E-mail inválido!";
    if (erro.contains('invalid-verification-id')) {
      return "Código expirado, tente novamente!";
    }
    if (erro.contains('user-not-found')) return "E-mail não encontrado!";
    if (erro.contains('wrong-password')) return "Senha incorreta!";
    return erro;
  }

  Future logout() async {
    await _firebaseAuth.signOut().then((val) {});
  }

  Future<bool> isUserLoggedIn() async {
    var user = _firebaseAuth.currentUser;
    bool res = await _populateCurrentUser(user!);
    return res;
  }

  Future<bool> singOut() async {
    await _firebaseAuth.signOut().then((value) => {
          log("Usuário deslogado"),
        });
    return true;
  }
}
