import 'package:flutter/material.dart';
import 'dart:io';

class AdMob {
  String getBannerAdUnitId() {
    if (Platform.isAndroid) {
      return '';
    } else if (Platform.isIOS) {
     //return 'ca-app-pub-4066682931432506/4038530394';
     return 'ca-app-pub-3940256099942544/2934735716';
    }
    return '';
  }

  double getHeight(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final percent = (height * 0.06).toDouble();
    return percent;
  }
}
