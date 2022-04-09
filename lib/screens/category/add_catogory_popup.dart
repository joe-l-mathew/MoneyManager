import 'package:flutter/material.dart';

import '../../db/category/category_db.dart';
import '../../models/category/category_model.dart';

Future<void> addCatogoryPopup(BuildContext context) async {
  final _categoryController = TextEditingController();
  showDialog(
      context: context,
      builder: (ctx) {
        return SimpleDialog(
          title: Text("Add Catogory"),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _categoryController,
                decoration: InputDecoration(
                    hintText: "Add Catogory", border: OutlineInputBorder()),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                RadioButton(
                  holdingValue: CategoryType.income,
                  tittle: "Income",
                ),
                RadioButton(
                  holdingValue: CategoryType.expence,
                  tittle: "Expense",
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {
                    if (_categoryController.text.isNotEmpty) {
                      final _categoryDb = CategoryDb();
                      final _myCatogory = CategoryModel(
                          name: _categoryController.text,
                          type: selectedRadioValue.value!);
                      _categoryDb.insertCategory(_myCatogory);
                    }
                    Navigator.pop(ctx);
                  },
                  child: const Text("Add")),
            )
          ],
        );
      });
}

class RadioButton extends StatelessWidget {
  final String tittle;
  final CategoryType selectedEnum;
  final CategoryType holdingValue;
  const RadioButton(
      {Key? key,
      required this.tittle,
      this.selectedEnum = CategoryType.expence,
      required this.holdingValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedRadioValue,
      builder: (context, CategoryType? value, _) => Row(
        children: [
          Radio<CategoryType>(
              value: holdingValue,
              groupValue: value,
              onChanged: (value) {
                selectedRadioValue.value = value;
              }),
          Text(tittle)
        ],
      ),
    );
  }
}
