import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibuild_dash/main.dart';
import 'package:ibuild_dash/responsive.dart';
import 'package:ibuild_dash/utils/color_utils.dart';
import 'package:ibuild_dash/views/components/body_text.dart';
import 'package:ibuild_dash/views/components/header_text.dart';
import 'package:ibuild_dash/views/components/logo.dart';
import 'package:ibuild_dash/views/components/primary_button.dart';
import 'package:ibuild_dash/views/components/progress.dart';
import 'package:ibuild_dash/views/components/textformfield/text_form.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passController = TextEditingController();

  final key = GlobalKey<FormState>();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorPrimary,
      body: Row(
        children: [
          Expanded(
              flex: 1,
              child: Container(
                height: Get.height,
                padding: EdgeInsets.all(Responsive.isMobile(context) ? 16 : 64),
                color: colorWhite,
                child: SingleChildScrollView(
                  child: Form(
                    key: key,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (Responsive.isMobile(context))
                          const SizedBox(height: 20),
                        const Logo(
                          text: true,
                          width: 250,
                        ),
                        const SizedBox(height: 20),
                        const HeaderText('Bem-vindo'),
                        const SizedBox(height: 15),
                        const BodyText(
                          'Faça login para acessar a administração do iBuild',
                          color: colorGrayDark2,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        const SizedBox(height: 20),
                        TextFormCustom(
                          labelTop: 'E-mail',
                          controller: emailController,
                          validator: (txt) {
                            if (emailController.text.isEmpty) {
                              return 'Obrigatório';
                            }
                            if (!emailController.text.isEmail) {
                              return 'E-mail inválido!';
                            }
                            return null;
                          },
                        ),
                        TextFormCustom(
                          labelTop: 'Senha',
                          isPassword: true,
                          controller: passController,
                          validator: (txt) {
                            if (passController.text.isEmpty) {
                              return 'Obrigatório';
                            }

                            return null;
                          },
                        ),
                        loading
                            ? const MyProgress()
                            : PrimaryButton(
                                'Entrar',
                                onPressed: () async {
                                  if (!key.currentState!.validate()) return;
                                  setState(() {
                                    loading = true;
                                  });
                                  if (await auth.loginWithEmail(
                                      emailController.text.trim(),
                                      passController.text)) {
                                  } else {
                                    setState(() {
                                      loading = false;
                                    });
                                  }
                                },
                              ),
                        const SizedBox(height: 20),
                        const BodyText('© 2022 iBuild.')
                      ],
                    ),
                  ),
                ),
              )),
          if (!Responsive.isMobile(context))
            Expanded(
              flex: Responsive.isTablet(context) ? 1 : 2,
              child: Container(
                padding: const EdgeInsets.all(48),
                decoration: BoxDecoration(
                  image: DecorationImage(
                      colorFilter: ColorFilter.mode(
                          colorBlack.withOpacity(0.7), BlendMode.darken),
                      image: const NetworkImage(
                          'http://www.misorellieng.com.br/wp-content/uploads/2019/08/original-976c1f43411d9834d3e6f43cd665f7d9.jpg'),
                      fit: BoxFit.cover),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    HeaderText(
                      '“A iBuild tem como missão conectar o bom prestador de serviço/lojista ao cliente de forma eficiente, elevando a qualidade dos atendimentos no setor.”',
                      color: colorWhite,
                      fontWeight: FontWeight.w800,
                      align: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    HeaderText(
                      'Beto Cristhian',
                      color: colorWhite,
                      fontWeight: FontWeight.w800,
                      align: TextAlign.center,
                      fontSize: 20,
                    ),
                    SizedBox(height: 6),
                    BodyText(
                      'CEO',
                      color: colorGrayDark3,
                    ),
                    SizedBox(height: 60),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
