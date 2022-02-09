import 'package:flutter/material.dart';

class MoneyLabel extends StatelessWidget {
  const MoneyLabel({
    Key? key,
    required this.exp,
    required this.title,
  }) : super(key: key);

  final String title;
  final String exp;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 33,
            color: Colors.black,
          ),
        ),
        Text(
          exp,
          style: const TextStyle(
            fontSize: 33,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
