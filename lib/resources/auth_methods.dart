import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AuthMethods {
  //use instance to call multiple function on firebase auth
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //sign up user
  Future<String> SignUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    //Unit8List consume less storage than normal File implementation
    required Uint8List file,
  }) async {
    String res = "Some error occured";

    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty ||
          file != null) {
        //create user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        print(cred.user!.uid);
        //add user to our database
        //user can't be returned as null
        _firestore.collection('user').doc(cred.user!.uid).set({
          'username':username,
          'uid':cred.user!.uid,
          

        }); 
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
