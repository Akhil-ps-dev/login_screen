import 'package:flutter/material.dart';
import 'package:untitled/main.dart';

class People extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: HomePage(),
      appBar: AppBar(
        title: Text("Sync"),

        centerTitle: true,
        backgroundColor: Colors.red,
      ),


    );
  }
}
