

import 'package:flutter/material.dart';
import 'package:maniguru/db/category/category_db.dart';
import 'package:maniguru/db/transactions/transaction_db.dart';
import 'package:maniguru/models/transactions/transaction_model.dart';

import '../../models/category/category_model.dart';

class AddTransactions extends StatefulWidget {
  const AddTransactions({super.key});

  static const routeName = 'Add-Transactions';

  @override
  State<AddTransactions> createState() => _AddTransactionsState();
}

class _AddTransactionsState extends State<AddTransactions> {
  DateTime? date;
  CategoryType? _selectedCategoryType;
  categoryModel? _selectedCategoryModel;

  String? CATEGORYID;

  final purposeEditingController = TextEditingController();
  final amountEditingController = TextEditingController();

  @override
  void initState() {
    _selectedCategoryType = CategoryType.income;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Purpose !

              TextFormField(
               
                controller: purposeEditingController,
                decoration: InputDecoration(hintText: 'Purpose',border: OutlineInputBorder()),
              ),
                 
                 SizedBox(height: 10,),
               // Price !
                
              TextFormField(
                keyboardType: TextInputType.number,
                controller: amountEditingController,
                decoration: InputDecoration(hintText: 'Amount',border: OutlineInputBorder()),
              ),

              // Date !

              TextButton.icon(
                onPressed: () async {
                  final _datetemp = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now().subtract(Duration(days: 30)),
                    lastDate: DateTime.now(),
                  );
                  if (_datetemp == null) {
                    return null;
                  } else {
                    setState(() {
                      date = _datetemp;
                    });
                  }
                },
                icon: Icon(Icons.calendar_month),
                label: Text(date == null ? 'select date' : date.toString()),
              ),

              // Category Type !

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
                            CATEGORYID = null;
                          });
                        },
                      ),
                      Text('Income')
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
                            CATEGORYID = null;
                          });
                        },
                      ),
                      Text('Expense')
                    ],
                  ),
                ],
              ),

              DropdownButton(
                hint: Text('Select Category'),
                value: CATEGORYID,
                items: (_selectedCategoryType == CategoryType.income
                        ? categorydb.instance.incomeCategoryNotifier.value
                        : categorydb.instance.expenseCategoryNotifier.value)
                    .map(
                  (e) {
                    return DropdownMenuItem(
                      value: e.id,
                      child: Text(e.name),
                      onTap: () {
                        _selectedCategoryModel = e;
                      },
                    );
                  },
                ).toList(),
                onChanged: (selectedval) {
                  setState(() {
                    CATEGORYID = selectedval;
                  });
                },
              ),
              ElevatedButton(
                onPressed: () {
                  AddTrans();
                },
                child: Text('Submit'),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> AddTrans() async {
    final _purposText = purposeEditingController.text;
    final _amountText = amountEditingController.text;
    if (_purposText.isEmpty) {
      return;
    }
    if (_amountText.isEmpty) {
      return;
    }
    if (CATEGORYID == null) {
      return;
    }
    if (date == null) {
      return;
    }
    if (_selectedCategoryModel == null) {
      return;
    }

    final _parsedamount = double.tryParse(_amountText);
    if (_parsedamount == null) {
      return;
    }

    //_date
    //_selectedCategoryType
    //CATEGORYID

    final _model = transactionModel(
      purpose: _purposText,
      amount: _parsedamount,
      date: date!,
      type: _selectedCategoryType!,
      category: _selectedCategoryModel!,
    );
    await TransactionDB.instance.addTransactions(_model);
    Navigator.of(context).pop();
    TransactionDB.instance.refresh();
  }
}
