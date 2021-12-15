import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../model/color.dart';

class NumberCalcButton extends StatelessWidget {
  final String text;
  final int fillColor;
  final int textColor;
  final double textSize;
  final Function callback;

  const NumberCalcButton({
    Key? key,
    required this.text,
    required this.fillColor,
    this.textColor = 0xFFFFFFFF,
    this.textSize = 28,
    required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 2, bottom: 2, right: 0, left: 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(70),
        color: AppColor.grey3,
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 4.5,
        height: MediaQuery.of(context).size.width / 4.5,
        child: Theme(
          data: ThemeData(splashColor: Colors.white),
          child: Material(
            elevation: 0,
            clipBehavior: Clip.hardEdge,
            color: Colors.transparent,
            child: InkWell(
              child: FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                onPressed: () {
                  callback(text);
                  HapticFeedback.selectionClick();
                },
                child: Text(
                  text,
                  style: TextStyle(
                    color: Colors.black,
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
