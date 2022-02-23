// import 'dart:io';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:money_calc_app/constants/app_color.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
// class ContactScreen extends StatefulWidget {
//   const ContactScreen({Key? key}) : super(key: key);
//
//   @override
//   ContactScreenState createState() => ContactScreenState();
// }
//
// class ContactScreenState extends State<ContactScreen> {
//   @override
//   void initState() {
//     super.initState();
//     if (Platform.isAndroid) WebView.platform = AndroidWebView();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: AppColor.red2,
//         title: const Text(
//           'お問い合わせ',
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: 25,
//           ),
//         ),
//       ),
//       body: WebView(
//         initialUrl: 'https://forms.gle/dcJyKYPFPN8wNTdN7',
//         javascriptMode: JavascriptMode.unrestricted,
//       ),
//     );
//   }
// }
