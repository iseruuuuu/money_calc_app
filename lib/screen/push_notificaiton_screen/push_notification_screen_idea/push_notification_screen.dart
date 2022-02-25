import 'package:flutter/material.dart';
import 'package:money_calc_app/constants/app_color.dart';
import 'package:get/get.dart';

import '../push_notification_screen_controller.dart';

class PushNotificationScreens extends StatelessWidget {
  const PushNotificationScreens({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PushNotificationScreenController(), tag: '');
    final deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(deviceWidth / 8),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          toolbarHeight: deviceWidth / 8,
          title: Text(
            '通知画面',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: deviceWidth / 16,
              color: Colors.black,
            ),
          ),
          leading: Padding(
            padding: EdgeInsets.only(
              left: deviceWidth / 40,
            ),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              iconSize: deviceWidth / 11,
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Set reminder for \n'
              '  Monthly practice',
              style: TextStyle(
                fontSize: deviceWidth / 10,
                fontWeight: FontWeight.bold,
                color: AppColor.red2,
              ),
            ),
            CircleAvatar(
              backgroundColor: AppColor.red2,
              radius: deviceWidth / 3,
              child: Image.asset('assets/images/7.png'),
            ),

            //TODO ポップのダイアログ
            Obx(
              () => SizedBox(
                width: deviceWidth / 1.5,
                height: deviceWidth / 8,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blueAccent,
                  ),
                  onPressed: () => controller.onTapSelectDate(context),
                  child: Text(
                    (controller.day.value == 0)
                        ? '未設定'
                        : '毎月 ${controller.days.value} 日',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: deviceWidth / 20,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
