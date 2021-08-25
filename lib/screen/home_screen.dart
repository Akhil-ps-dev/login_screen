import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(),
      child: Center(
        child: Column(
          children: [
            Text("hi"),
            RaisedButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              child: Text("LogOUT"),
            )
          ],
        ),
      ),
    );
  }
}
