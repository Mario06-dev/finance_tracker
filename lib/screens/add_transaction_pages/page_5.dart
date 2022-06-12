import 'package:finance_tracker/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../providers/add_trans_provider.dart';

class Page5 extends StatefulWidget {
  PageController pageController;

  Page5({Key? key, required this.pageController}) : super(key: key);

  @override
  State<Page5> createState() => _Page5State();
}

class _Page5State extends State<Page5> {
  showAlertDialog(BuildContext context) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      //title: Text("Choose Date"),
      content: SizedBox(
        width: 300,
        height: 400,
        child: SfDateRangePicker(
          initialSelectedDate: DateTime.now(),
          maxDate: DateTime.now(),
          selectionColor: primaryColor,
          selectionShape: DateRangePickerSelectionShape.rectangle,
          todayHighlightColor: primaryColor,
          showActionButtons: true,
          confirmText: 'Select Date',
          cancelText: 'Cancle',
          monthViewSettings:
              const DateRangePickerMonthViewSettings(firstDayOfWeek: 1),
          onSubmit: (val) {
            if (val is DateTime) {
              Provider.of<AddTransProvider>(context, listen: false)
                  .setDate(val);
              Navigator.of(context).pop();
              widget.pageController.animateToPage(
                4,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeIn,
              );
            }
          },
          onCancel: () {
            Navigator.of(context).pop();
          },
        ),
      ),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showAlertDialog(context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.calendar_month,
              color: Colors.white,
            ),
            SizedBox(height: 10),
            Text(
              'Choose date',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                //letterSpacing: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
