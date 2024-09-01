import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:money_manager/DB/Transaction/transaction_db.dart';
import 'package:money_manager/DB/category/category_db.dart';
import 'package:money_manager/Models/Category/category_model.dart';

import '../../widget/income_Icon.dart';

class ScreenTransaction extends StatelessWidget {
  const ScreenTransaction({super.key});

  @override
  Widget build(BuildContext context) {
    TransactionDB.instance.refresh();
    CategoryDB.instance.refreshUI();
    return ValueListenableBuilder(
      valueListenable: TransactionDB.instance.transactionListNotifier,
      builder: (context, newList, child) {
        if ( newList .isEmpty){
          return  Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.format_list_bulleted_add,size: 100,color: Theme.of(context).colorScheme.tertiary.withOpacity(0.5),),
                SizedBox(height: 20,),
                 Text('Empty List !',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Theme.of(context).colorScheme.secondary),),
                const Text('Add New Transaction'),
              ],
            ),
          );
        }else {
          return ListView.separated(
          padding: const EdgeInsets.all(10),
          itemBuilder: (context, index) {
            final _value = newList[index];
            return Slidable(
              key: Key(_value.id!),
              startActionPane: ActionPane(
                motion: const DrawerMotion(),
                children: [
                  SlidableAction(
                    onPressed: (context) {
                      TransactionDB.instance.deleteTransaction(_value.id!);
                    },
                    autoClose: true,
                    borderRadius: BorderRadius.circular(20),
                    backgroundColor:
                        Theme.of(context).colorScheme.error.withOpacity(0.7),
                    icon: Icons.delete,
                    label: 'Delete',
                  )
                ],
              ),
              child: Card(
                elevation: 0,
                child: ListTile(
                  leading: CircleAvatar(
                    child: IncomeIcon(
                        isIncome: (_value.type == CategoryType.income)
                            ? true
                            : false),
                  ),
                  title: Text(
                    'Rs. ${_value.amount}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('${_value.category.name}'),
                  trailing: Text(parseDate(_value.date)),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(
              height: 10,
            );
          },
          itemCount: newList.length,
        );
        }
      },
    );
  }

  String parseDate(DateTime date) {
    return DateFormat.yMMMd().format(date);

    // final _date = DateFormat.MMMd().format(date);
    // final _splitedDate = _date.split(' ');
    // return '${_splitedDate.last}\n${_splitedDate.first}';

    //  return '${date.day}/${date.month}/${date.year}';
  }
}
