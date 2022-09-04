/* 

    Calucations for Balance Trend chart

 */

import 'package:finance_tracker/widgets/charts/balance_trend_chart.dart';

import '../../models/transaction_model.dart';

class BalanceTrendCalc {
  // FNC -> Returns true if it is the same day
  bool areSameDay(DateTime one, DateTime two) {
    return one.day == two.day && one.month == two.month && one.year == two.year;
  }

  List<BalanceTrendData> getChartData(
      List<TransactionModel> transactions, int timeFilter) {
    List<BalanceTrendData> chartData = [];
    double netSumDay = 0.0;

    // Sortiranje dobivenih transakcija po datumu (prvi je onaj najdalji datum)
    transactions.sort((a, b) {
      return a.date.compareTo(b.date);
    });

    // Koristiti while blok i provjeravati dok god je sljedeci datum jedank kao
    // prethodni, zbrajati vrijednosti te ih spremati u amount član charData polja

    int i = transactions.length - 1;

    // NOTE: Mozda bi trebalo ukomponirat petlju u petlji

    for (int i = 0; i < transactions.length; i++) {
      int j = 0;
      while (areSameDay(transactions[j].date, transactions[j + 1].date) ||
          j > transactions.length) {
        netSumDay = netSumDay + transactions[i].amount;
        j++;
        print(netSumDay);
        // INFINITE LOOP: i se nikad ne poveca unutar while petlje
      }
      chartData.add(BalanceTrendData(netSumDay, transactions[i].date));
      netSumDay = 0;
    }

    //for (int i = 0; i <= transactions.length - 1; i++) {}

    /* for (int i = 0; i <= transactions.length - 1; i++) {
      // Last 7 days filter seleccted
      if (timeFilter == 0) {
        if (i != 0) {
          if ((transactions[i].date.month == transactions[i - 1].date.month) &&
              (transactions[i].date.day == transactions[i - 1].date.day)) {
            netSumDay = transactions[i].amount + transactions[i - 1].amount;
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
    } */

    return chartData;
  }
}
