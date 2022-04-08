import 'package:flutter/material.dart';

class ScreenTransaction extends StatelessWidget {
  const ScreenTransaction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: ((context, index) => ListTile(
            title: Text("Rs 100000"),
            leading: CircleAvatar(
                radius: 50,
                child: Text(
                  "12 \n Dec",
                  textAlign: TextAlign.center,
                )),
            subtitle: Text("Travel"),
          )),
      itemCount: 10,
      separatorBuilder: ((context, index) => SizedBox(
            height: 10,
          )),
    );
  }
}
