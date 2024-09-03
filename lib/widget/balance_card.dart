import 'package:flutter/material.dart';
import 'package:money_manager/DB/Transaction/transaction_db.dart';
import 'package:money_manager/Models/Category/category_model.dart';

class BalanceCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: TransactionDB.instance.transactionListNotifier,
      builder: (context, transactionList, child) {
        double totalIncome = 0;
        double totalExpense = 0;

        for (var transaction in transactionList) {
          if (transaction.category.type == CategoryType.income) {
            totalIncome += transaction.amount;
          } else if (transaction.category.type == CategoryType.expense) {
            totalExpense += transaction.amount;
          }
        }

        double balance = totalIncome - totalExpense;

        return Card(
          semanticContainer: true,
          elevation: 0,
          margin: EdgeInsets.all(10),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Current Balance',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '₹ ${balance.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 26,
                      color: balance >= 0 ? Colors.green : Colors.red,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
