import 'package:flutter/material.dart';

class NoList extends StatelessWidget {
  const NoList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width / 2,
          height: MediaQuery.of(context).size.width / 2,
          child: Image.asset('assets/images/background.png'),
        ),
        const SizedBox(height: 30),
        Center(
          child: Text(
            '給料の記録がありません',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: deviceWidth / 14,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_circle_outline,
              size: deviceWidth / 12,
              color: Colors.black,
            ),
            Text(
              'で追加してください',
              style: TextStyle(
                fontSize: deviceWidth / 14,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
