import 'package:firebase_auth/firebase_auth.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class AuthenticationServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future createUser(
      String email, String password, String name, String address) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await FirebaseFirestore.instance
          .collection('users')
          .doc(result.user!.uid)
          .set({
        'name': name,
        'address': address,
        'email': email,
        'password': password,
        'role': 'customer'
      });

      User? user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
    }
  }

  Future userLogin(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      return result.user;
    } catch (e) {
      print(e.toString());
    }
  }
}
