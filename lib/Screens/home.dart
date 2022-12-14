import 'package:background_users/Screens/user_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  Home({this.us_id});
  String? us_id;
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String type = "";
  var un;
  Color bgcolor = Colors.white;
  bool val = true;
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
          val = true;
        }
        if (un.toString().toLowerCase() == "green") {
          bgcolor = Colors.green;
          val = true;
        }
        if (un.toString().toLowerCase() == "blue") {
          bgcolor = Colors.blue;
          val = true;
        }
        if (un.toString().toLowerCase() == "mixedcolor") {
          bgcolor = Colors.purple;
          val = false;
        }
      });
    });
    return Scaffold(
      bottomNavigationBar: IconButton(
          onPressed: () async {
            await FirebaseAuth.instance.signOut();
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.exit_to_app,
            size: 40,
          )),
      body: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: val
                      ? [bgcolor, bgcolor]
                      : [Colors.red, Colors.green, Colors.blue])),
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 50, top: 100, left: 20, right: 20),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 0.5),
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RadioListTile(
                        value: "Admin",
                        groupValue: type,
                        onChanged: (value) {
                          setState(() {
                            FirebaseFirestore.instance
                                .collection('users')
                                .doc(widget.us_id)
                                .update({"user_type": value.toString()});
                            type = value.toString();
                          });
                        },
                        title: Text(
                          "Admin",
                          style: GoogleFonts.audiowide(
                              fontSize: 26,
                              color: Color.fromARGB(179, 0, 0, 0)),
                        ),
                        secondary: Icon(
                          Icons.admin_panel_settings,
                          size: 35,
                        ),
                      ),
                      Divider(
                        thickness: 5,
                        color: Colors.black,
                      ),
                      RadioListTile(
                        value: "User",
                        groupValue: type,
                        onChanged: (value) {
                          setState(() {
                            FirebaseFirestore.instance
                                .collection('users')
                                .doc(widget.us_id)
                                .update({"user_type": value.toString()});
                            type = value.toString();
                          });
                        },
                        title: Text(
                          "User",
                          style: GoogleFonts.audiowide(
                              fontSize: 26,
                              color: Color.fromARGB(179, 0, 0, 0)),
                        ),
                        secondary: Icon(
                          Icons.person,
                          size: 35,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return User_Info(
                        us_id: widget.us_id,
                        bgcol: bgcolor,
                        val: val,
                      );
                    },
                  ));
                },
                icon: Icon(
                  Icons.arrow_forward,
                  color: Color.fromARGB(179, 0, 0, 0),
                  size: 40,
                ),
                label: Text(
                  "User info",
                  style: GoogleFonts.audiowide(
                      fontSize: 30, color: Color.fromARGB(179, 0, 0, 0)),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                ),
              )
            ],
          )),
    );
  }
}
