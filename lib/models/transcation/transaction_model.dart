import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_management_app/models/category/category_model.dart';
part 'transaction_model.g.dart';

@HiveType(typeId: 3)
class TransactionModel {
  @HiveField(0)
  final String purpose;
  @HiveField(1)
  final int amount;
  @HiveField(2)
  final CategoryType type;
  @HiveField(3)
  final CategoryModel model;
  @HiveField(4)
  int? id;
  @HiveField(5)
  final String date;
  TransactionModel(
      {required this.date,
      required this.purpose,
      required this.amount,
      required this.type,
      required this.model,
      this.id = null});
}
