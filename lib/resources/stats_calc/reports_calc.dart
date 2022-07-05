import 'package:finance_tracker/constants/categories.dart';

import '../../models/transaction_model.dart';
import 'cash_flow_calc.dart';

CashFlowCalc cashFlow = CashFlowCalc();

class ReportsCalc {
  String getUpperCategory(String lowerCategory) {
    for (int i = 0; i < categories.length; i++) {
      if (categories[i].title == lowerCategory) {
        return categories[i].parentCategoryTitle;
      }
    }
    return '';
  }

  /* -- FUNCTION -- : Returning total amount for individual category for Reports Stats Screen */
  double individualCategoryAmountCalc(
      List<TransactionModel> loadedTransactions, String upperCategory) {
    double upperCatTotal = 0.0;

    for (int i = 0; i < loadedTransactions.length; i++) {
      if (getUpperCategory(loadedTransactions[i].category) == upperCategory) {
        upperCatTotal = upperCatTotal + loadedTransactions[i].amount;
      }
    }
    return upperCatTotal;
  }

  /* -- FUNCTION -- : Returning count of transactions */
  int transactionCount(
      List<TransactionModel> loadedTransactions, bool isExpenseWanted) {
    int incomeTransCount = 0;
    int expenseTransCount = 0;

    for (int i = 0; i < loadedTransactions.length; i++) {
      if (loadedTransactions[i].isExpense == true) {
        expenseTransCount++;
      } else {
        incomeTransCount++;
      }
    }
    if (isExpenseWanted) {
      return expenseTransCount;
    } else {
      return incomeTransCount;
    }
  }

  /* -- FUNCTION -- : Returning average a day value for ReportsScreen Cash flow table */
  double getAverageADay(
      List<TransactionModel> loadedTransactions, bool isExpenseWanted) {
    double averageADay = 0.0;

    // Total number of expenses or income transactions
    int numOfTrans = transactionCount(loadedTransactions, isExpenseWanted);

    // Sum of expense of income transactions
    double sum = getSumOfTransType(loadedTransactions, isExpenseWanted);

    averageADay = sum / numOfTrans;

    return averageADay;
  }

  // FNC -> Returns sum of expenses or income transactions in given transactions list
  double getSumOfTransType(
      List<TransactionModel> loadedTransactions, bool isExpenseWanted) {
    double sum = 0.0;

    loadedTransactions.forEach((trans) {
      if (isExpenseWanted) {
        if (trans.isExpense) {
          sum = sum + trans.amount;
        }
      } else {
        if (!trans.isExpense) {
          sum = sum + trans.amount;
        }
      }
    });

    return sum;
  }

  /* -- FUNCTION -- : Returning average record */
  /* double getAverageRecord(
      List<NewTransactionModel> loadedTransactions, bool isExpenseWanted) {
    double recordAvgExpenseValue = 0.0;
    double recordAvgIncomeValue = 0.0;
    double incomeAvgValue = 0.0;
    double expenseAvgValue = 0.0;

    for (int i = 0; i < loadedTransactions.length; i++) {
        if (isExpenseWanted) {
          expenseAvgValue =
              getAverageAmount(givenTrans, timeFilter, isExpenseWanted);

          if (expenseAvgValue > recordAvgExpenseValue) {
            recordAvgExpenseValue = expenseAvgValue;
          }
        } else {
          incomeAvgValue =
              getAverageAmount(givenTrans, timeFilter, isExpenseWanted);
          if (incomeAvgValue > recordAvgIncomeValue) {
            recordAvgIncomeValue = incomeAvgValue;
          }
        }
      
    }

    return isExpenseWanted ? recordAvgExpenseValue : recordAvgIncomeValue;
  } */

}
