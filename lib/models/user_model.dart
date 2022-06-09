/* 
    	User Model for app users
 */
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String email;
  final String uid;
  final String name;

  const UserModel({
    required this.email,
    required this.uid,
    required this.name,
  });

  // Converting everything we get form input to object file
  Map<String, dynamic> toJson() => {
        'email': email,
        'uid': uid,
        'name': name,
      };

  // Take DOcumentSnapshot and return User model
  static UserModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return UserModel(
      email: snapshot['email'],
      uid: snapshot['uid'],
      name: snapshot['name'],
    );
  }
}
