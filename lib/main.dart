// @dart=2.9

import 'package:flutter/material.dart';
import 'package:untitled/config/config.dart';
import 'package:untitled/screen/login_screen.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false, home: HomePage(),
      theme: ThemeData(
        primaryColor: primaryColor,
        brightness: Brightness.light,

      ),


    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginScreen(),
    );
  }
}
