import 'package:flutter/material.dart';

class IncomeCategoryList extends StatelessWidget {
  const IncomeCategoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: ((context, index) => ListTile(
            title: Text("Income $index"),
            trailing: IconButton(
              onPressed: () {},
              icon: Icon(Icons.delete),
              color: Colors.red,
            ),
          )),
      separatorBuilder: ((context, index) => SizedBox(
            height: 10,
          )),
      itemCount: 20,
    );
  }
}
