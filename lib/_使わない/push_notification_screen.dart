// import 'package:flutter/material.dart';
// import 'package:money_calc_app/component/add_screen/number_calc_button.dart';
// import 'package:money_calc_app/model/color.dart';
// import 'package:get/get.dart';
// import 'package:money_calc_app/screen/push_notificaiton_screen/push_notification_screen_controller.dart';
//
// class PushNotificationScreen extends StatelessWidget {
//   const PushNotificationScreen({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(PushNotificationScreenController(), tag: '');
//     return Scaffold(
//       backgroundColor: AppColor.grey2,
//       appBar: AppBar(
//         backgroundColor: AppColor.red2,
//         title: const Text(
//           '通知設定',
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: 25,
//           ),
//         ),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(top: 50),
//             child: Obx(
//               () => Center(
//                 child: Text(
//                   //登録した日付を登録する。
//                   (controller.selectedDays != 0)
//                       ? '通知：毎月${controller.selectedDays}日'
//                       : '未設定',
//                   style: const TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           const Spacer(),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: <Widget>[
//               NumberCalcButton(
//                 text: '7',
//                 textSize: 40,
//                 fillColor: 0xff424242,
//                 textColor: 0xFF000000,
//                 callback: () {},
//               ),
//               NumberCalcButton(
//                 text: '8',
//                 textSize: 40,
//                 fillColor: 0xff424242,
//                 textColor: 0xFF000000,
//                 callback: () {},
//               ),
//               NumberCalcButton(
//                 text: '9',
//                 textSize: 40,
//                 fillColor: 0xff424242,
//                 textColor: 0xFF000000,
//                 callback: () {},
//               ),
//             ],
//           ),
//           const SizedBox(height: 15),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: <Widget>[
//               NumberCalcButton(
//                 text: '4',
//                 textSize: 40,
//                 fillColor: 0xff424242,
//                 textColor: 0xFF000000,
//                 callback: () {},
//               ),
//               NumberCalcButton(
//                 text: '5',
//                 textSize: 40,
//                 fillColor: 0xff424242,
//                 textColor: 0xFF000000,
//                 callback: () {},
//               ),
//               NumberCalcButton(
//                 text: '6',
//                 textSize: 40,
//                 fillColor: 0xff424242,
//                 textColor: 0xFF000000,
//                 callback: () {},
//               ),
//             ],
//           ),
//           const SizedBox(height: 15),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: <Widget>[
//               NumberCalcButton(
//                 text: '1',
//                 textSize: 40,
//                 fillColor: 0xff424242,
//                 textColor: 0xFF000000,
//                 callback: () {},
//               ),
//               NumberCalcButton(
//                 text: '2',
//                 textSize: 40,
//                 fillColor: 0xff424242,
//                 textColor: 0xFF000000,
//                 callback: () {},
//               ),
//               NumberCalcButton(
//                 text: '3',
//                 textSize: 40,
//                 fillColor: 0xff424242,
//                 textColor: 0xFF000000,
//                 callback: () {},
//               ),
//             ],
//           ),
//           const SizedBox(height: 15),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: <Widget>[
//               NumberCalcButton(
//                 text: '0',
//                 textSize: 35,
//                 fillColor: 0x00000000,
//                 textColor: 0xFF000000,
//                 callback: () {},
//               ),
//             ],
//           ),
//
//           const Spacer(),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               TextButton(
//                 onPressed: () {},
//                 child: const Text(
//                   '削除',
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 25,
//                     color: Colors.black87,
//                   ),
//                 ),
//               ),
//               TextButton(
//                 onPressed: () {},
//                 child: const Text(
//                   '反映',
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 25,
//                     color: Colors.black87,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//
//           const Spacer(),
//           // Expanded(
//           //   flex: 4,
//           //   child: Padding(
//           //     padding: const EdgeInsets.all(8.0),
//           //     child: Center(
//           //       child: SizedBox(
//           //         height: (MediaQuery.of(context).size.height),
//           //         child: GridView.builder(
//           //           gridDelegate:
//           //               const SliverGridDelegateWithFixedCrossAxisCount(
//           //                   crossAxisCount: 5),
//           //           itemCount: controller.amountOfDaysToPresent,
//           //           shrinkWrap: true,
//           //           itemBuilder: (BuildContext context, int index) {
//           //             final date =
//           //                 DateService().constructDateTimeFromDayAndMonth(
//           //               day: (index + 1),
//           //               month: controller.currentMonth,
//           //             );
//           //             return TextButton(
//           //               onPressed: () => controller.onTap(date),
//           //               child: FittedBox(
//           //                 fit: BoxFit.fitWidth,
//           //                 child: Column(
//           //                   children: [
//           //                     Container(
//           //                       width: 100,
//           //                       height: 100,
//           //                       decoration: const BoxDecoration(
//           //                         shape: BoxShape.circle,
//           //                         color: Colors.black12,
//           //                         //TODO 後で色の条件を書く.
//           //                         //   color: (_birthdays.isNotEmpty)
//           //                         //       ? Colors.indigo
//           //                         //       : Colors.transparent,
//           //                       ),
//           //                       child: Center(
//           //                         child: Text(
//           //                           date.day.toString(),
//           //                           style: const TextStyle(
//           //                             fontSize: 50,
//           //                             fontWeight: FontWeight.bold,
//           //                           ),
//           //                         ),
//           //                       ),
//           //                     ),
//           //                   ],
//           //                 ),
//           //               ),
//           //             );
//           //           },
//           //         ),
//           //       ),
//           //     ),
//           //   ),
//           // ),
//         ],
//       ),
//     );
//   }
// }
