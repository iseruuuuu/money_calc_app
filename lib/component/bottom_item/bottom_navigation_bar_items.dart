import 'package:flutter/material.dart';

class BottomNavigationBarItems extends StatelessWidget {
  const BottomNavigationBarItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const BottomAppBar(
      color: Color(0xFFEA6762),
      notchMargin: 10.0,
      shape: AutomaticNotchedShape(
        RoundedRectangleBorder(),
        StadiumBorder(
          side: BorderSide(),
        ),
      ),
      child: SizedBox(height: 45, child: Text('')),
    );
  }
}
