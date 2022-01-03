import 'package:flutter/material.dart';
import 'dart:io';

class AdMob {
  String? getBannerAdUnitId() {
    if (Platform.isAndroid) {
      return null;
    } else if (Platform.isIOS) {
      return '';
    }
    return null;
  }

  double getHeight(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final percent = (height * 0.06).toDouble();
    return percent;
  }
}
