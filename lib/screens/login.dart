// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, avoid_print
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food/screens/admin_btm_bar.dart';
import 'package:food/screens/btm_bar.dart';
import 'package:food/screens/user_registration.dart';
import 'package:food/services/authentication/authentication_services.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _AddFoodState();
}

final AuthenticationServices _auth = AuthenticationServices();

class _AddFoodState extends State<Login> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _usernameController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color(0xffB81736),
                  Color(0xff281537),
                ]),
              ),
              child: const Padding(
                padding: EdgeInsets.only(top: 60.0, left: 22),
                child: Text(
                  'Sign in',
                  style: TextStyle(
                      fontSize: 40,
                      color: Color.fromARGB(255, 219, 216, 216),
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 230.0),
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40)),
                  color: Colors.white,
                ),
                height: double.infinity,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(left: 18.0, right: 18),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                            suffixIcon: Icon(
                              Icons.check,
                              color: Colors.grey,
                            ),
                            label: Text(
                              'Gmail',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xffB81736),
                              ),
                            )),
                      ),
                      TextField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                            suffixIcon: Icon(
                              Icons.visibility_off,
                              color: Colors.grey,
                            ),
                            label: Text(
                              'Password',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xffB81736),
                              ),
                            )),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 70,
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          minimumSize: Size(150, 50),
                          foregroundColor: Color.fromARGB(255, 217, 6, 6),
                          disabledBackgroundColor: Colors.white,
                          side: BorderSide(
                              color: const Color.fromARGB(255, 11, 11, 11),
                              width: 5),
                        ),
                        onPressed: () {
                          login();
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                      SizedBox(
                        height: 180,
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            Text(
                              "Don't have an account?",
                              style: TextStyle(fontSize: 18),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const UserRegistration()),
                                  );
                                },
                                child: Text(
                                  "Sign up here",
                                  style: TextStyle(fontSize: 18),
                                )),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  void login() async {
    User? authResult = await _auth.userLogin(
        _usernameController.text, _passwordController.text);

    if (authResult != null) {
      DocumentSnapshot<Map<String, dynamic>> userSnapshot =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(authResult.uid)
              .get();

      if (userSnapshot.exists) {
        String role = userSnapshot.get('role');

        if (role == 'admin') {
          print("logged in as admin");
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const AdminBottomBarScreen()),
          );
        } else if (role == 'customer') {
          print("logged in as customer");
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const BottomBarScreen()),
          );
        } else {
          print("unknown role");
        }
      } else {
        print("user data not found");
      }
    } else {
      print("login error");
    }
  }
}
