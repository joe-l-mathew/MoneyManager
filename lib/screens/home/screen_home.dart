import 'package:flutter/material.dart';
import 'package:money_management_app/screens/category/screen_category.dart';
import 'package:money_management_app/screens/home/widgets/bottom_navigation.dart';
import 'package:money_management_app/screens/transaction/screen_transcation.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);
  final List<Widget> _screens = const [
    ScreenTransaction(),
    ScreenCategory(),
  ];
  static ValueNotifier<int> currentIndex = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentIndex,
      builder: (context, int index, _) => Scaffold(
        appBar: AppBar(
          title: Text("Money Manager"),
          centerTitle: true,
        ),
        body: _screens[index],
        bottomNavigationBar: const MoneyManegerBottomNavigationBar(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (index == 0) {
              print("Add Transaction ");
            } else if (index == 1) {
              print("add Category");
            }
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
