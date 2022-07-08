import 'package:finance_tracker/constants/colors.dart';
import 'package:finance_tracker/screens/stats_screens/cash_flow_screen.dart';
import 'package:finance_tracker/screens/stats_screens/reports_screen.dart';
import 'package:finance_tracker/screens/stats_screens/spendings_screen.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_app_bar.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Statistics',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: const [
            StatsCard(
              title: 'Balance Trend',
              description:
                  'Lorem ipsum dal amore del ilore at sibilis trend in major uniturmumu',
              image: 'bar-graph',
              navScreen: CashFlowScreen(),
            ),
            SizedBox(height: 20),
            StatsCard(
              title: 'Cash Flow',
              description:
                  'Lorem ipsum dal amore del ilore at sibilis trend in major uniturmumu',
              image: 'report',
              navScreen: CashFlowScreen(),
            ),
            SizedBox(height: 20),
            StatsCard(
              title: 'Spendings',
              description:
                  'Lorem ipsum dal amore del ilore at sibilis trend in major uniturmumu',
              image: 'pie-chart',
              navScreen: SpendingsScreen(),
            ),
            SizedBox(height: 20),
            StatsCard(
              title: 'Reports',
              description:
                  'Lorem ipsum dal amore del ilore at sibilis trend in major uniturmumu',
              image: 'report',
              navScreen: ReportsScreen(),
            ),
          ],
        ),
      ),
    );
  }
}

class StatsCard extends StatelessWidget {
  final String title;
  final String description;
  final String image;
  final Widget navScreen;

  const StatsCard({
    Key? key,
    required this.title,
    required this.description,
    required this.image,
    required this.navScreen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        //color: Color(0xfff2f5f3),
        color: Theme.of(context).shadowColor,
        /* gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xfff2f5f3),
            Colors.white,
          ],
        ), */
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.6 - 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  description,
                  style: const TextStyle(
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 15),
                InkWell(
                  child: const Text(
                    'Show details',
                    style: TextStyle(
                      color: primaryColor,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => navScreen),
                    );
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.4 - 20,
            child: Center(
              child: SizedBox(
                //color: Colors.grey,
                width: 80,
                height: 50,
                child: Image.asset('assets/images/$image.png'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
