// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:moveout1/screens/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MoveOut',
      //Day Theme Prototype:
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: Color(0xFF6fa8dc),
        primaryColorDark: Color(0xFF7ca4b7),
        colorScheme: ColorScheme(
          primary: Color(0xFF6fa8dc),
          onPrimary: Color(0xFF7ca4b7),
          secondary: Color(0xFFf1c232),
          onSecondary: Color(0xFFe4b82f),
          background: Color(0xFFffffff),
          onBackground: Color(0xFFeeeeee),
          surface: Color(0xFFfbfbfb),
          onSurface: Color(0xFF000000),
          brightness: Brightness.light,
          error: Color(0xFFBA0027),
          onError: Color(0xFF000000),
        ),
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
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: ConstrainedBox(
          constraints: BoxConstraints(
          minWidth: MediaQuery.of(context).size.width,
          minHeight: MediaQuery.of(context).size.height,
        ),
        child: IntrinsicHeight(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: const <Widget>[
              AuthScreen(),
            ],
          )
        ))
      )
    );
  }
}
