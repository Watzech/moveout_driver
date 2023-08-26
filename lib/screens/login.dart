// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moveout1/screens/login.dart';

void main() {
  runApp(const AuthScreen());
}

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );
    return Scaffold(
        body: Center(
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/backgrounds/mbl_bg_3.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          minimum: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                child: Image(
                  alignment: Alignment.center,
                  image: AssetImage('assets/images/logos/logo1.png'),
                  fit: BoxFit.fitWidth,
                ),
              ),
              SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.sizeOf(context).width,
                    minWidth: MediaQuery.sizeOf(context).width,
                    maxHeight: MediaQuery.sizeOf(context).height * 0.55,
                    minHeight: MediaQuery.sizeOf(context).height * 0.35,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: Color.fromARGB(255, 111, 168, 220),
                    ),
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextField(
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                width: 1,
                                color: Colors.white,
                              )),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.white, width: 1.0),
                              ),
                              labelText: "E-mail ou CPF:",
                              labelStyle:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ),
                          SizedBox(height: 50),
                          Column(
                            children: [
                              TextField(
                                obscureText: true,
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                    width: 1,
                                    color: Colors.white,
                                  )),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.white, width: 1.0),
                                  ),
                                  labelText: "Senha:",
                                  labelStyle: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                              ),
                              TextButton(
                                onPressed: () {}, 
                                child: 
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      "Esqueci a Senha",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: Colors.white,
                                        decoration: 
                                          TextDecoration.underline,
                                          decorationColor: Colors.white,
                                          decorationThickness: 2,
                                      ),
                                    ),
                                  )
                              )
                            ],
                          ),
                          SizedBox(height: 60),
                          Center(
                              child: FilledButton(
                            onPressed: () {},
                            child: const Text('Entrar'),
                            )
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Text(
                                "Ainda não possui uma conta?",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.white,
                                ),
                              ),
                              TextButton(onPressed: () {}, child: 
                                Text("Cadastre-se",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.amber,
                                    decoration: 
                                      TextDecoration.underline,
                                      decorationColor: Colors.amber,
                                      decorationThickness: 2,
                                  ),
                                )
                              )
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
      ),
    ));
  }
}
