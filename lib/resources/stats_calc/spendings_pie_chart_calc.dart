import 'package:finance_tracker/constants/categories.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../models/transaction_model.dart';

//ReportsCalc reportsCalc = ReportsCalc();

class SpendingsChartCalc {
  /* -- FUNCTION -- : Return upper version of category */
  String getUpperCategory(String lowerCategory) {
    for (int i = 0; i < categories.length; i++) {
      if (categories[i].title == lowerCategory) {
        return categories[i].parentCategoryTitle;
      }
    }
    return '';
  }

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

  /* -- FUNCTION -- : Checking if date is after filteredDate */
  bool isDateInside(TransactionModel loadedTransaction, int timeFilter) {
    DateTime filterDate = getFilteredDate(timeFilter);
    if (loadedTransaction.date.isAfter(filterDate)) {
      return true;
    } else {
      return false;
    }
  }

  /* -- FUNCTION -- : Returns sorted map of upper categories  with sums */
  Map<String, double> getSumCatMap(List<TransactionModel> transactions) {
    Map<String, double> upperCatSumColor = {};

    double catTotal = 0;

    // Getting list of sums of all upper categories
    for (int i = 0; i < parentCategories.length - 1; i++) {
      for (int j = 0; j < transactions.length; j++) {
        if (parentCategories[i] == getUpperCategory(transactions[j].category)) {
          catTotal = catTotal + transactions[j].amount;
        }
      }

      upperCatSumColor[parentCategories[i]] = catTotal;

      catTotal = 0;
    }
    //print(upperCatSumColor);
    for (int i = 0; i <= upperCatSumColor.length; i++) {
      upperCatSumColor.removeWhere((key, value) => value == 0);
    }
    return upperCatSumColor;
  }

  /* -- FUNCTION -- : Returns list of pie chart sections to PieChart */
  List<PieChartSectionData> getSections(
      List<TransactionModel> transactions, int touchIndex) {
    List<PieChartSectionData> sections = [];

    Map<String, double> upperCatSumColor = getSumCatMap(transactions);

    print(upperCatSumColor);

    for (int k = 0; k <= upperCatSumColor.length - 1; k++) {
      sections.add(PieChartSectionData(
        value: upperCatSumColor.values.elementAt(k),
        //color: upperCatSumColor.values.elementAt(k),
        color: ((touchIndex == k) || (touchIndex == -1))
            ? parentCatsAndColors.entries
                .where((mapEntry) =>
                    mapEntry.key == upperCatSumColor.keys.elementAt(k))
                .first
                .value
            : parentCatsAndColors.entries
                .where((mapEntry) =>
                    mapEntry.key == upperCatSumColor.keys.elementAt(k))
                .first
                .value
                .withOpacity(0.6),
        showTitle: false,
        radius: touchIndex == k ? 50 : 40,
      ));
    }

    return sections;
  }

  /* -- FUNCTION -- : Returns sum for clicked upper category pie section */
  double getClickedSum(List<TransactionModel> transactions, int touchedIndex) {
    Map<String, double> sumCatMap = getSumCatMap(transactions);
    List<double> catSums = sumCatMap.values.toList();

    return !touchedIndex.isNegative
        ? catSums[touchedIndex]
        : allTotalSpendings(transactions);
  }

  double allTotalSpendings(List<TransactionModel> transactions) {
    double spendingsSum = 0.0;

    for (int i = 0; i < transactions.length; i++) {
      if (transactions[i].isExpense) {
        spendingsSum += transactions[i].amount;
      }
    }

    return spendingsSum;
  }

  /* -- FUNCTION -- : Returns category name for clicked upper category pie section */
  String getClickedCategory(
      List<TransactionModel> transactions, int touchedIndex) {
    Map<String, double> sumCatMap = getSumCatMap(transactions);
    List<String> catTitles = sumCatMap.keys.toList().toList();

    return !touchedIndex.isNegative ? catTitles[touchedIndex] : 'All';
  }
}
