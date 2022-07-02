import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_tracker/models/user_model.dart';
import '../models/transaction_model.dart';

class DatabaseServices {
  /* -- FUNCTION -- : Returns stream from firestore collection and maps it to TransactionModel custom model */
  Stream<List<TransactionModel>> getTransactionsStream(UserModel user) {
    return FirebaseFirestore.instance
        .collection('transactions')
        .where('uid', isEqualTo: user.uid)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => TransactionModel.fromJson(doc.data()))
            .toList());
  }
}
