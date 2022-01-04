import 'package:flutter/material.dart';
import 'package:money_calc_app/model/color.dart';

class ListItem extends StatelessWidget {
  const ListItem({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      const EdgeInsets.symmetric(horizontal: 30),
      child: Card(
        color: AppColor.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: AppColor.grey3,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          title: Center(
            child: Text(
              //TODO 日付を追加したい。
              title,
              style: const TextStyle(
                fontSize: 30,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
