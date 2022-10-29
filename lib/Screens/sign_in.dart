import 'package:background_users/Screens/home.dart';
import 'package:background_users/Screens/sign_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Sign_in extends StatefulWidget {
  const Sign_in({super.key});

  @override
  State<Sign_in> createState() => _Sign_inState();
}

class _Sign_inState extends State<Sign_in> {
  String us_id = "";
  TextEditingController nameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
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
                            color: Colors.blue))),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 90.0, right: 20, left: 20),
                  child: Container(
                    width: 200,
                    height: 400,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1.5),
                      borderRadius: BorderRadius.all(Radius.circular(
                              30.0) //                 <--- border radius here
                          ),
                    ),
                    child: Column(
                      children: [
                        Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(10),
                            child: const Text(
                              'Sign In',
                              style: TextStyle(fontSize: 30),
                            )),
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: TextField(
                            controller: nameController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'User Name',
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: TextField(
                            obscureText: true,
                            controller: passwordController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Password',
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            //forgot password screen
                          },
                          child: const Text(
                            'Forgot Password',
                          ),
                        ),
                        Container(
                            height: 50,
                            width: double.infinity,
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: ElevatedButton(
                              child: const Text('Login'),
                              onPressed: () async {
                                try {
                                  FirebaseAuth AuthObject =
                                      FirebaseAuth.instance;

                                  UserCredential mysignupcre = await AuthObject
                                      .signInWithEmailAndPassword(
                                          email: nameController.text,
                                          password: passwordController.text);
                                  us_id = mysignupcre.user!.uid;
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return Home(us_id: us_id);
                                    },
                                  ));
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
                            const Text("Don't have an account ?"),
                            TextButton(
                              child: const Text(
                                'Sign Up',
                                style: TextStyle(fontSize: 20),
                              ),
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return Sign_up();
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
