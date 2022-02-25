import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingParts2 extends StatelessWidget {
  const SettingParts2({
    Key? key,
    required this.icon,
    required this.text,
    required this.onTap,
    required this.color,
    required this.backgroundColor,
  }) : super(key: key);

  final IconData icon;
  final String text;
  final Function() onTap;
  final Color color;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: deviceWidth / 5,
            height: deviceWidth / 5,
            padding: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: backgroundColor,
              ),
            ),
            child: Icon(
              icon,
              size: deviceWidth / 6,
              color: color,
            ),
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: 10.w,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
