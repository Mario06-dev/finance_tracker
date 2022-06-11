import 'package:finance_tracker/colors.dart';
import 'package:finance_tracker/models/user_model.dart';
import 'package:finance_tracker/resources/firestore_methods.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/add_trans_provider.dart';
import '../../providers/user_provider.dart';
import '../../utils/utils.dart';

class Page6 extends StatefulWidget {
  Page6({Key? key}) : super(key: key);

  @override
  State<Page6> createState() => _Page6State();
}

class _Page6State extends State<Page6> {
  bool _isLoading = false;

  void uploadTransaction(
    String uid,
    bool isExpense,
    double amount,
    // TODO: Add Category field
    DateTime date,
    String description,
  ) async {
    setState(() {
      _isLoading = true;
    });
    try {
      String res = await FirestoreMethods().uploadTransaction(
        uid,
        isExpense,
        amount,
        // TODO: Add Category field
        date,
        description,
      );

      if (res == 'success') {
        print('In SUCCESS');
        setState(() {
          _isLoading = false;
        });
        // ignore: use_build_context_synchronously
        showSnackBar('Transaction Added!', context);
      } else {
        setState(() {
          _isLoading = true;
        });
        // ignore: use_build_context_synchronously
        showSnackBar(res, context);
      }
    } catch (err) {
      showSnackBar(err.toString(), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AddTransProvider>(context);
    final UserModel? user = Provider.of<UserProvider>(context).getUser;

    bool isExpense = provider.getisExpense;
    double amount = provider.getAmount;
    String description = provider.getDescription;
    DateTime date = provider.getDate;

    return GestureDetector(
      onTap: () {
        // Adding transaction to DB
        uploadTransaction(
          user!.uid,
          isExpense,
          amount,
          // TODO: Add Category field
          date,
          description,
        );

        // Resetting values
        Provider.of<AddTransProvider>(context, listen: false).resetValues();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: !_isLoading
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.done_all,
                    color: Colors.white,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Save Transaction',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              )
            : const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
      ),
    );
  }
}
