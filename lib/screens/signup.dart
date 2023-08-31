
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moveout1/widgets/confirm_button.dart';
import 'package:moveout1/widgets/singup_forms.dart';

enum ImageSourceType { gallery, camera }

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  // final _formKey = GlobalKey<FormState>();
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
      child: SingupTabBar()
    );
  }
}

class SingupTabBar extends StatelessWidget {
  const SingupTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 2,
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
                tabs: <Widget>[
                  Tab(
                    child: Text(
                      'Dados Pessoais',
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Informações Adicionais',
                    ),
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                Center(
                  child: PersonalDataFormListView(),
                ),
                Center(
                  child: AdditionalDataFormListView(),
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: ConfirmButtonWidget(lbl: 'Cadastrar'),
                )
              ),
            ],
          ),
        ],
      ),
    );
  }
}
/*  final String name;
  final String cpf;
  final String phone;
  final String email;
  final String password;
  final String photo;
  final String address;
  final DateTime createdAt;
  final DateTime updatedAt;*/