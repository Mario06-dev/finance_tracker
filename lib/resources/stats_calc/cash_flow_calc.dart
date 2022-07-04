/* 

    CLASS
    Calculating and giving data to CashFlow Screen for display

 */

import '../../models/transaction_model.dart';

enum CalculationType { total, individual, percentage }

class CashFlowCalc {
  /* -- FUNCTION -- : Helps with filtering transactions */
  double filterHelper(
      List<TransactionModel> loadedTransactions, CalculationType calcType,
      [bool isPctExpense = true]) {
    double totalCashFlowResult = 0.0;
    double individualResult = 0.0;
    DateTime today = DateTime.now();
    DateTime filterDate = DateTime.now();
    double incomeTotal = 0.0;
    double expenseTotal = 0.0;
    double totalSum = 0.0;

    for (int i = 0; i < loadedTransactions.length; i++) {
      if (calcType == CalculationType.total) {
        // Calculating for TOTAL
        if (loadedTransactions[i].isExpense == true) {
          totalCashFlowResult =
              totalCashFlowResult - loadedTransactions[i].amount;
        } else {
          totalCashFlowResult =
              totalCashFlowResult + loadedTransactions[i].amount;
        }
      }
      if (calcType == CalculationType.individual) {
        // Calculating for INDIVIDUAL
        individualResult =
            individualResult + loadedTransactions[i].amount.abs();
      }
      if (calcType == CalculationType.percentage) {
        // Calculating for PERCENTAGE
        if (loadedTransactions[i].isExpense == true) {
          expenseTotal = expenseTotal + loadedTransactions[i].amount.abs();
        } else {
          incomeTotal = incomeTotal + loadedTransactions[i].amount.abs();
        }
      }
    }

    if (calcType == CalculationType.total) {
      return totalCashFlowResult;
    }

    if (calcType == CalculationType.individual) {
      return individualResult;
    }

    if (calcType == CalculationType.percentage) {
      totalSum = expenseTotal + incomeTotal;
      if (isPctExpense) {
        return expenseTotal / totalSum;
      } else {
        return incomeTotal / totalSum;
      }
    }

    return 0;
  }

  /* -- FUNCTION -- : Returning total CashFlow */
  double cashFlowTotalCalc(List<TransactionModel> loadedTransactions) {
    return filterHelper(loadedTransactions, CalculationType.total);
  }

  /* -- FUNCTION -- : Returning individual results for Income or Expense FlowBarChart */
  double cashFlowIndividualCalc(List<TransactionModel> loadedTransactions) {
    return filterHelper(loadedTransactions, CalculationType.individual);
  }

  /* -- FUNCTION -- : Returning percentage values for LineChart */
  double cashFlowPercentCalc(
      List<TransactionModel> loadedTransactions, bool isExpense) {
    return filterHelper(
        loadedTransactions, CalculationType.percentage, isExpense);
    /*double incomeTotal = 0.0;
    double expenseTotal = 0.0;
    double totalSum = 0.0;

    for (int i = 0; i < givenTrans.length; i++) {
      if (givenTrans[i].get('isExpense') == true) {
        expenseTotal = expenseTotal + givenTrans[i].get('amount').abs();
      } else {
        incomeTotal = incomeTotal + givenTrans[i].get('amount').abs();
      }
    }
    totalSum = expenseTotal + incomeTotal;

    if (isExpense) {
      return expenseTotal / totalSum;
    } else {
      return incomeTotal / totalSum;
    }*/
  }
}
