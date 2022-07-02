/* 

    Methods for filtering used throughout the app for filtering variuos data.

 */

import '../models/transaction_model.dart';

class FilteringMethods {
  DateTime getFilteredDate(int timeFilter) {
    DateTime filterDate = DateTime.now();
    DateTime today = DateTime.now();
    switch (timeFilter) {

      // 7 Day Time Filter
      case 0:
        filterDate = DateTime(today.year, today.month, today.day - 7);
        return filterDate;

      // 30 Day Time Filter
      case 1:
        filterDate = DateTime(today.year, today.month, today.day - 30);
        return filterDate;

      // 12 Weeks Time Filter
      case 2:
        filterDate = DateTime(today.year, today.month, today.day - 84);
        return filterDate;

      // 6 Months Time Filter
      case 3:
        filterDate = DateTime(today.year, today.month - 6, today.day);
        return filterDate;

      // 1 Year Time Filter
      case 4:
        filterDate = DateTime(today.year - 1, today.month, today.day);
        return filterDate;

      default:
        return DateTime.now();
    }
  }

  bool isTransInType(TransactionModel transaction, int typeFilter) {
    switch (typeFilter) {
      // All Transactions
      case 0:
        return true;
      // Income Transactions
      case 1:
        if (!transaction.isExpense) {
          return true;
        } else {
          return false;
        }
      // Expense Transactions
      case 2:
        if (transaction.isExpense) {
          return true;
        } else {
          return false;
        }
      default:
        return false;
    }
  }

  List<TransactionModel> getFilteredTrans2(
      List<TransactionModel> givenTransactions,
      int timeFilter,
      int typeFilter,
      String searchWord) {
    // Reference filter date -> final date to filter from
    DateTime filterDate = getFilteredDate(timeFilter);

    // Filtered transactions
    List<TransactionModel> filteredTransactions = [];

    for (int i = 0; i < givenTransactions.length; i++) {
      if ((givenTransactions[i].date.isAfter(filterDate)) &&
          (isTransInType(givenTransactions[i], typeFilter))) {
        /* if (searchWord != '') {
          filteredTransactions.add(givenTransactions.firstWhere(
              (element) => element.description.contains(searchWord)));
        } */

        filteredTransactions.add(givenTransactions[i]);
      }
    }
    return filteredTransactions;
  }
}
