import 'package:flutter/material.dart';
import 'package:money_calc_app/model/color.dart';

class SettingItem extends StatelessWidget {
  const SettingItem({
    Key? key,
    required this.icon,
    required this.title,
  }) : super(key: key);

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: deviceWidth / 60,
        horizontal: deviceWidth / 50,
      ),
      child: Container(
        color: Colors.black87,
        width: double.infinity,
        height: deviceWidth / 8,
        child: Row(
          children: [
            Icon(
              icon,
              size: deviceWidth / 10,
              color: Colors.white,
            ),
            SizedBox(
              width: deviceWidth / 25,
            ),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: deviceWidth / 20,
              ),
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios_sharp,
              color: AppColor.white,
              size: deviceWidth / 15,
            ),
            SizedBox(
              width: deviceWidth / 50,
            ),
          ],
        ),
      ),
    );
  }
}
