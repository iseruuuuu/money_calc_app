import 'package:flutter/material.dart';

class ResetButton extends StatelessWidget {
  const ResetButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: SizedBox(
        width: double.infinity,
        height: 60,
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            primary: Colors.blueAccent,
            onPrimary: Colors.blueAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          child: const Text(
            '記録を今年にする',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.normal,
              fontSize: 17,
            ),
          ),
        ),
      ),
    );
  }
}
