import 'package:flutter/material.dart';
import 'package:money_manager/DB/Transaction/transaction_db.dart';
import 'package:money_manager/DB/category/category_db.dart';
import 'package:money_manager/Models/Category/category_model.dart';
import 'package:money_manager/Models/Transactions/transaction_model.dart';

class ScreenAddTransaction extends StatefulWidget {
  static const routerName = 'add-transaction';

  const ScreenAddTransaction({super.key});

  @override
  State<ScreenAddTransaction> createState() => _ScreenAddTransactionState();
}

class _ScreenAddTransactionState extends State<ScreenAddTransaction> {
  DateTime? _selectedDate;
  CategoryType? _selectedCategoryType;
  CategoryModel? _selectedCategoryModel;

  String? _categogryID;

  final _purposeTextEditingController = TextEditingController();
  final _amountTextEditingController = TextEditingController();

  @override
  void initState() {
    _selectedCategoryType = CategoryType.income;
    super.initState();
  }

  /*
Purpose
Date
Amount
income/expense
category type
 */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Transaction'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Purpose
              TextFormField(
                controller: _purposeTextEditingController,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(hintText: 'Purpose'),
              ),

              // Amount
              TextFormField(
                controller: _amountTextEditingController,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(hintText: 'Amount'),
              ),

              // date picker

              Row(
                children: [
                  Text('Date :',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                  TextButton.icon(
                    onPressed: () async {
                      final _selectedDateTemp = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate:
                            DateTime.now().subtract(const Duration(days: 30)),
                        lastDate: DateTime.now(),
                      );
                      if (_selectedDateTemp == null) {
                        return;
                      } else {
                        print(_selectedDateTemp.toString());
                        setState(() {
                          _selectedDate = _selectedDateTemp;
                        });
                      }
                    },
                    label: Text(_selectedDate == null
                        ? 'Select Date'
                        : _selectedDate!.toString()),
                    icon: const Icon(Icons.calendar_today_rounded),
                  ),
                ],
              ),

              // income / Expense
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Radio(
                        value: CategoryType.income,
                        groupValue: _selectedCategoryType,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedCategoryType = CategoryType.income;
                            _categogryID = null;
                          });
                        },
                      ),
                      const Text('Income')
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        value: CategoryType.expense,
                        groupValue: _selectedCategoryType,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedCategoryType = CategoryType.expense;
                            _categogryID = null;
                          });
                        },
                      ),
                      const Text('Expense')
                    ],
                  ),
                ],
              ),

              // Category type
              DropdownButton(
                isExpanded: true,
                hint: const Text('Select Category'),

                // items: const [
                //   DropdownMenuItem(child: Text('data 1'),value: 1,),
                //   DropdownMenuItem(child: Text('data 2'),value: 2,),
                //   DropdownMenuItem(child: Text('data 3'),value: 3,),
                // ],

                value: _categogryID,
                items: (_selectedCategoryType == CategoryType.income
                        ? CategoryDB().incomeCategoryListListener
                        : CategoryDB.instance.expenseCategoryListListener)
                    .value
                    .map((e) {
                  return DropdownMenuItem(
                    value: e.id,
                    child: Text(e.name),
                    onTap: () {
                      _selectedCategoryModel = e;
                    },
                  );
                }).toList(),
                onChanged: (selectedValue) {
                  print(selectedValue);
                  setState(() {
                    _categogryID = selectedValue;
                  });
                },
              ),
              const SizedBox(
                height: 45,
              ),

              // submit button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    addTransaction();
                  },
                  child: const Text('Submit'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> addTransaction() async {
    final _purposeText = _purposeTextEditingController.text;
    final _amountText = _amountTextEditingController.text;
    if (_purposeText.isEmpty) {
      return;
    }
    if (_amountText.isEmpty) {
      return;
    }
    // if (_categogryID == null) {
    //   return;
    // }
    if (_selectedDate == null) {
      return;
    }
    if (_selectedCategoryModel == null) {
      return;
    }
    final _parsedAmount = double.tryParse(_amountText);
    if (_parsedAmount == null) {
      return;
    }
    // _selectedDate;
    // _selectedCategoryType;
    // _categogryID;

    final _model = TransactionModel(
      purpose: _purposeText,
      amount: _parsedAmount,
      date: _selectedDate!,
      type: _selectedCategoryType!,
      category: _selectedCategoryModel!,
    );
    await TransactionDB.instance.addTransaction(_model);
    Navigator.of(context).pop();
    TransactionDB.instance.refresh();
  }
}
