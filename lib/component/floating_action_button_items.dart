import 'package:flutter/material.dart';

class FloatingActionButtonItems extends StatelessWidget {
  const FloatingActionButtonItems({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 6,
      height: MediaQuery.of(context).size.width / 6,
      child: FloatingActionButton(
        backgroundColor: const Color(0xFFEA6762),
        onPressed: onTap,
        child: const Icon(
          Icons.add,
          size: 40,
        ),
      ),
    );
  }
}
