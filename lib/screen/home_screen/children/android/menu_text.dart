import 'package:flutter/material.dart';

class MenuText extends StatelessWidget {
  const MenuText({
    Key? key,
    required this.onTap,
    required this.icon,
    required this.text,
  }) : super(key: key);

  final Function() onTap;
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(
            icon,
            size: deviceWidth / 11,
            color: Colors.white,
          ),
          Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: deviceWidth / 15,
            ),
          ),
        ],
      ),
    );
  }
}
