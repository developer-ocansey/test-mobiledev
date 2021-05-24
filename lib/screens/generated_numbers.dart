import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NumbersPage extends StatefulWidget {
  NumbersPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _NumbersPageState createState() => _NumbersPageState();
}

class _NumbersPageState extends State<NumbersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
            color: Colors.white
        ),
        backgroundColor: Colors.blueAccent,
        title: Text("Numbers"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('data/' + FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView(
            children: snapshot.data!.docs.map((document) {
              return Container(
                child: Center(child: Text(document['number'])),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
