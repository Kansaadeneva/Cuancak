import 'package:flutter/material.dart';
import '../models/transaction.dart';
import '../constants/colors.dart';
  
class TransactionCard extends StatelessWidget {
  final TransactionItem transaction;
  const TransactionCard({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(
          transaction.isIncome ? Icons.arrow_downward : Icons.arrow_upward,
          color: transaction.isIncome ? Colors.green : Colors.red,
        ),
        title: Text(transaction.description),
        subtitle: Text(transaction.date.toIso8601String().substring(0, 10)),
        trailing: Text(
          (transaction.isIncome ? "+ " : "- ") + "Rp ${transaction.amount}",
          style: TextStyle(
            color: transaction.isIncome ? Colors.green : Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
