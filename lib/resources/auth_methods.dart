import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_tracker/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods {
  // Instance of FirebaseAuth class
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Instance of FirebaseFirestore class
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserModel> getUserDetails() async {
    // User from FirebaseAuth (NOT CUSTOM MODEL USER)
    User currentUser = _auth.currentUser!;
    DocumentSnapshot snap =
        await _firestore.collection('users').doc(currentUser.uid).get();

    return UserModel.fromSnap(snap);
  }

  // Signing out user
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Logging in user
  Future<String> loginUser(
      {required String email, required String password}) async {
    String res = 'Some error occured';

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = 'success';
      } else {
        res = 'Please enter all the fields';
      }
    } on FirebaseAuthException catch (err) {
      switch (err.code) {
        case 'invalid-email':
          res = 'Entered email is not properly formated.';
          break;
        case 'wrong-password':
          res = 'Entered password is not correct.';
          break;
        case 'user-not-found':
          res = 'User with this email does not exist.';
          break;
      }

      res = err.message.toString();
    }
    return res;
  }

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

        // Creating new UserModel
        UserModel user = UserModel(
          name: name,
          uid: cred.user!.uid,
          email: email,
        );

        // Adding newly created user to CloudFirestore DB
        await _firestore
            .collection('users')
            .doc(cred.user!.uid)
            .set(user.toJson());

        res = 'success';
      }
    } on FirebaseAuthException catch (err) {
      switch (err.code) {
        case 'invalid-email':
          res = 'Entered email is not properly formated.';
          break;
        case 'weak-password':
          res =
              'Entered password is too weak. Please provide at least 6 characters.';
          break;
        case 'email-already-in-use':
          res = 'Entered email is already in use.';
          break;
      }

      res = err.message.toString();
    }

    return res;
  }
}
