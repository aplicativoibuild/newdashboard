/* 
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import '/main.dart';
import '/utils/dialog_utils.dart';
import '/views/components/primary_button.dart';
import '/views/pages/home/home.dart';
import '/views/sync_screen.dart';
import '/views/widgets/progress.dart';

class ButtonFacebook extends StatefulWidget {
  const ButtonFacebook({Key? key}) : super(key: key);

  @override
  _ButtonFacebookState createState() => _ButtonFacebookState();
}

class _ButtonFacebookState extends State<ButtonFacebook> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? MyProgress()
        : PrimaryButton(
            "            Continuar com Facebook",
            icon: "assets/svg/face.svg",
            align: MainAxisAlignment.start,
            onPressed: () async {
              setState(() {
                loading = true;
              });

              try {
                final AccessToken? accessToken =
                    await FacebookAuth.instance.accessToken;

                if (accessToken != null) {
                  await FacebookAuth.instance.logOut();
                }

                var res = await FacebookAuth.instance
                    .login(permissions: ['public_profile', 'email']);
                final AccessToken result = res.accessToken!;

                if (res.status == LoginStatus.success) {
                  final userData = await FacebookAuth.i.getUserData(
                    fields: "name,email",
                  );

                  final facebookAuthCredential =
                      FacebookAuthProvider.credential(result.token);

                  if (userData != null) {
                    if (await userService.checkEmail(userData['email'])) {
                      if (await auth.loginOnlyEmail(userData['email'])) {
                        Get.offAll(() => SyncScreen());
                      } else {
                        DialogUtils.showErro(
                            "Erro", "Ocorreu um erro ao logar");
                      }
                    } else {
                      loginController.email = userData['email'];
                      loginController.name = userData['name'];
                      if (await auth.socialSignup(facebookAuthCredential)) {
                        Get.offAll(() => SyncScreen());
                      } else {
                        DialogUtils.showErro(
                            "Erro", "Ocorreu um erro ao logar!");
                      }
                    }
                  }
                }
              } catch (e) {
                setState(() {
                  loading = false;
                });
              }
              setState(() {
                loading = false;
              });
            },
          );
  }
}
*/