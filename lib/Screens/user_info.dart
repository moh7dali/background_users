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
        bottomNavigationBar: IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              size: 40,
            )),
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: widget.val!
                          ? [widget.bgcol!, widget.bgcol!]
                          : [Colors.red, Colors.green, Colors.blue])),
              child: Padding(
                padding: const EdgeInsets.only(
                    bottom: 200, top: 200, left: 20, right: 20),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(width: 0.5),
                      borderRadius: BorderRadius.all(Radius.circular(30.0))),
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(widget.us_id)
                        .snapshots(),
                    builder: (context, snapshot) {
                      final docs = snapshot.data!;
                      return Column(
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          Text("UserName :",
                              style: GoogleFonts.fuzzyBubbles(
                                  fontSize: 30,
                                  color:
                                      widget.val! ? widget.bgcol : Colors.red)),
                          SizedBox(
                            height: 20,
                          ),
                          Text(docs['Username'],
                              style: GoogleFonts.fuzzyBubbles(fontSize: 30)),
                          SizedBox(
                            height: 20,
                          ),
                          Text("Email :",
                              style: GoogleFonts.fuzzyBubbles(
                                  fontSize: 30,
                                  color: widget.val!
                                      ? widget.bgcol
                                      : Colors.green)),
                          SizedBox(
                            height: 20,
                          ),
                          Text(docs['Email'],
                              style: GoogleFonts.fuzzyBubbles(fontSize: 30)),
                          SizedBox(
                            height: 20,
                          ),
                          Text("User Type :",
                              style: GoogleFonts.fuzzyBubbles(
                                  fontSize: 30,
                                  color: widget.val!
                                      ? widget.bgcol
                                      : Colors.blue)),
                          SizedBox(
                            height: 20,
                          ),
                          Text(docs['user_type'],
                              style: GoogleFonts.fuzzyBubbles(fontSize: 30)),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
