import 'package:flutter/material.dart';
import 'package:money_manager/Add%20Transaction/screen_add_transaction.dart';
import 'package:money_manager/Screens/Home/widgets/bottom_navigation.dart';
import 'package:money_manager/Screens/category/category_add_popup.dart';
import 'package:money_manager/Screens/transactions/sreen_transaction.dart';

import '../../DB/category/category_db.dart';
import '../../Models/Category/category_model.dart';
import '../category/screen_catagory.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);

  final _pages = const [
    ScreenTransaction(),
    ScreenCategory(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Money Manager'),
        centerTitle: false,
        // elevation: 0,
      ),
      body: SafeArea(
          child: ValueListenableBuilder(
        valueListenable: selectedIndexNotifier,
        builder: (BuildContext context, int updatedIndex, _) {
          return _pages[updatedIndex];
        },
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (selectedIndexNotifier.value==0){
            print('add Transaction');
            Navigator.of(context).pushNamed(ScreenAddTransaction.routerName);
          }else{
            showCategoryAddPopup(context);

            // print('add category');
            // final _sample = CategoryModel(
            //   id: DateTime.now().microsecondsSinceEpoch.toString(),
            //   name: 'Travel',
            //   type: CategoryType.expense,
            // );
            // CategoryDB().insertCategory(_sample);


          }

        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: const MoneyManagerBottomNavigation(),
    );
  }
}
