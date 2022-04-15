import 'package:flutter/material.dart';
import 'package:money_management_app/db/category/category_db.dart';
import 'package:money_management_app/models/category/category_model.dart';
import 'package:money_management_app/models/transcation/transaction_model.dart';
import 'package:money_management_app/screens/transaction/screen_add_transaction/selectCategorytype.dart';

import '../../../db/transaction/transaction_db.dart';

class ScreenAddTransaction extends StatefulWidget {
  static final route = "add_transaction";

  ScreenAddTransaction({Key? key}) : super(key: key);

  @override
  State<ScreenAddTransaction> createState() => _ScreenAddTransactionState();
}

class _ScreenAddTransactionState extends State<ScreenAddTransaction> {
  @override
  void initState() {
    CategoryDb.instance.refreshData().then((value) {
      setState(() {});
    });
    super.initState();
  }

  late CategoryModel addTransactionCategoryModel;
  final _purposeController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? selectedDate;
  var dropdownValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: _purposeController,
              decoration: const InputDecoration(
                  hintText: "Purpose", border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: _amountController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Amount",
              ),
            ),
            ValueListenableBuilder(
                valueListenable: selectedCategory,
                builder: (context, CategoryType value, _) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Row(
                            children: [
                              Radio(
                                value: CategoryType.income,
                                groupValue: value,
                                onChanged: (CategoryType? e) {
                                  print(e);
                                  setState(() {
                                    dropdownValue = null;
                                    selectedCategory.value = e!;
                                  });
                                },
                              ),
                              Text("Income")
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                value: CategoryType.expence,
                                groupValue: value,
                                onChanged: (CategoryType? e) {
                                  setState(() {
                                    dropdownValue = null;
                                    selectedCategory.value = e!;
                                  });
                                },
                              ),
                              Text("Expense")
                            ],
                          ),
                        ],
                      ),
                      // SelectCategoryType(
                      //   value: CategoryType.income,
                      //   selectedValue: value,
                      //   text: "Income",
                      // ),
                      // SelectCategoryType(
                      //   value: CategoryType.expence,
                      //   selectedValue: value,
                      //   text: "Expense",
                      // ),
                    ],
                  );
                }),
            TextButton.icon(
              onPressed: () async {
                selectedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now().subtract(Duration(days: 365)),
                  lastDate: DateTime.now(),
                );
                setState(() {});
              },
              icon: Icon(Icons.calendar_today),
              label: selectedDate == null
                  ? Text('Select Date')
                  : Text(selectedDate.toString()),
            ),

            //Select Category
            DropdownButton(
                value: dropdownValue,
                hint: Text("Select Category"),
                onChanged: (e) {
                  setState(() {
                    dropdownValue = e;
                    print(e);
                  });
                },
                items: selectedCategory.value == CategoryType.income
                    ? CategoryDb()
                        .incomeListNotifier
                        .value
                        .map((e) => DropdownMenuItem(
                            onTap: () {
                              addTransactionCategoryModel = e;
                              print(e);
                            },
                            value: e.id,
                            child: Text(e.name)))
                        .toList()
                    : CategoryDb()
                        .expenceListNotifier
                        .value
                        .map((e) => DropdownMenuItem(
                            onTap: () {
                              addTransactionCategoryModel = e;
                              print(e);
                            },
                            value: e.id,
                            child: Text(e.name)))
                        .toList()),
            ElevatedButton(
                onPressed: () {
                  addTransaction(context);
                  print('clicked');
                },
                child: Text("Submit"))
          ],
        ),
      )),
    );
  }

  addTransaction(BuildContext ctx) {
    print('recived');
    if (_purposeController.text.isEmpty || _amountController.text.isEmpty) {
      return;
    }
    print('firstReturen');
    // if (selectedDate == null) {
    //   return;
    // }
    if (addTransactionCategoryModel == null) {
      print('null');
      return;
    }
    print('Second return');
    print('initialized');
    if (selectedDate == null) {
      selectedDate = DateTime.now();
    }
    // var text = '${selectedDate!.year}-$month-$day ${now.hour}:${now.minute}';
    String date = "${selectedDate!.day} \n ${selectedDate!.month}";
    final intAmount = int.tryParse(_amountController.text);
    TransactionModel model = TransactionModel(
        date: date,
        purpose: _purposeController.text,
        amount: intAmount!,
        type: selectedCategory.value,
        model: addTransactionCategoryModel);
    TransactionDb.instance.addTransaction(model);
    TransactionDb.instance.getTrancasction();
    Navigator.pop(ctx);
  }
}
