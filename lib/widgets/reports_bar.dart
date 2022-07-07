import 'package:flutter/material.dart';

class ReportBar extends StatelessWidget {
  Color color;
  String title;
  double amount;
  final bool isHeading;
  bool isExpense;

  ReportBar({
    required this.color,
    required this.title,
    required this.amount,
    required this.isHeading,
    required this.isExpense,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          color: isHeading
              ? Colors.grey.withOpacity(0.1)
              : Theme.of(context).scaffoldBackgroundColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              isHeading
                  ? Text(
                      title,
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            fontWeight: FontWeight.normal,
                          ),
                    )
                  : Row(
                      children: [
                        CircleAvatar(radius: 5, backgroundColor: color),
                        const SizedBox(width: 10),
                        Text(
                          title,
                          style:
                              Theme.of(context).textTheme.labelMedium?.copyWith(
                                    fontWeight: FontWeight.normal,
                                  ),
                        ),
                      ],
                    ),
              Row(
                children: [
                  Text(
                    isExpense
                        ? '- ${amount.toStringAsFixed(2)} kn'
                        : '${amount.toStringAsFixed(2)} kn',
                    style: TextStyle(
                      fontSize: 14,
                      color: isExpense
                          ? const Color(0xffEF3E52)
                          : const Color(0xFF129570),
                    ),
                  ),
                  !isHeading
                      ? IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.keyboard_arrow_right,
                          ))
                      : IconButton(
                          icon: const Icon(Icons.keyboard_arrow_right),
                          color: Colors.grey.withOpacity(0),
                          onPressed: () {},
                        ),
                ],
              ),
            ],
          ),
        ),
        Divider(height: 1, color: Colors.grey[200]),
      ],
    );
  }
}
