import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class User_Info extends StatefulWidget {
  User_Info({this.us_id, this.bgcol, this.val});
  String? us_id;
  Color? bgcol;
  bool? val;
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
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: widget.val!
                          ? [widget.bgcol!, widget.bgcol!]
                          : [Colors.red, Colors.green, Colors.blue])),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("UserName",
                      style: GoogleFonts.fuzzyBubbles(
                          fontSize: 30, color: widget.bgcol)),
                  Text(docs['Username'],
                      style: GoogleFonts.fuzzyBubbles(fontSize: 30)),
                  Text("Email",
                      style: GoogleFonts.fuzzyBubbles(
                          fontSize: 30, color: widget.bgcol)),
                  Text(docs['Email'],
                      style: GoogleFonts.fuzzyBubbles(fontSize: 30)),
                  Text("User Type",
                      style: GoogleFonts.fuzzyBubbles(
                          fontSize: 30, color: widget.bgcol)),
                  Text(docs['user_type'],
                      style: GoogleFonts.fuzzyBubbles(fontSize: 30))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
