import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/models/user_model.dart' as model;
import 'package:flutter_instagram_clone/resources/storage_methods.dart';

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

        String photoUrl = await StorageMethod()
            .uploadImageToFirebase('profilePics', file, false);

        model.UserModel user = model.UserModel(
          username: username,
          uid: cred.user!.uid,
          email: email,
          bio: bio,
          followers: [], //follow is a list of users
          following: [],
          photoUrl: photoUrl,
        );
        //add user to our database
        //user can't be returned as null
        await _firestore
            .collection('user')
            .doc(cred.user!.uid)
            .set(user.toJson());
        res = 'success';
      }

      // } on FirebaseAuthException catch (err) {
      //   //catch email error
      //   if (err.code == 'firebase_auth/invalid-email') {
      //     res = 'The email is badly formatted';
      //   } else if (err.code == 'firebase_auth/weak-password') {
      //     res = 'Password should be at least 6 characters';
      //   }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // logging in
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Error!!";

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "success";
        print(res);
      } else {
        res = "Please enter again!";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {}
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
