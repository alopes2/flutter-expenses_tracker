import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';
import './chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  const Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0;

      for (var transacation in recentTransactions) {
        var isSameDay = transacation.date.day == weekDay.day &&
            transacation.date.month == weekDay.month &&
            transacation.date.year == weekDay.year;
        if (isSameDay) {
          totalSum += transacation.amount;
        }
      }

      return {'day': DateFormat.E().format(weekDay), 'amount': totalSum};
    }).reversed.toList();
  }

  double get maxSpending {
    return groupedTransactionValues.fold(0.0, (sum, transaction) {
      return sum + transaction['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((transaction) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                  transaction['day'],
                  transaction['amount'],
                  maxSpending == 0.0
                      ? 0.0
                      : (transaction['amount'] as double) / maxSpending),
            );
          }).toList(),
        ),
      ),
    );
  }
}
