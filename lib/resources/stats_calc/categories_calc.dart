/* 
  ==========================================================

  This class contains functions that are used to calculate
  everything about categories.

  CONTENTS:
    1.0 - Sum for upper categories
    2.0 - Sum for individual categories
    3.0 - Percentage for CategoryPctBar

  ==========================================================
*/

import 'dart:collection';

import 'package:finance_tracker/constants/categories.dart';

import '../../models/transaction_model.dart';

class CategoriesCalc {
  /* 
  ====================================
  2.0 Sum for individual categories
  ====================================
*/

  // FNC: -> Returns sum of the individual category for given transactions list
  double getIndividualCategorySum(
      List<TransactionModel> givenTrans, String individCatTitle) {
    double sum = 0.0;

    givenTrans.forEach((transModel) {
      if (transModel.category == individCatTitle) {
        sum = sum + transModel.amount;
      }
    });

    return sum;
  }

  /* 
  ====================================
  3.0 - Percentage for CategoryPctBar
  ====================================
*/

// FNC: -> Returns map of individual categories and coresponding sum values
  LinkedHashMap<String, double?> getCatSumMap(
      List<TransactionModel> transactions) {
    Map<String, double> catSumMap = {};
    double catTotal = 0;

    // Looping through all categories
    for (int i = 0; i < categories.length - 1; i++) {
      if (categories[i].parentCategoryTitle != 'Income') {
        for (int j = 0; j < transactions.length; j++) {
          if (transactions[j].category == categories[i].title) {
            catTotal += transactions[j].amount;
          }
        }

        catSumMap[categories[i].title] = catTotal;
        catTotal = 0;
      }
    }

    // Removing any map entry that has <double> value == 0
    catSumMap.removeWhere((key, value) => value == 0);

    // Here, map is being sorted in descending order and only 3 highest entries are taken
    var sortedKeys = catSumMap.keys.toList(growable: false)
      ..sort((k1, k2) => catSumMap[k2]!.compareTo(catSumMap[k1]!));
    LinkedHashMap<String, double?> sortedMap = LinkedHashMap.fromIterable(
        sortedKeys.take(3),
        key: (k) => k,
        value: (k) => catSumMap[k]);

    /* sortedMap.forEach((key, value) {
      print(key + ' -> ' + value!.toStringAsFixed(2));
    }); */

    return sortedMap;
  }
}
