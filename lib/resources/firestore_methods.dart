import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_tracker/models/transaction_model.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  // FirebaseFirestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /* -- FUNCTION -- : Updating already existing transaction */
  Future<void> updateTransaction(
      TransactionModel givenTransaction, String uid) async {
    try {
      TransactionModel transaction = TransactionModel(
        transId: givenTransaction.transId,
        uid: uid,
        isExpense: givenTransaction.isExpense,
        amount: givenTransaction.amount,
        category: givenTransaction.category,
        date: givenTransaction.date,
        description: givenTransaction.description,
      );

      await _firestore
          .collection('transactions')
          .doc(givenTransaction.transId)
          .update(transaction.toJson());
    } catch (err) {
      print(err.toString());
    }
  }

  Future<void> deleteTransaction(String transId) async {
    try {
      await _firestore.collection('transactions').doc(transId).delete();
    } catch (err) {
      print(err.toString());
    }
  }

  // Upload transaction to CloudFirestore DB
  Future<String> uploadTransaction(
    String uid,
    bool isExpense,
    double amount,
    String category,
    DateTime date,
    String description,
  ) async {
    String res = 'Some error occured!';
    try {
      // Generating transaction id
      String transId = const Uuid().v1();

      TransactionModel transaction = TransactionModel(
        transId: transId,
        uid: uid,
        isExpense: isExpense,
        amount: amount,
        category: category,
        date: date,
        description: description,
      );

      // Setting transaction to DB
      _firestore
          .collection('transactions')
          .doc(transId)
          .set(transaction.toJson());
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
