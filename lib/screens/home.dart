import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:test02/screens/generated_numbers.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _generatedNumber = 0;
  var random = Random();

  void _incrementCounter() {
    setState(() {
      _generatedNumber = random.nextInt(1000);
      FirebaseFirestore.instance
          .collection('data/' + FirebaseAuth.instance.currentUser!.uid)
          .add({
        'number': _generatedNumber,
        'timestamp': DateTime.now().toUtc().millisecondsSinceEpoch,
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NumbersPage(title: 'Saved')));
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Click to generate a new number:',
            ),
            Text(
              '$_generatedNumber',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Generate Number',
        child: Icon(Icons.add),
      ),
    );
  }
}
