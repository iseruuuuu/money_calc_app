import 'package:flutter/material.dart';
import 'package:money_calc_app/constants/app_color.dart';

class Idea1 extends StatelessWidget {
  const Idea1({
    Key? key,
    required this.title,
    required this.day,
    required this.isSex,
  }) : super(key: key);

  final String title;
  final String day;
  final bool isSex;

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: deviceWidth / 20, vertical: deviceWidth / 70),
      child: Container(
        //height: 90,
        height: deviceWidth / 5,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(13),
          boxShadow: const [
            BoxShadow(
              offset: Offset(0, 17),
              blurRadius: 23,
              spreadRadius: -13,
              color: Colors.black87,
            ),
          ],
        ),
        child: Row(
          children: [
            SizedBox(width: deviceWidth / 20),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text(
                  //   day,
                  //   style: TextStyle(
                  //     fontWeight: FontWeight.normal,
                  //     fontSize: deviceWidth / 25,
                  //     color: Colors.grey,
                  //   ),
                  // ),
                  Text(
                    title + '円',
                    style: TextStyle(
                      fontSize: deviceWidth / 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            //Image.asset('assets/images/1.png'),
            isSex
                ? Image.asset('assets/images/5.png')
                : Image.asset('assets/images/4.png'),
            SizedBox(width: deviceWidth / 30),
          ],
        ),
      ),
    );
  }
}
