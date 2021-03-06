import 'package:flutter/material.dart';
import 'package:money_calc_app/constants/app_color.dart';

class NumberCalcButton extends StatelessWidget {
  final String text;
  final Color fillColor;
  final Color textColor;
  final double textSize;
  final Function() onTap;

  const NumberCalcButton({
    Key? key,
    required this.text,
    required this.fillColor,
    required this.textColor,
    this.textSize = 28,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 0, bottom: 0, right: 0, left: 0),
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.grey2, width: 0.2),
        borderRadius: BorderRadius.circular(200),
        color: fillColor,
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.height / 8,
        height: MediaQuery.of(context).size.height / 8,
        child: Theme(
          data: ThemeData(
            splashColor: Colors.white,
          ),
          child: Material(
            elevation: 0,
            clipBehavior: Clip.hardEdge,
            color: Colors.transparent,
            child: InkWell(
              child: FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                onPressed: onTap,
                child: Text(
                  text,
                  style: TextStyle(
                    color: textColor,
                    fontSize: textSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
