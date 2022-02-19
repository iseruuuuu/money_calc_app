import 'package:flutter/material.dart';
import 'package:money_calc_app/model/color.dart';

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
    return Container(
      decoration: BoxDecoration(
        color: AppColor.red2,
        border: Border.all(color: AppColor.red2),
        borderRadius: BorderRadius.circular(0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Card(
          elevation: 20,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: AppColor.white,
              width: 5,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: ListTile(
            title: Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          '合計',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width / 11,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          sumMoney + '円',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width / 11,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    // child: MoneyLabel(
                    //   title: '合計',
                    //   exp: sumMoney + '円',
                    // ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          '残り',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width / 11,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          restMoney + '円',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width / 11,
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
