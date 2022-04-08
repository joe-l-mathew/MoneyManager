import 'package:flutter/material.dart';
import 'package:money_management_app/screens/category/expense_catagory_list.dart';
import 'package:money_management_app/screens/category/income_category_list.dart';

class ScreenCategory extends StatelessWidget {
  const ScreenCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: const [
          TabBar(
            tabs: [
              Tab(
                text: "INCOME",
              ),
              Tab(
                text: "EXPENCE",
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
                children: [IncomeCategoryList(), ExpenseCategoryList()]),
          )
        ],
      ),
    );
  }
}
