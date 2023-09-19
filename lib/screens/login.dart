import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moveout1/screens/mapscreen.dart';
import 'package:moveout1/screens/signup.dart';
import 'package:moveout1/widgets/login_fields.dart';
import 'package:moveout1/widgets/confirm_button.dart';
import 'package:moveout1/widgets/background_container.dart';

const String emptyValidationFail = 'Este campo é obrigatório.';
const String submitValidationFail = 'Erro de validação, verifique os campos';
void main() {
  runApp(const AuthScreen());
}

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formkey = GlobalKey<FormState>();

  final TextEditingController _emailOrCpfFormFieldController =
      TextEditingController();

  final TextEditingController _passwordFormFieldController =
      TextEditingController();

  void submitData() {
    // if (_formkey.currentState!.validate()) {
      print('aqui, o login foi validado e pode ser enviado');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MapScreen()),
      );
    // }else{
    //   print('aqui, o login falhou a validação e não será enviado');
    // }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarContrastEnforced: true,
      ),
    );
    return Scaffold(
        body: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: MediaQuery.of(context).size.width,
                  minHeight: MediaQuery.of(context).size.height,
                ),
                child: IntrinsicHeight(
                    child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    BackgroundContainer(
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
                                image:
                                    AssetImage('assets/images/logos/logo1.png'),
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                            const SizedBox(height: 50),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth: MediaQuery.sizeOf(context).width,
                                  minHeight:
                                      MediaQuery.sizeOf(context).height * 0.35,
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(15)),
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 25.0,
                                        right: 25.0,
                                        top: 25.0,
                                        bottom: 10.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Form(
                                          key: _formkey,
                                          child: ListView(
                                            scrollDirection: Axis.vertical,
                                            shrinkWrap: true,
                                            children: [
                                              LoginTextFormField(
                                                lbl: 'E-mail ou CPF:',
                                                controller:
                                                    _emailOrCpfFormFieldController,
                                                validatorFunction: (value) {
                                                  if (value == null || value.isEmpty) {
                                                    return emptyValidationFail;
                                                  }
                                                  return null;
                                                },
                                              ),
                                              const SizedBox(height: 40),
                                              Column(
                                                children: [
                                                  LoginPasswordFormField(
                                                      lbl: 'Senha:',
                                                      controller:
                                                          _passwordFormFieldController,
                                                      validatorFunction: (value) {
                                                      if (value == null || value.isEmpty) {
                                                        return emptyValidationFail;
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                  const NavigatorTextButton(
                                                      txt: 'Esqueci a Senha',
                                                      destinationWidget:
                                                          SignupScreen()),
                                                ],
                                              ),
                                              const SizedBox(height: 40),
                                              Center(
                                                child: ConfirmButtonWidget(
                                                    lbl: 'Entrar',
                                                    fontSize: 25,
                                                    fontFamily: 'BebasKai',
                                                    submitFunction: submitData),
                                              ),
                                              const SizedBox(height: 20),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  const Text(
                                                    "Ainda não possui uma conta?",
                                                    textDirection:
                                                        TextDirection.ltr,
                                                    style: TextStyle(
                                                      fontSize: 11,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  NavigatorTextButton(
                                                    txt: 'Cadastre-se',
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .secondary,
                                                    destinationWidget:
                                                        const SignupScreen(),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
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
                    )
                  ],
                )))));
  }
}
