import 'package:finance_tracker/constants/categories.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../colors.dart';
import '../../models/category_model.dart';
import '../../models/transaction_model.dart';
import '../../resources/stats_calc/categories_calc.dart';
import '../../widgets/reports_bar.dart';

class ReportsIndividual extends StatefulWidget {
  String upperCatTitle;
  List<TransactionModel> dbTransactions;

  ReportsIndividual(this.upperCatTitle, this.dbTransactions);

  @override
  State<ReportsIndividual> createState() => _ReportsIndividualState();
}

class _ReportsIndividualState extends State<ReportsIndividual> {
  List<Category> loadedCats = [];

  // Calculation class object
  CategoriesCalc catCalc = CategoriesCalc();

  @override
  void initState() {
    loadedCats = categories
        .where(
            (catModel) => catModel.parentCategoryTitle == widget.upperCatTitle)
        .toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black54,
        elevation: 0,
        backgroundColor: bgColor,
        title: Text(
          widget.upperCatTitle,
          style: GoogleFonts.prompt(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
      ),
      body: Column(
        children: List.generate(
          loadedCats.length,
          (index) {
            return ReportBar(
              color: loadedCats[index].color,
              title: loadedCats[index].title,
              amount: catCalc.getIndividualCategorySum(
                  widget.dbTransactions, loadedCats[index].title),
              isHeading: false,
              isExpense: loadedCats[index].parentCategoryTitle == 'Income'
                  ? false
                  : true,
            );
          },
        ),
      ),
    );
  }
}
