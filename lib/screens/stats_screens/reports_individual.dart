import 'package:finance_tracker/constants/categories.dart';
import 'package:finance_tracker/screens/individual_records_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
        elevation: 0,
        title: Text(
          widget.upperCatTitle,
          style: GoogleFonts.prompt(
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: List.generate(
            loadedCats.length,
            (index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => IndividualRecordsScreen(
                              givenCategory: loadedCats[index].title,
                              dbTransactions: widget.dbTransactions,
                            )),
                  );
                },
                child: ReportBar(
                  color: loadedCats[index].color,
                  title: loadedCats[index].title,
                  amount: catCalc.getIndividualCategorySum(
                      widget.dbTransactions, loadedCats[index].title),
                  isHeading: false,
                  isExpense: loadedCats[index].parentCategoryTitle == 'Income'
                      ? false
                      : true,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
