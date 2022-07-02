/* 
    	Transaction model
 */
import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionModel {
  final String transId;
  final String uid;
  final bool isExpense;
  final double amount;
  final String category;
  final DateTime date;
  final String description;

  const TransactionModel({
    required this.transId,
    required this.uid,
    required this.isExpense,
    required this.amount,
    required this.category,
    required this.date,
    required this.description,
  });

  // Converting everything we get form input to object file
  Map<String, dynamic> toJson() => {
        'transId': transId,
        'uid': uid,
        'isExpense': isExpense,
        'amount': amount,
        'category': category,
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
      category: snapshot['category'],
      amount: snapshot['amount'],
      date: snapshot['date'],
      description: snapshot['description'],
    );
  }

  static TransactionModel fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      transId: json['transId'] ?? '',
      uid: json['uid'] ?? '',
      amount: json['amount'].toDouble(),
      category: json['category'],
      description: json['description'],
      date: (json['date'] as Timestamp).toDate(),
      isExpense: json['isExpense'],
    );
  }
}
