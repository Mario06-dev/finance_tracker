import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_tracker/models/transaction_model.dart';

/* class DatabaseServices {
  Stream<List<TransactionModel>> getTransactionsStream(String uid) {
    return FirebaseFirestore.instance
        .collection('transactions')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => TransactionModel.fromSnap(doc.data()))
            .toList());
  }
}
 */