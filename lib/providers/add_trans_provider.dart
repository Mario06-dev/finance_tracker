import 'package:finance_tracker/models/category_model.dart';
import 'package:flutter/material.dart';

import '../constants/categories.dart';

class AddTransProvider with ChangeNotifier {
  bool _isExpense = true;
  double _amount = 0.0;
  String _description = '';
  DateTime _date = DateTime.now();
  Category _category = categories[1];

  /* ===================== GETTERS ===================== */

  bool get getisExpense => _isExpense;

  double get getAmount => _amount;

  String get getDescription => _description;

  DateTime get getDate => _date;

  Category get getCategory => _category;

  /* ===================== SETTERS ===================== */

  void setisExpense(bool value) {
    _isExpense = value;
    notifyListeners();
  }

  void setAmount(String amount) {
    _amount = double.parse(amount);
    notifyListeners();
  }

  void setDescription(String desc) {
    _description = desc;
    notifyListeners();
  }

  void setDate(DateTime date) {
    _date = date;
    notifyListeners();
  }

  void setCategory(Category category) {
    _category = category;
    notifyListeners();
  }

  /* ===================== FUNCTIONS ===================== */

  void resetValues() {
    _isExpense = true;
    _amount = 0.0;
    _description = '';
    _date = DateTime.now();
    notifyListeners();
  }
}
