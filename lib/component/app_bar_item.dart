import 'package:flutter/material.dart';

class AppBarItem extends StatelessWidget {
  const AppBarItem({
    Key? key,
    required this.color,
  }) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(0.0),
      child: AppBar(
        //backgroundColor: AppColor.red2,
        backgroundColor: color,
        elevation: 0,
      ),
    );
  }
}
