import 'package:flutter/material.dart';

class OverlayLoadingMolecules extends StatelessWidget {
  const OverlayLoadingMolecules({
    Key? key,
    required this.visible,
  }) : super(key: key);

  final bool visible;

  @override
  Widget build(BuildContext context) {
    return visible ? Container(
      decoration: const BoxDecoration(
        color: Color.fromRGBO(0, 0, 0, 0.6,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ],
      ),
    )
        : Container();
  }
}