import 'package:finance_tracker/colors.dart';
import 'package:finance_tracker/models/user_model.dart';
import 'package:finance_tracker/providers/user_provider.dart';
import 'package:finance_tracker/widgets/transaction_list_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.sort,
            size: 20,
            color: blackTextColor,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              CupertinoIcons.search,
              color: blackTextColor,
            ),
          ),
        ],
        centerTitle: true,
        elevation: 0,
        backgroundColor: bgColor,
        title: Text(
          'All transactions',
          style: GoogleFonts.prompt(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
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
                  margin: const EdgeInsets.only(top: 30, bottom: 25),
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
                      const Text(
                        'Today, 24 April',
                        style: TextStyle(
                          fontSize: 12,
                          color: textColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const TransListItem(
                  icon: Icons.shopping_bag,
                  iconColor: Colors.redAccent,
                  title: 'Supermaket',
                  color: Colors.blue,
                  description: 'Wolt West',
                  amount: 45.67,
                ),
                const TransListItem(
                  iconColor: Colors.blueAccent,
                  icon: Icons.car_crash,
                  title: 'Restaurant Dining',
                  color: Colors.red,
                  description: 'Riviera restoran',
                  amount: 430.52,
                ),
                const TransListItem(
                  iconColor: Colors.greenAccent,
                  icon: Icons.shopping_bag,
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
