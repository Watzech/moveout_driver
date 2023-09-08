import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:validation_pro/validate.dart';

import 'package:moveout1/widgets/confirm_button.dart';
import 'package:moveout1/widgets/login_fields.dart';
import 'package:moveout1/database/client.dart';
import 'package:moveout1/database/database.dart';

enum ImageSourceType { gallery, camera }

const String emptyValidationFail = 'Este campo é obrigatório.';
const String submitValidationFail = 'Erro de validação, verifique os campos';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});
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
        child: const SingupTabBar());
  }
}

class SingupTabBar extends StatefulWidget {
  const SingupTabBar({super.key});

  @override
  State<SingupTabBar> createState() => _SingupTabBarState();
}

class _SingupTabBarState extends State<SingupTabBar> {
  final _formkey = GlobalKey<FormState>();

  final TextEditingController _nameFormFieldController =
      TextEditingController();

  final TextEditingController _cpfFormFieldController =
      TextEditingController();

  final TextEditingController _phoneFormFieldController =
      TextEditingController();

  final TextEditingController _emailFormFieldController =
      TextEditingController();

  final TextEditingController _passwordFormFieldController =
      TextEditingController();

  final TextEditingController _confirmPasswordFormFieldController =
      TextEditingController();

  final TextEditingController _addressFormFieldController =
      TextEditingController();

  void submitData() {
    if (_formkey.currentState!.validate()) {
      //form correto, cria a entidade e envia pro BD
      print("Uploading...");
      Client clientData = Client(
        name: _nameFormFieldController.text,
        cpf: _cpfFormFieldController.text,
        phone: _phoneFormFieldController.text,
        email: _emailFormFieldController.text,
        password: _passwordFormFieldController.text,
        photo: 'Work in Progress',
        address: _addressFormFieldController.text,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      Database.insert(clientData);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text(submitValidationFail),
        backgroundColor: Theme.of(context).colorScheme.error,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 1,
      child: Stack(
        children: [
          Image.asset(
            "assets/images/backgrounds/mbl_bg_1.png",
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.secondary,
              toolbarHeight: 0,
              bottom: TabBar(
                indicatorColor: Theme.of(context).colorScheme.background,
                labelColor: Theme.of(context).colorScheme.background,
                unselectedLabelColor: Theme.of(context).colorScheme.onSecondary,
                tabs: const <Widget>[
                  Tab(
                    child: Text(
                      'Cadastro',
                      style: TextStyle(
                        fontFamily: 'BebasKai',
                        fontSize: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                Center(
                  child: Form(
                    key: _formkey,
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: false,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 15.0, bottom: 15.0),
                          child: LoginPhotoField(ImageSourceType.gallery),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 15.0, bottom: 15.0),
                          child: LoginTextFormField(
                            lbl: 'Nome completo:',
                            controller: _nameFormFieldController,
                            validatorFunction: (value) {
                              if (value == null || value.isEmpty) {
                                return emptyValidationFail;
                              } else if (Validate.isUsername(value)) {
                                return 'Insira um nome válido.';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 15.0, bottom: 15.0),
                          child: MaskedLoginTextFormField(
                              lbl: 'CPF:',
                              controller: _cpfFormFieldController,
                              maskFormatter: MaskTextInputFormatter(
                                  mask: '###.###.###-##',
                                  filter: {"#": RegExp(r'[0-9]')},
                                  type: MaskAutoCompletionType.lazy),
                              validatorFunction: (value) {
                                if (value == null || value.isEmpty) {
                                  return emptyValidationFail;
                                }
                                //vamos inserir isso depois de conseguirmos implementar a validação de CPF.
                                // else if(Validate.isEmail(email)){
                                //   return 'Insira um CPF válido.';
                                // }
                                return null;
                              }),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 15.0, bottom: 15.0),
                          child: LoginTextFormField(
                            lbl: 'E-mail:',
                            controller: _emailFormFieldController,
                            validatorFunction: (value) {
                              if (value == null || value.isEmpty) {
                                return emptyValidationFail;
                              } else if (Validate.isEmail(value)) {
                                return 'Insira um e-mail válido.';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 15.0, bottom: 15.0),
                          child: MaskedLoginTextFormField(
                              lbl: 'Telefone:',
                              controller: _phoneFormFieldController,
                              maskFormatter: MaskTextInputFormatter(
                                  mask: '(##) #####-####',
                                  filter: {"#": RegExp(r'[0-9]')},
                                  type: MaskAutoCompletionType.lazy),
                              validatorFunction: (value) {
                                if (value == null || value.isEmpty) {
                                  return emptyValidationFail;
                                }
                                return null;
                              }),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 15.0, bottom: 15.0),
                          child: AddressPickerFormField(
                            lbl: 'Endereço (CEP por enquanto):',
                            controller: _addressFormFieldController,
                            validatorFunction: (value) {
                              if (value == null || value.isEmpty) {
                                return emptyValidationFail;
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 15.0, bottom: 15.0),
                          child: LoginPasswordFormField(
                            lbl: 'Senha:',
                            controller: _passwordFormFieldController,
                            validatorFunction: (value) {
                              if (value == null || value.isEmpty) {
                                return emptyValidationFail;
                              } else if (!Validate.isPassword(value)) {
                                /// Min 6 and Max 12 characters
                                /// At least one uppercase character
                                /// At least one lowercase character
                                /// At least one number
                                /// At least one special character
                                /// como demonstrar esses requisitos para o usuário?
                                return 'Insira uma senha válida.';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 15.0, bottom: 15.0),
                          child: LoginPasswordFormField(
                            lbl: 'Confirme a Senha:',
                            controller: _confirmPasswordFormFieldController,
                            validatorFunction: (value) {
                              if (value == null || value.isEmpty) {
                                return emptyValidationFail;
                              } else if (_passwordFormFieldController.text !=
                                  _confirmPasswordFormFieldController.text) {
                                return 'As senhas não coincidem.';
                              } else if (!Validate.isPassword(value)) {
                                /// Min 6 and Max 12 characters
                                /// At least one uppercase character
                                /// At least one lowercase character
                                /// At least one number
                                /// At least one special character
                                /// como demonstrar esses requisitos para o usuário?
                                return 'Insira uma senha válida.';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: ConfirmButtonWidget(
                              lbl: 'Cadastrar', submitFunction: submitData),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
