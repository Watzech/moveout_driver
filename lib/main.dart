// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:moveout1/screens/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MoveOut',
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: Color(0xFF6fa8dc),
        primaryColorDark: Color(0xFF7ca4b7),
        fontFamily: 'Open Sans',
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: AuthScreen(),
      )
    );
  }
}
