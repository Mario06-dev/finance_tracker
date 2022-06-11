import 'package:flutter/material.dart';

class AddTransProvider with ChangeNotifier {
  bool _isExpense = true;
  double _amount = 0.0;
  String _description = '';
  DateTime _date = DateTime.now();

  /* ===================== GETTERS ===================== */

  bool get getisExpense => _isExpense;

  double get getAmount => _amount;

  String get getDescription => _description;

  DateTime get getDate => _date;

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

  /* ===================== FUNCTIONS ===================== */

  void resetValues() {
    _isExpense = true;
    _amount = 0.0;
    _description = '';
    _date = DateTime.now();
    notifyListeners();
  }
}
