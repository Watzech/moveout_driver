
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/backgrounds/mbl_bg_3.png'),
          fit: BoxFit.cover,
        ),
      ),
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
                        const LoginTextWidget(lbl: 'E-mail ou CPF:', obscure: false),
                        const SizedBox(height: 50),
                        const Column(
                          children: [
                            LoginTextWidget(lbl: 'Senha:', obscure: true),
                            LoginTextButton(txt: 'Esqueci a Senha', color: Colors.white),
                          ],
                        ),
                        const SizedBox(height: 40),
                        Center(
                          child: FilledButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).colorScheme.secondary),
                              fixedSize: MaterialStateProperty.all(const Size(200, 60)),
                            ),
                            child: const Text(
                              'Entrar',
                              textDirection: TextDirection.ltr,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                        )),
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

class LoginTextWidget extends StatelessWidget {
  final String lbl;
  final bool obscure;
  const LoginTextWidget({super.key, required this.lbl, required this.obscure});

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscure,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
          width: 1,
          color: Colors.white,
        )),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 1.0),
        ),
        labelText: lbl,
        labelStyle: const TextStyle(color: Colors.white, fontSize: 15),
      ),
    );
  }
}
