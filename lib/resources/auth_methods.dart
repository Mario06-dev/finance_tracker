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
    } catch (err) {
      res = err.toString();
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
    } catch (err) {
      res = err.toString();
    }

    return res;
  }
}
