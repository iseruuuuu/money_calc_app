import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_calc_app/constants/app_color.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.red2,
        title: const Text(
          'お問い合わせ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      ),
      body: const WebView(
        initialUrl: 'https://forms.gle/dcJyKYPFPN8wNTdN7',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
