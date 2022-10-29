import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Home({this.us_id});
  String? us_id;
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var un;
  Color? bgcolor;
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(widget.us_id)
        .snapshots()
        .listen((event) {
      setState(() {
        un = event['Username'];
        if (un.toString().toLowerCase() == "red") {
          bgcolor = Colors.red;
        }
        if (un.toString().toLowerCase() == "green") {
          bgcolor = Colors.green;
        }
        if (un.toString().toLowerCase() == "blue") {
          bgcolor = Colors.blue;
        }
        if (un.toString().toLowerCase() == "mixedcolor") {
          bgcolor = Colors.black;
        }
      });
    });
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              icon: Icon(
                Icons.exit_to_app,
              ))
        ],
      ),
      body: Container(
          decoration:
              BoxDecoration(gradient: LinearGradient(colors: [bgcolor!])),
          width: double.infinity,
          child: Text("home")),
    );
  }
}
