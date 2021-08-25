import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled/config/config.dart';

class EmailPassSignupScreen extends StatefulWidget {
  const EmailPassSignupScreen({Key? key}) : super(key: key);

  @override
  _EmailPassSignupScreenState createState() => _EmailPassSignupScreenState();
}

class _EmailPassSignupScreenState extends State<EmailPassSignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final Firestore _db = Firestore.instance;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Email Sign Up"),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(top: 40),
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
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
                  _signup();
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
                      "Sign Up Using Email",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _signup() {
    final String emailTXT = _emailController.text.trim();
    final String passwordTXT = _emailController.text;

    if (emailTXT.isNotEmpty && passwordTXT.isNotEmpty) {
_auth.createUserWithEmailAndPassword(
    email: emailTXT,
    password: passwordTXT
).then((user) {

  

_db.collection("users").document(user.user.uid).setData({
  "email": emailTXT,
  "lastseen" : DateTime.now(),
  "signing_method" : user.user.providerId,


});


  showDialog(
    context: context,
    builder: (ctx) {
      return AlertDialog(
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text("Success"),
        content: Text("Sign Up completed , now you can sign in."),
        actions: [
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("ok"),
          ),
        ],
      );
    },
  );
    })
.catchError((e ){
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
            child: Text("ok"),
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
            content: Text("Please provide email and password"),
            actions: [
              FlatButton(
                onPressed: () {
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
}
