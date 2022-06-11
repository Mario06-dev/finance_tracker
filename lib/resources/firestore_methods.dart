import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_tracker/models/transaction_model.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  // FirebaseFirestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Upload transaction to CloudFirestore DB
  Future<String> uploadTransaction(
    String uid,
    bool isExpense,
    double amount,
    // TODO: Add Category field
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
        // TODO: Add Category field part
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
