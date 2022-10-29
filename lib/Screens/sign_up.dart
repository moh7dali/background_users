import 'package:background_users/Screens/sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Sign_up extends StatefulWidget {
  const Sign_up({super.key});

  @override
  State<Sign_up> createState() => _Sign_upState();
}

class _Sign_upState extends State<Sign_up> {
  String us_id = "";
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController username = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: Text('Background Users',
                        style: GoogleFonts.prata(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: Colors.orange))),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 90.0, right: 20, left: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 1.5),
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    ),
                    height: 400,
                    width: 200,
                    child: Column(
                      children: [
                        Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(10),
                            child: const Text(
                              'Sign Up',
                              style:
                                  TextStyle(fontSize: 30, color: Colors.orange),
                            )),
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: TextField(
                            controller: username,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'User Name',
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: TextField(
                            controller: email,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Email',
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: TextField(
                            obscureText: true,
                            controller: password,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Password',
                            ),
                          ),
                        ),
                        Container(
                            height: 60,
                            width: double.infinity,
                            padding: const EdgeInsets.fromLTRB(10, 12, 10, 0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.orange),
                              child: const Text(
                                'Sign Up',
                              ),
                              onPressed: () async {
                                try {
                                  FirebaseAuth AuthObject =
                                      FirebaseAuth.instance;

                                  UserCredential mysignupcre = await AuthObject
                                      .createUserWithEmailAndPassword(
                                          email: email.text,
                                          password: password.text);
                                  us_id = mysignupcre.user!.uid;

                                  FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(mysignupcre.user!.uid)
                                      .set({
                                    'Username': username.text,
                                    "Email": email.text,
                                    'password': password.text,
                                    'user_type': "",
                                  });
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return Sign_in();
                                    },
                                  ));
                                  email.clear();
                                  username.clear();
                                  password.clear();
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content:
                                              Text("Sorry something wrong")));
                                }
                              },
                            )),
                        Row(
                          children: <Widget>[
                            const Text('alreay have an account ?'),
                            TextButton(
                              child: const Text(
                                'Sign In',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.orange),
                              ),
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return Sign_in();
                                  },
                                ));
                              },
                            )
                          ],
                          mainAxisAlignment: MainAxisAlignment.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )));
  }
}
