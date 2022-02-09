import 'package:flutter/material.dart';
import 'package:money_calc_app/model/color.dart';

class ListItem extends StatelessWidget {
  const ListItem({
    Key? key,
    required this.title,
    required this.day,
  }) : super(key: key);

  final String title;
  final String day;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Card(
        elevation: 2,
        color: AppColor.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: AppColor.grey3,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          leading: Text(
            day,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          title: Center(
            child: Text(
              //TODO 日付を追加したい。
              title,
              style: const TextStyle(
                fontSize: 40,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
