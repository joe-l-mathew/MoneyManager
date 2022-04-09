import 'package:flutter/material.dart';

import '../../db/category/category_db.dart';
import '../../models/category/category_model.dart';

class ExpenseCategoryList extends StatelessWidget {
  const ExpenseCategoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: CategoryDb().expenceListNotifier,
      builder: (BuildContext context, List<CategoryModel> value, child) =>
          ListView.separated(
        itemBuilder: ((context, index) => ListTile(
              title: Text(value[index].name),
              trailing: IconButton(
                onPressed: () {
                  CategoryDb().onDelete(value[index].id!);
                },
                icon: Icon(Icons.delete),
                color: Colors.red,
              ),
            )),
        separatorBuilder: ((context, index) => SizedBox(
              height: 10,
            )),
        itemCount: value.length,
      ),
    );
  }
}
