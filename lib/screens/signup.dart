import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:moveout1/classes/driver.dart';
import 'package:moveout1/classes/vehicle.dart';
import 'package:moveout1/screens/login.dart';
import 'package:moveout1/services/do_login.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:moveout1/widgets/default_button.dart';
import 'package:validation_pro/validate.dart';

import 'package:moveout1/widgets/login_fields.dart';

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

class _SingupTabBarState extends State<SingupTabBar>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  final _signupFormkey = GlobalKey<FormState>();
  final _vehicleFormkey = GlobalKey<FormState>();
  late Driver driverFields;
  late Vehicle vehicleFields;

  final TextEditingController _nameFormFieldController =
      TextEditingController();

  final TextEditingController _cpfFormFieldController = TextEditingController();

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

  final TextEditingController _cnhFormFieldController = TextEditingController();

  final TextEditingController _crlvFormFieldController =
      TextEditingController();

  final TextEditingController _plateFormFieldController =
      TextEditingController();

  final TextEditingController _modelFormFieldController =
      TextEditingController();

  final TextEditingController _brandFormFieldController =
      TextEditingController();

  XFile? photo;
  void _handlePhoto(XFile data) {
    setState(() {
      photo = data;
    });
  }

  void goMap() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AuthScreen()),
    );
  }

  void verifySignupFields() async {
    if (_signupFormkey.currentState!.validate()) {
      var compressedImage = await FlutterImageCompress.compressWithFile(
          photo!.path,
          format: CompressFormat.jpeg,
          quality: 90);

      setState(() {
        driverFields = Driver(
          name: _nameFormFieldController.text,
          cpf: _cpfFormFieldController.text,
          cnh: _cnhFormFieldController.text,
          phone: _phoneFormFieldController.text,
          email: _emailFormFieldController.text,
          password: _passwordFormFieldController.text,
          address: _addressFormFieldController.text,
          photo: base64Encode(compressedImage!),
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
        _tabController.index = 1;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text(submitValidationFail),
        backgroundColor: Theme.of(context).colorScheme.error,
      ));
    }
  }

  void submitData() async {
    if (_vehicleFormkey.currentState!.validate()) {
      //SIGNUP DE MOTORISTA - Variável _driverFields possui os campos
      // bool signup = await doSignup(name, cpf, phone, email, password,
      //     base64Encode(compressedImage!), address, createdAt, updatedAt);

      // if (signup) {
      //   goMap();
      // } else {
      //   // Verifique suas informações e tente novamente
      // }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text(submitValidationFail),
        backgroundColor: Theme.of(context).colorScheme.error,
      ));
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
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
          bottom: PreferredSize(
            preferredSize: Size(MediaQuery.sizeOf(context).width,
                MediaQuery.sizeOf(context).height * 0.075),
            child: IgnorePointer(
              child: TabBar(
                controller: _tabController,
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
                  Tab(
                    child: Text(
                      'Veículo',
                      style: TextStyle(
                        fontFamily: 'BebasKai',
                        fontSize: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _tabController,
          children: <Widget>[
            Form(
              key: _signupFormkey,
              child: ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: false,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 25.0, right: 25.0, top: 15.0, bottom: 15.0),
                    child: LoginPhotoField(ImageSourceType.gallery,
                        callback: _handlePhoto),
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
                    child: MaskedLoginTextFormField(
                        lbl: 'CNH:',
                        controller: _cnhFormFieldController,
                        maskFormatter: MaskTextInputFormatter(
                            mask: '#########-##',
                            filter: {"#": RegExp(r'[0-9]')},
                            type: MaskAutoCompletionType.lazy),
                        validatorFunction: (value) {
                          if (value == null || value.isEmpty) {
                            return emptyValidationFail;
                          }
                          //vamos inserir isso depois de conseguirmos implementar a validação de CNH.
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
                        } else if (!Validate.isEmail(value)) {
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
                      lbl: 'Endereço:',
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
                    child: DefaultButton(
                      text: 'PRÓXIMO',
                      onPressedFunction: verifySignupFields,
                      fontSize: 28,
                    ),
                  ),
                ],
              ),
            ),
            Form(
              key: _vehicleFormkey,
              child: ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: false,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 25.0, right: 25.0, top: 15.0, bottom: 15.0),
                    child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          border: Border.all(color: Colors.white, width: 2),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                        child: PinCodeTextField(
                          length: 7,
                          obscureText: false,
                          animationType: AnimationType.fade,
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          animationDuration: const Duration(milliseconds: 300),
                          enableActiveFill: true,
                          controller: _plateFormFieldController, 
                          appContext: context,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 25.0, right: 25.0, top: 15.0, bottom: 15.0),
                    child: MaskedLoginTextFormField(
                        lbl: 'CRLV:',
                        controller: _crlvFormFieldController,
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
                        lbl: 'Modelo:',
                        controller: _modelFormFieldController,
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
                        lbl: 'Marca:',
                        controller: _modelFormFieldController,
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
                    padding: const EdgeInsets.all(25.0),
                    child: DefaultButton(
                      text: 'CADASTRAR',
                      onPressedFunction: () {},
                      fontSize: 28,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ]);
  }
}
