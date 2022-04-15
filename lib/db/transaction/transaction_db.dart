import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_management_app/models/transcation/transaction_model.dart';

import '../../models/category/category_model.dart';

ValueNotifier<CategoryType> selectedCategory =
    ValueNotifier(CategoryType.income);

ValueNotifier<List<TransactionModel>> transactionList = ValueNotifier([]);

const TRANSACTION_DB_NAME = 'transaction_db';

abstract class TransactionDbFunctions {
  void addTransaction(TransactionModel model);
  Future getTrancasction();
  void onDelete(int id);
}

class TransactionDb implements TransactionDbFunctions {
  TransactionDb._internal();
  static final TransactionDb instance = TransactionDb._internal();
  factory TransactionDb() {
    return instance;
  }
  @override
  void addTransaction(TransactionModel model) async {
    print('started');
    final _db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    int newId = await _db.add(model);
    model.id = newId;
    _db.put(newId, model);
    print('Submitted');
  }

  @override
  Future<void> getTrancasction() async {
    final db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    transactionList.value = db.values.toList();
    transactionList.value.sort(
      (a, b) => b.date.compareTo(a.date),
    );
  }

  @override
  void onDelete(int id) async {
    final db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    await db.delete(id);
    getTrancasction();
  }
}
