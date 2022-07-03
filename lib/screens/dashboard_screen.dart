import 'package:finance_tracker/colors.dart';
import 'package:finance_tracker/models/user_model.dart';
import 'package:finance_tracker/providers/user_provider.dart';
import 'package:finance_tracker/resources/auth_methods.dart';
import 'package:finance_tracker/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    //UserModel? user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Dashboard',
      ),
      body: Column(
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
              children: const [
                ColumnItem(titleValue: 25, subtitle: 'transactions added'),
                ColumnItem(titleValue: 3456.89, subtitle: 'spent this month'),
                ColumnItem(titleValue: 70, subtitle: 'workouts compleated'),
              ],
            ),
          ),
        ],
      ),
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
              fontSize: 18.sp,
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
