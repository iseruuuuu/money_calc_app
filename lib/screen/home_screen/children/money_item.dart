import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_calc_app/constants/app_color.dart';

class MoneyItem extends StatelessWidget {
  const MoneyItem({
    Key? key,
    required this.sumMoney,
    required this.restMoney,
  }) : super(key: key);

  final String sumMoney;
  final String restMoney;

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        color: AppColor.red2,
        border: Border.all(color: AppColor.red2),
        //borderRadius: BorderRadius.circular(0),
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(0),
          topLeft: Radius.circular(0),
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          // vertical: deviceWidth / 30,
          // horizontal: 10,
          vertical: 10.w,
          horizontal: 10.w,
        ),
        child: Card(
          elevation: 20,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: AppColor.white,
              width: 5,
            ),
            borderRadius: BorderRadius.circular(20.w),
          ),
          child: ListTile(
            title: Center(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 15.w, bottom: 10.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          '合計',
                          style: TextStyle(
                            fontSize: 35.w,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          sumMoney + '円',
                          style: TextStyle(
                            fontSize: 35.w,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          '残り',
                          style: TextStyle(
                            fontSize: 35.w,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          restMoney + '円',
                          style: TextStyle(
                            fontSize: 35.w,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
