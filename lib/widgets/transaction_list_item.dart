import 'package:finance_tracker/constants/colors.dart';
import 'package:finance_tracker/constants/categories.dart';
import 'package:finance_tracker/models/transaction_model.dart';
import 'package:flutter/material.dart';

class TransListItem extends StatefulWidget {
  final TransactionModel transaction;

  const TransListItem({
    Key? key,
    required this.transaction,
  }) : super(key: key);

  @override
  State<TransListItem> createState() => _TransListItemState();
}

class _TransListItemState extends State<TransListItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          CircleAvatar(
            //backgroundColor: Colors.grey[100],
            backgroundColor: Theme.of(context).shadowColor,
            child: Icon(
              categories
                  .where((category) =>
                      category.title == widget.transaction.category)
                  .toList()
                  .first
                  .icon,
              size: 16,
              color: categories
                  .where((category) =>
                      category.title == widget.transaction.category)
                  .toList()
                  .first
                  .color,
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.transaction.category,
                style: Theme.of(context).textTheme.titleMedium,
                /* style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  //color: blackTextColor,
                ), */
              ),
              const SizedBox(height: 5),
              Text(
                widget.transaction.description,
                style: Theme.of(context).textTheme.labelSmall,
                /* style: const TextStyle(
                  fontWeight: FontWeight.w100,
                  fontSize: 12,
                  color: textColor,
                ), */
              ),
            ],
          ),
          const Spacer(),
          Text(
            widget.transaction.isExpense == true
                ? '- ${widget.transaction.amount.toStringAsFixed(2)} kn'
                : '+ ${widget.transaction.amount.toStringAsFixed(2)} kn',
            style: widget.transaction.isExpense == true
                ? Theme.of(context).textTheme.titleSmall
                : const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Colors.green,
                  ),
          ),
        ],
      ),
    );
  }
}
