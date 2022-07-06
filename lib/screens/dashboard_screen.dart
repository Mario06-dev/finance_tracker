import 'package:finance_tracker/resources/filtering_methods.dart';
import 'package:finance_tracker/resources/stats_calc/cash_flow_calc.dart';
import 'package:finance_tracker/resources/stats_calc/reports_calc.dart';
import 'package:finance_tracker/screens/stats_screens/spendings_screen.dart';
import 'package:finance_tracker/widgets/custom_app_bar.dart';
import 'package:finance_tracker/widgets/dashboard_cards/last_records_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../models/transaction_model.dart';
import '../models/user_model.dart';
import '../providers/user_provider.dart';
import '../resources/db_service.dart';
import '../widgets/dashboard_cards/top_expenses_card.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // Filtering Services
  FilteringMethods filtering = FilteringMethods();

  // Reports Services
  ReportsCalc reports = ReportsCalc();

  // CashFlow calc
  CashFlowCalc cashFlowCalc = CashFlowCalc();

  @override
  Widget build(BuildContext context) {
    UserModel? user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Dashboard',
      ),
      body: SingleChildScrollView(
          child: StreamBuilder<List<TransactionModel>>(
        stream: DatabaseServices().getTransactionsStream(user!),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: Text('NO TRANSACTIONSs'),
            );
          }

          final List<TransactionModel> transactions =
              filtering.getFilteredTrans2(
            snapshot.data!,
            1,
            0,
          );

          return Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(width: 1, color: Color(0xffe0dfe7)),
                    bottom: BorderSide(width: 1, color: Color(0xffe0dfe7)),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ColumnItem(
                        titleValue:
                            reports.transactionCount(transactions, true) +
                                reports.transactionCount(transactions, false),
                        subtitle: 'transactions past month'),
                    ColumnItem(
                        titleValue:
                            '${cashFlowCalc.cashFlowTotalCalc(transactions).toStringAsFixed(2)} kn',
                        subtitle: 'past month net balance'),
                    const ColumnItem(
                        titleValue: '-', subtitle: ' example to be added'),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SpendingsScreen()),
                  );
                },
                child: TopExpensesCard(transactions),
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SpendingsScreen()),
                  );
                },
                child: LastRecordsCard(),
              ),
            ],
          );
        },
      )),
    );
  }
}

class ColumnItem extends StatelessWidget {
  final titleValue;
  final subtitle;

  const ColumnItem({Key? key, required this.titleValue, required this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.h,
      decoration: const BoxDecoration(
        border: Border(
          //top: BorderSide(width: 1, color: Color(0xffe0dfe7)),
          //bottom: BorderSide(width: 1, color: Color(0xffe0dfe7)),
          right: BorderSide(width: 1, color: Color(0xffe0dfe7)),
        ),
      ),
      padding: const EdgeInsets.all(15),
      width: MediaQuery.of(context).size.width * 0.33,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titleValue.toString(),
            style: TextStyle(
              fontSize: 16.sp,
              color: Theme.of(context).primaryColor,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            subtitle,
            softWrap: true,
            style: TextStyle(
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    );
  }
}
