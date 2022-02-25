import 'package:flutter/material.dart';

class SettingParts extends StatelessWidget {
  const SettingParts({
    Key? key,
    required this.icon,
    required this.text,
    required this.onTap,
    required this.color,
  }) : super(key: key);

  final IconData icon;
  final String text;
  final Function() onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: deviceWidth / 4,
            padding: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey.shade200,
            ),
            child: Icon(
              icon,
              size: deviceWidth / 6,
              color: color,
            ),
          ),
          Text(text),
        ],
      ),
    );
  }
}
