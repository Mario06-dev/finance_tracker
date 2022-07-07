import 'package:finance_tracker/resources/filtering_methods.dart';
import 'package:finance_tracker/widgets/transaction_list_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/transaction_model.dart';
import '../../models/user_model.dart';
import '../../providers/user_provider.dart';
import '../../resources/db_service.dart';

class LastRecordsCard extends StatefulWidget {
  @override
  State<LastRecordsCard> createState() => _LastRecordsCardState();
}

class _LastRecordsCardState extends State<LastRecordsCard> {
  FilteringMethods filtering = FilteringMethods();

  @override
  Widget build(BuildContext context) {
    // Getting current logged in user
    UserModel? user = Provider.of<UserProvider>(context).getUser;

    return Container(
      padding: const EdgeInsets.all(15),
      width: double.infinity,
      /* decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: Offset(0, 0), // changes position of shadow
          ),
        ],
      ), */
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Last records',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Icon(
                Icons.chevron_right,
                color: Theme.of(context).primaryColor,
                size: 30,
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            //color: Colors.grey.withOpacity(0.2),
            width: double.infinity,
            height: 300,
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

                  // Sort transactions by date
                  transactions.sort((a, b) {
                    return b.date.compareTo(a.date);
                  });

                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return TransListItem(
                        transaction: transactions[index],
                      );
                    },
                  );
                }),
          ),
        ],
      ),
    );
  }
}
