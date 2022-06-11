/* 
    	Transaction model
 */
import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionModel {
  final String transId;
  final String uid;
  final bool isExpense;
  final double amount;
  // TODO: Add Category field
  final DateTime date;
  final String description;

  const TransactionModel({
    required this.transId,
    required this.uid,
    required this.isExpense,
    required this.amount,
    // TODO: Add Category field part
    required this.date,
    required this.description,
  });

  // Converting everything we get form input to object file
  Map<String, dynamic> toJson() => {
        'transId': transId,
        'uid': uid,
        'isExpense': isExpense,
        'amount': amount,
        // TODO: Add Category field part
        'date': date,
        'description': description,
      };

  // Take DocumentSnapshot and return TransactionModel
  static TransactionModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return TransactionModel(
      transId: snapshot['transId'],
      uid: snapshot['uid'],
      isExpense: snapshot['isExpense'],
      // TODO: Add Category field part
      amount: snapshot['amount'],
      date: snapshot['date'],
      description: snapshot['description'],
    );
  }
}
