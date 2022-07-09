import 'package:finance_tracker/screens/stats_screens/cash_flow_screen.dart';
import 'package:finance_tracker/screens/stats_screens/reports_screen.dart';
import 'package:finance_tracker/screens/stats_screens/spendings_screen.dart';
import 'package:finance_tracker/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class StatisticsScreenNew extends StatelessWidget {
  const StatisticsScreenNew({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Statistics',
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(10),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CashFlowScreen()),
              );
            },
            child: const StatsCard(
                title: 'Balance Trend', image: 'assets/images/statistics.png'),
          ),
          const StatsCard(
              title: 'Cash Flow', image: 'assets/images/income.png'),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const SpendingsScreen()),
              );
            },
            child: const StatsCard(
                title: 'Spendings', image: 'assets/images/pie-chart-2.png'),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ReportsScreen()),
              );
            },
            child: const StatsCard(
                title: 'Reports', image: 'assets/images/reports.png'),
          ),
        ],
      ),
    );
  }
}

class StatsCard extends StatelessWidget {
  final String title;
  final String image;

  const StatsCard({Key? key, required this.title, required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(height: 25),
            SizedBox(
              height: 50,
              width: 50,
              child: Image.asset(image),
            ),
          ],
        ),
      ),
    );
  }
}
