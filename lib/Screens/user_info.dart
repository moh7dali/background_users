import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class User_Info extends StatefulWidget {
  User_Info({this.us_id});
  String? us_id;
  @override
  State<User_Info> createState() => _User_InfoState();
}

class _User_InfoState extends State<User_Info> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pop(context);
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.exit_to_app,
              ))
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(widget.us_id)
            .snapshots(),
        builder: (context, snapshot) {
          final docs = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(10),
            child: Center(
              child: Column(
                children: [
                  Text("UserName"),
                  Text(docs['Username']),
                  Text("Email"),
                  Text(docs['Email']),
                  Text("User Type"),
                  Text(docs['user_type'])
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
