import 'package:flutter/material.dart';

class RowItem extends StatelessWidget {
  RowItem({super.key, required this.menuName, required this.price});

  String menuName;
  double price;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(menuName),
        Text(price.toString()),
      ],
    );
  }
}
