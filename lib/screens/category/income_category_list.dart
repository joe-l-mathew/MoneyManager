import 'package:flutter/material.dart';
import 'package:money_management_app/db/category/category_db.dart';

import '../../models/category/category_model.dart';

class IncomeCategoryList extends StatelessWidget {
  const IncomeCategoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: CategoryDb().incomeListNotifier,
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
