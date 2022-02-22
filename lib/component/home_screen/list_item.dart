import 'package:flutter/material.dart';
import 'package:money_calc_app/constants/app_color.dart';

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
    final deviceWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: deviceWidth / 20, vertical: deviceWidth / 70),
      child: Card(
        elevation: 2,
        color: AppColor.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: AppColor.grey3,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(deviceWidth / 20),
        ),
        child: Row(
          children: [
            SizedBox(width: deviceWidth / 30),
            Text(
              day,
              style: TextStyle(
                fontSize: deviceWidth / 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: deviceWidth / 30),
            Center(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: deviceWidth / 11,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
