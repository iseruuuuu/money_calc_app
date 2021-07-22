import 'package:flutter/material.dart';

class OverlayLoadingMolecules extends StatelessWidget {
  OverlayLoadingMolecules({required this.visible});

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
        children: <Widget>[
          const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ],
      ),
    )
   : Container();
  }
}