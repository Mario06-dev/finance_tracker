import 'package:finance_tracker/colors.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';

class TransListItem extends StatelessWidget {
  final Color color;
  final String title;
  final String description;
  final double amount;
  final IconData icon;
  final Color iconColor;

  const TransListItem({
    Key? key,
    required this.color,
    required this.title,
    required this.description,
    required this.amount,
    required this.icon,
    required this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey[100],
            child: Icon(
              icon,
              size: 16,
              color: iconColor,
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
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: blackTextColor,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                description,
                style: const TextStyle(
                  fontWeight: FontWeight.w100,
                  fontSize: 12,
                  color: textColor,
                ),
              ),
            ],
          ),
          Spacer(),
          Text(
            '- ${amount.toString()}',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
