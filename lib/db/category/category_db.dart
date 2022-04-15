import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_management_app/models/category/category_model.dart';

const CATEGPRYDBNAME = 'category-db';
ValueNotifier<CategoryType?> selectedRadioValue =
    ValueNotifier(CategoryType.income);

abstract class CategoryDbFuncytions {
  void insertCategory(CategoryModel value);
  Future<List<CategoryModel>> getAllData();
  Future<void> refreshData();
  Future<void> onDelete(int id);
}

class CategoryDb implements CategoryDbFuncytions {
  CategoryDb._internal();
  static final CategoryDb instance = CategoryDb._internal();
  factory CategoryDb() {
    return instance;
  }
  ValueNotifier<List<CategoryModel>> expenceListNotifier = ValueNotifier([]);
  ValueNotifier<List<CategoryModel>> incomeListNotifier = ValueNotifier([]);
  @override
  void insertCategory(CategoryModel value) async {
    final category_db = await Hive.openBox<CategoryModel>(CATEGPRYDBNAME);
    int id = await category_db.add(value);
    value.id = id;
    await category_db.put(id, value);
    refreshData();
  }

  @override
  Future<List<CategoryModel>> getAllData() async {
    final category_db = await Hive.openBox<CategoryModel>(CATEGPRYDBNAME);
    return category_db.values.toList();
  }

  @override
  Future<void> refreshData() async {
    final category_db = await Hive.openBox<CategoryModel>(CATEGPRYDBNAME);
    final _category_list = category_db.values.toList();
    incomeListNotifier.value.clear();
    expenceListNotifier.value.clear();
    await Future.forEach(_category_list, (CategoryModel element) {
      if (element.type == CategoryType.expence) {
        expenceListNotifier.value.add(element);
      } else if (element.type == CategoryType.income) {
        incomeListNotifier.value.add(element);
      }
    });
    incomeListNotifier.notifyListeners();
    expenceListNotifier.notifyListeners();
  }

  @override
  Future<void> onDelete(int id) async {
    final category_db = await Hive.openBox<CategoryModel>(CATEGPRYDBNAME);
    // CategoryModel recivedVal = category_db.get(id)!;
    // recivedVal.isDeleted = true;
    // await category_db.put(id, recivedVal);
    await category_db.delete(id);
    refreshData();
    expenceListNotifier.notifyListeners();
    incomeListNotifier.notifyListeners();
  }
}
