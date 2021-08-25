// @dart=2.9

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:untitled/config/config.dart';
import 'package:untitled/screen/email_pass_signup.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  final Firestore _db = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(bottom: 80),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 45),
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    color: Color(0x444C3AE3),
                    blurRadius: 30,
                    offset: Offset(10, 10),
                    spreadRadius: 0),
              ]),
              child: Image(
                image: AssetImage("assets/logo_round.png"),
                width: 200,
                height: 200,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Text(
                "Login",
                style: TextStyle(fontSize: 30),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(top: 40),
              child: TextField(
                controller: _emailController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.green
                      )
                    ),
                    labelText: "Email",
                    hintText: "Email here"),
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(top: 10),
              child: TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Password",
                    hintText: "Password here"),
                obscureText: true,
              ),
            ),
            InkWell(
              onTap: () {
                _signIn();
              },
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [primaryColor, secondaryColor],
                    ),
                    borderRadius: BorderRadius.circular(8)),
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: Center(
                  child: Text(
                    "Login with Email",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            FlatButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EmailPassSignupScreen(),
                    ));
              },
              child: Text("Don't have account? Sign-Up here"),
            ),
            Container(
              margin: EdgeInsets.only(top: 30),
              child: Wrap(
                children: [
                  FlatButton.icon(
                    onPressed: () {
                      _signInUsingGoogle();
                    },
                    icon: Icon(
                      FontAwesomeIcons.google,
                      color: Colors.red,
                    ),
                    label: Text(
                      "Sign-In using Google",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  FlatButton.icon(
                    onPressed: () {},
                    icon: Icon(FontAwesomeIcons.apple),
                    label: Text("Sign-In using Apple ID"),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _signIn() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text;

    if (email.isNotEmpty && password.isNotEmpty) {
      _auth.signInWithEmailAndPassword(email: email, password: password).then(
        (user) {

          _db.collection("users").document(user.user.uid).setData({
            "email": email,
            "lastseen": DateTime.now(),
            "signin_method": user.user.providerId,
          });

          showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                title: Text("Done"),
                content: Text("Sign in successful"),
                actions: [
                  FlatButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                    child: Text("cancel"),
                  ),
                ],
              );
            },
          );
        },
      ).catchError((e) {
        showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              title: Text("Error"),
              content: Text("${e.message}"),
              actions: [
                FlatButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: Text("cancel"),
                ),
              ],
            );
          },
        );
      });
    } else {
      showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            title: Text("Error"),
            content: Text("Please provide email and password...."),
            actions: [
              FlatButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: Text("cancel"),
              ),
              FlatButton(
                onPressed: () {
                  _emailController.text = "";
                  _passwordController.text = "";
                  Navigator.of(ctx).pop();
                },
                child: Text("ok"),
              ),
            ],
          );
        },
      );
    }
  }

  void _signInUsingGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final FirebaseUser user =
          (await _auth.signInWithCredential(credential)).user;

      print("signed in" + user.displayName);

      if (user != null) {
        _db.collection("users").document(user.uid).setData({
          "displayName": user.displayName,
          "email": user.email,
          "photoUrl": user.photoUrl,
          "lastseen": DateTime.now(),
          "signin_method": user.providerId,
        });
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            title: Text("Error"),
            content: Text("${e.message}"),
            actions: [
              FlatButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: Text("cancel"),
              ),
            ],
          );
        },
      );
    }
  }
}
