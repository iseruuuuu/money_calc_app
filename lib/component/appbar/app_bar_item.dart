import 'package:flutter/material.dart';

class AppBarItem extends StatelessWidget {
  const AppBarItem({
    Key? key,
    required this.color,
    this.icon,
  }) : super(key: key);

  final Color color;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(0.0),
      child: AppBar(
        shape: Border(
          bottom: BorderSide(
            color: color,
          ),
        ),
        //backgroundColor: AppColor.red2,
        backgroundColor: color,
        elevation: 0,
        leading: icon,
      ),
    );
  }
}
