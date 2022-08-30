/* 

    Calucations for Balance Trend chart

 */

import 'package:finance_tracker/widgets/charts/balance_trend_chart.dart';

import '../../models/transaction_model.dart';

class BalanceTrendCalc {
  List<BalanceTrendData> getChartData(
      List<TransactionModel> transactions, int timeFilter) {
    List<BalanceTrendData> chartData = [];
    double netSumDay = 0.0;

    transactions.sort((a, b) {
      return a.date.compareTo(b.date);
    });

    // 1. Loopati kroz transakcije
    // 2. Naci ukupni net svakog dana, mjeseca ili određenog perioda i spremiti u amount clan liste
    // 3. Uzeti datum i spremiti ga u date clan liste

    // Last 7 days: Today skroz desno.....sljedecih 6 dana lijevo
    // Last 30 days: Today skorz desno.....svakih 5 dana manje lijevo

    print(transactions.length);
    for (int i = 0; i <= transactions.length - 1; i++) {
      // Last 7 days filter seleccted
      if (timeFilter == 0) {
        if (i != 0) {
          if ((transactions[i].date.month == transactions[i - 1].date.month) &&
              (transactions[i].date.day == transactions[i - 1].date.day)) {
            netSumDay = transactions[i].amount + transactions[i - 1].amount;
            print(netSumDay);
            chartData
                .add(BalanceTrendData(netSumDay, transactions[i - 1].date));
            chartData[chartData.indexWhere((data) =>
                    (data.date.day == transactions[i].date.day &&
                        data.date.month == transactions[i].date.month))] =
                BalanceTrendData(netSumDay, transactions[i].date);
          } else {
            //chartData.add(BalanceTrendData(netSumDay, transactions[i].date));
          }
        }
      }

      netSumDay = 0;
    }

    return chartData;
  }
}
