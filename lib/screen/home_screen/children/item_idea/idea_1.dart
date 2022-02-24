import 'package:flutter/material.dart';
import 'package:money_calc_app/constants/app_color.dart';

class Idea1 extends StatelessWidget {
  const Idea1({
    Key? key,
    required this.title,
    required this.day,
  }) : super(key: key);

  final String title;
  final String day;

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 30),
      height: 90,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13),
        boxShadow: const [
          BoxShadow(
            offset: Offset(0, 17),
            blurRadius: 23,
            spreadRadius: -13,
            color: Colors.red,
          ),
        ],
      ),
      child: Row(
        children: [
          //画像を入れる
          Icon(Icons.add),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                Text(day),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
