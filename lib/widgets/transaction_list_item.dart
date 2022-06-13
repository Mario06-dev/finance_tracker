import 'package:finance_tracker/colors.dart';
import 'package:finance_tracker/constants/categories.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';

class TransListItem extends StatefulWidget {
  final snap;
  /*  final Color color;
  final String title;
  final String description;
  final double amount;
  final IconData icon;
  final Color iconColor; */

  const TransListItem({
    Key? key,
    /* required this.color,
    required this.title,
    required this.description,
    required this.amount,
    required this.icon,
    required this.iconColor, */
    required this.snap,
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
            backgroundColor: Colors.grey[100],
            child: Icon(
              categories
                  .where(
                      (category) => category.title == widget.snap['category'])
                  .toList()
                  .first
                  .icon,
              size: 16,
              color: categories
                  .where(
                      (category) => category.title == widget.snap['category'])
                  .toList()
                  .first
                  .color,
            ),
          ),
          /* Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
            ),
          ), */
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.snap['category'],
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: blackTextColor,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                widget.snap['description'],
                style: const TextStyle(
                  fontWeight: FontWeight.w100,
                  fontSize: 12,
                  color: textColor,
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            widget.snap['isExpense'] == true
                ? '- ${widget.snap['amount'].toStringAsFixed(2)} kn'
                : '+ ${widget.snap['amount'].toStringAsFixed(2)} kn',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: widget.snap['isExpense'] == true
                  ? blackTextColor
                  : Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}
