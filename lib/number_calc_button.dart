import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
      margin: EdgeInsets.only(top: 2,bottom: 2,right: 0,left: 0),
      child: SizedBox(
        width: 80,
        height: 80,
        child: Theme(
          data: ThemeData(splashColor: Colors.white),
          child: Material(
            elevation: 0,
            clipBehavior: Clip.hardEdge,
            color: Colors.transparent,
            child: InkWell(
              child: FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius .circular(50),
                ),
                onPressed: () {
                  callback(text);
                  HapticFeedback.selectionClick();
                },
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: textSize,
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
