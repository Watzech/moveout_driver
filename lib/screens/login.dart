import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moveout1/screens/mapscreen.dart';
import 'package:moveout1/screens/profile.dart';
import 'package:moveout1/screens/signup.dart';
import 'package:moveout1/services/do_login.dart';
import 'package:moveout1/services/device_info.dart';
import 'package:moveout1/widgets/login_fields.dart';
import 'package:moveout1/widgets/background_container.dart';

import '../widgets/default_button.dart';

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
  dynamic userData;
  // String? _loggedUser;
  bool _isScreenLoading = true;
  bool _isButtonLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      userData = await getUserInfo();

      if (userData?["cpf"] != null && userData["cpf"].length > 5) {
        goMap();
      } else {
        setState(() {
          _isScreenLoading = false;
        });
      }
    });
  }

  void saveUser(dynamic user) async {
    await loginSave(user);
    goMap();
  }

  void goMap() {
    Navigator.push(
      context,
      // MaterialPageRoute(builder: (context) => const MapScreen()),
      MaterialPageRoute(builder: (context) => ProfileScreen(userData: userData)),
    );
  }

  Future<void> submitData() async {
    if (_formkey.currentState!.validate()) {
      String email = _emailOrCpfFormFieldController.text;
      String password = _passwordFormFieldController.text;

      setState(() {
        _isButtonLoading = true;
      });

      dynamic login = await doLogin(email, password);

      if (login["done"]) {
        saveUser(login);
      } else {
        setState(() {
          _isButtonLoading = false;
        });
        loginErrorFlushBar();
      }
    }
  }

  Future<dynamic> loginErrorFlushBar() {
    return Flushbar(
      messageText: const Padding(
        padding: EdgeInsets.fromLTRB(45, 15, 15, 15),
        child: Text(
          'Login incorreto, tente novamente.',
          style: TextStyle(
              fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: Colors.red,
      padding: const EdgeInsets.all(15),
      icon: const Padding(
        padding: EdgeInsets.fromLTRB(25, 15, 15, 15),
        child: Icon(
          Icons.error_outline,
          color: Colors.white,
          size: 30,
        ),
      ),
      duration: const Duration(seconds: 3),
    ).show(context);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarContrastEnforced: true,
      ),
    );
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: _isScreenLoading
            ? Center(
                child: CircularProgressIndicator(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              )
            : SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: IntrinsicHeight(
                    child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    BackgroundContainer(
                      src: 'assets/images/backgrounds/mbl_bg_4.png',
                      child: SafeArea(
                        minimum: const EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(30, 10, 30, 40),
                                child: Image(
                                  alignment: Alignment.center,
                                  image: const AssetImage(
                                      'assets/images/logos/logo1.png'),
                                  fit: BoxFit.fitWidth,
                                  width: screenWidth * 0.6,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Container(
                                height: screenHeight * 0.55,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(15)),
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                // alignment: Alignment.center,
                                child: Form(
                                  key: _formkey,
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        35, 15, 35, 15),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      // scrollDirection: Axis.vertical,
                                      // shrinkWrap: true,
                                      children: [
                                        LoginTextFormField(
                                          lbl: 'E-mail:',
                                          controller:
                                              _emailOrCpfFormFieldController,
                                          validatorFunction: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return emptyValidationFail;
                                            }
                                            return null;
                                          },
                                        ),
                                        Column(
                                          children: [
                                            LoginPasswordFormField(
                                              lbl: 'Senha:',
                                              controller:
                                                  _passwordFormFieldController,
                                              validatorFunction: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return emptyValidationFail;
                                                }
                                                return null;
                                              },
                                            ),
                                            NavigatorTextButton(
                                                txt: 'Esqueci a Senha',
                                                fontSize: screenWidth * 0.03,
                                                destinationWidget:
                                                    const SignupScreen()),
                                          ],
                                        ),
                                        Center(
                                          child: DefaultButton(
                                            text: 'Entrar',
                                            onPressedFunction: submitData,
                                            isLoading: _isButtonLoading,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Ainda não possui uma conta?",
                                              textDirection: TextDirection.ltr,
                                              style: TextStyle(
                                                fontSize: screenWidth * 0.03,
                                                color: Colors.white,
                                              ),
                                            ),
                                            NavigatorTextButton(
                                              fontSize: screenWidth * 0.03,
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
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ))));
  }
}
