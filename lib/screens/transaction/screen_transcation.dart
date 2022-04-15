import 'package:flutter/material.dart';
import 'package:money_management_app/models/category/category_model.dart';

import '../../db/transaction/transaction_db.dart';
import '../../models/transcation/transaction_model.dart';
import 'package:intl/intl.dart';

class ScreenTransaction extends StatelessWidget {
  const ScreenTransaction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TransactionDb.instance.getTrancasction();
    return ValueListenableBuilder(
        valueListenable: transactionList,
        builder: (context, List<TransactionModel> myList, _) {
          return ListView.separated(
            itemBuilder: ((context, index) => ListTile(
                  tileColor: myList[index].type == CategoryType.income
                      ? Colors.red[100]
                      : Colors.green[200],
                  title: Text(myList[index].amount.toString()),
                  leading: CircleAvatar(
                      radius: 50,
                      child: Text(
                        myList[index].date,
                        textAlign: TextAlign.center,
                      )),
                  trailing: IconButton(
                    onPressed: () {
                      onDelete(myList[index].id!);
                    },
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                  subtitle: Text(myList[index].purpose),
                )),
            itemCount: myList.length,
            separatorBuilder: ((context, index) => SizedBox(
                  height: 10,
                )),
          );
        });
  }

  onDelete(int id) {
    TransactionDb.instance.onDelete(id);
  }
}
