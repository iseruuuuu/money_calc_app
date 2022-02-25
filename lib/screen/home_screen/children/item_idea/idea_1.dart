import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        horizontal: 20.w,
        vertical: 10.w,
      ),
      child: Container(
        height: 60.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(13.w),
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
            SizedBox(width: 20.w),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title + '円',
                    style: TextStyle(
                      fontSize: 40.w,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            isSex
                ? Image.asset('assets/images/5.png')
                : Image.asset('assets/images/4.png'),
            SizedBox(width: 10.w),
          ],
        ),
      ),
    );
  }
}
