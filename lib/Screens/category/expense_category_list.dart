import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_manager/DB/category/category_db.dart';
import '../../Models/Category/category_model.dart';
import '../../widget/income_Icon.dart';

class ExpenseCategoryList extends StatelessWidget {
  const ExpenseCategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: CategoryDB().expenseCategoryListListener,
      builder: (BuildContext context, List<CategoryModel> newList, Widget? _) {
        return ListView.builder(
          padding: const EdgeInsets.all(10),
          itemBuilder: (context, index) {
            final category = newList[index];
            return Card(
              elevation: 0,
              child: ListTile(
                leading: const CircleAvatar(
                  child: IncomeIcon(isIncome: false),
                ),
                title: Text(category.name,style: const TextStyle(fontWeight: FontWeight.bold),),
                trailing: IconButton(
                  onPressed: () {
                    CategoryDB.instance.deleteCategory(category.id);
                  },
                  icon: Icon(
                    CupertinoIcons.delete,
                    color: Theme.of(context).colorScheme.error,
                    size: 20,
                  ),
                ),
              ),
            );
          },
          itemCount: newList.length,
        );
      },
    );
  }
}
