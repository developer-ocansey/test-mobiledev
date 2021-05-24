import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  _signInAnonymously() async {
    FirebaseAuth.instance.signInAnonymously();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(      leading: BackButton(
          color: Colors.white
      ),
          title: Text('Sign in')),
      body: Center(
        child: ElevatedButton(
          child: Text('Sign in anonymously'),
          onPressed: _signInAnonymously,
        ),
      ),
    );
  }
}
