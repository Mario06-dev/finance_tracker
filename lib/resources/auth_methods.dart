import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_tracker/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthMethods {
  // Instance of FirebaseAuth class
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Instance of FirebaseFirestore class
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> signUpUser({
    required String email,
    required String password,
    required String name,
  }) async {
    String res = 'Some error occured';

    try {
      // Check for empty values
      if (email.isNotEmpty || password.isNotEmpty || name.isNotEmpty) {
        // Register the user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        // Creating user model
        UserModel user = UserModel(
          name: name,
          uid: cred.user!.uid,
          email: email,
        );

        // Add user to database
        await _firestore
            .collection('users')
            .doc(cred.user!.uid)
            .set(user.toJson());

        res = 'success';
      }
    } catch (err) {
      res = err.toString();
    }

    return res;
  }
}
