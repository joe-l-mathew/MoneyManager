import 'package:flutter/material.dart';
import 'package:money_management_app/screens/home/screen_home.dart';

class MoneyManegerBottomNavigationBar extends StatelessWidget {
  const MoneyManegerBottomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: MyHomePage.currentIndex,
      builder: (context, int index, child) => BottomNavigationBar(
          currentIndex: index,
          onTap: (e) {
            MyHomePage.currentIndex.value = e;
          },
          items: const [
            BottomNavigationBarItem(
                label: "Transaction", icon: Icon(Icons.account_balance)),
            BottomNavigationBarItem(
                icon: Icon(Icons.category), label: "Category")
          ]),
    );
  }
}
