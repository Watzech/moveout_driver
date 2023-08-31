
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moveout1/widgets/login_fields.dart';
import 'package:moveout1/widgets/confirm_button.dart';
import 'package:moveout1/widgets/background_container.dart';

void main() {
  runApp(const AuthScreen());
}

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarContrastEnforced: true,
      ),
    );
    return BackgroundContainer(
      src: 'assets/images/backgrounds/mbl_bg_3.png',
      child: SafeArea(
        minimum: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
              child: Image(
                alignment: Alignment.center,
                image: AssetImage('assets/images/logos/logo1.png'),
                fit: BoxFit.fitWidth,
              ),
            ),
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.sizeOf(context).width,
                  minHeight: MediaQuery.sizeOf(context).height * 0.35,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0, bottom: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const LoginTextField(lbl: 'E-mail ou CPF:'),
                        const SizedBox(height: 50),
                        Column(
                          children: [
                            LoginPasswordTextField(lbl: 'Senha:'),
                            const LoginTextButton(txt: 'Esqueci a Senha', color: Colors.white),
                          ],
                        ),
                        const SizedBox(height: 40),
                        const Center(
                          child: ConfirmButtonWidget(lbl:'Entrar'),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Ainda não possui uma conta?",
                              textDirection: TextDirection.ltr,
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.white,
                              ),
                            ),
                            LoginTextButton(txt: 'Cadastre-se', color: Theme.of(context).colorScheme.secondary),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class LoginTextButton extends StatelessWidget {
  final String txt;
  final Color color;
  const LoginTextButton({super.key, required this.txt, required this.color});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {},
        child: Align(
          alignment: Alignment.centerRight,
          child: Text(
            txt,
            textDirection: TextDirection.ltr,
            style: TextStyle(
              fontSize: 11,
              color: color,
              decoration: TextDecoration.underline,
              decorationColor: color,
              decorationThickness: 2,
            ),
          ),
        ));
  }
}