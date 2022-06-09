import 'package:finance_tracker/colors.dart';
import 'package:finance_tracker/models/user_model.dart';
import 'package:finance_tracker/providers/user_provider.dart';
import 'package:finance_tracker/widgets/custom_app_bar.dart';
import 'package:finance_tracker/widgets/transaction_list_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecordsScreen extends StatefulWidget {
  const RecordsScreen({Key? key}) : super(key: key);

  @override
  State<RecordsScreen> createState() => _RecordsScreenState();
}

class _RecordsScreenState extends State<RecordsScreen> {
  @override
  Widget build(BuildContext context) {
    UserModel? user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Previous Records',
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: 10,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[400],
                        ),
                      ),
                      const SizedBox(width: 20),
                      Text(
                        'Today, 24 April',
                        style: TextStyle(fontSize: 12, color: Colors.grey[400]),
                      ),
                    ],
                  ),
                ),
                const TransListItem(
                  title: 'Supermaket',
                  color: Colors.blue,
                  description: 'Wolt West',
                  amount: 45.67,
                ),
                const TransListItem(
                  title: 'Restaurant Dining',
                  color: Colors.red,
                  description: 'Riviera restoran',
                  amount: 430.52,
                ),
                const TransListItem(
                  title: 'Taxes',
                  color: Colors.brown,
                  description: 'Porez na dohodak',
                  amount: 98.48,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
