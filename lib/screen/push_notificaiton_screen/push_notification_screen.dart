import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:money_calc_app/component/add_screen/number_calc_button.dart';
import 'package:money_calc_app/model/color.dart';
import 'package:get/get.dart';
import 'package:money_calc_app/screen/push_notificaiton_screen/push_notification_screen_controller.dart';

import 'children/numberButton.dart';

class PushNotificationScreen extends StatelessWidget {
  const PushNotificationScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PushNotificationScreenController(), tag: '');
    final deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [
            Image.asset(
              "assets/background.gif",
              fit: BoxFit.fill,
              height: double.infinity,
              width: double.infinity,
              scale: 1,
            ),
            SafeArea(
              child: Center(
                child: GlassmorphicContainer(
                  width: MediaQuery.of(context).size.width - 20,
                  height: MediaQuery.of(context).size.height - 70,
                  borderRadius: 20,
                  blur: 10,
                  alignment: Alignment.bottomCenter,
                  border: 2,
                  linearGradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        const Color(0xFFffffff).withOpacity(0.1),
                        const Color(0xFFFFFFFF).withOpacity(0.05),
                      ],
                      stops: const [
                        0.1,
                        1,
                      ]),
                  borderGradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      const Color(0xFFffffff).withOpacity(0.5),
                      const Color((0xFFFFFFFF)).withOpacity(0.5),
                    ],
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: Obx(
                          () => Center(
                            child: Text(
                              //登録した日付を登録する。
                              // (controller.selectedDays != 0)
                              (controller.day != '')
                                  //(controller.day.value == 0)
                                  ? '通知：毎月${controller.day.value}日'
                                  : '未設定',
                              style: TextStyle(
                                // fontSize: 24,
                                fontSize: deviceWidth / 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          NumberButton(
                            text: '7',
                            textSize: MediaQuery.of(context).size.width / 9,
                            fillColor: AppColor.white10,
                            textColor: AppColor.white,
                            onTap: () {
                              controller.numClick('7');
                              HapticFeedback.selectionClick();
                            },
                          ),
                          NumberButton(
                            text: '8',
                            textSize: MediaQuery.of(context).size.width / 9,
                            // fillColor: AppColor.transparent,
                            fillColor: AppColor.white10,
                            textColor: AppColor.white,
                            onTap: () {
                              // controller.numClick(8);
                              controller.numClick('8');
                              HapticFeedback.selectionClick();
                            },
                          ),
                          NumberButton(
                            text: '9',
                            textSize: MediaQuery.of(context).size.width / 9,
                            fillColor: AppColor.white10,
                            textColor: AppColor.white,
                            onTap: () {
                              //controller.numClick(9);
                              controller.numClick('9');
                              HapticFeedback.selectionClick();
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          NumberButton(
                            text: '4',
                            textSize: MediaQuery.of(context).size.width / 9,
                            fillColor: AppColor.white10,
                            textColor: AppColor.white,
                            onTap: () {
                              //controller.numClick(4);
                              controller.numClick('4');
                              HapticFeedback.selectionClick();
                            },
                          ),
                          NumberButton(
                            text: '5',
                            textSize: MediaQuery.of(context).size.width / 9,
                            fillColor: AppColor.white10,
                            textColor: AppColor.white,
                            onTap: () {
                              // controller.numClick(5);
                              controller.numClick('5');
                              HapticFeedback.selectionClick();
                            },
                          ),
                          NumberButton(
                            text: '6',
                            textSize: MediaQuery.of(context).size.width / 9,
                            fillColor: AppColor.white10,
                            textColor: AppColor.white,
                            onTap: () {
                              //controller.numClick(6);
                              controller.numClick('6');
                              HapticFeedback.selectionClick();
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          NumberButton(
                            text: '1',
                            textSize: MediaQuery.of(context).size.width / 9,
                            fillColor: AppColor.white10,
                            textColor: AppColor.white,
                            onTap: () {
                              //controller.numClick(1);
                              controller.numClick('1');
                              HapticFeedback.selectionClick();
                            },
                          ),
                          NumberButton(
                            text: '2',
                            textSize: MediaQuery.of(context).size.width / 9,
                            fillColor: AppColor.white10,
                            textColor: AppColor.white,
                            onTap: () {
                              //controller.numClick(2);
                              controller.numClick('2');
                              HapticFeedback.selectionClick();
                            },
                          ),
                          NumberButton(
                            text: '3',
                            textSize: MediaQuery.of(context).size.width / 9,
                            fillColor: AppColor.white10,
                            textColor: AppColor.white,
                            onTap: () {
                              // controller.numClick(3);
                              controller.numClick('3');
                              HapticFeedback.selectionClick();
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          NumberButton(
                            text: '0',
                            // textSize: 35,
                            textSize: MediaQuery.of(context).size.width / 9,
                            fillColor: AppColor.white10,
                            textColor: AppColor.white,
                            onTap: () {
                              //controller.numClick(0);
                              controller.numClick('0');
                              controller.numClick('0');
                              HapticFeedback.selectionClick();
                            },
                          ),
                        ],
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                            onPressed: controller.onTapDelete,
                            child: Text(
                              '削除',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                //fontSize: 20,
                                fontSize: deviceWidth / 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: controller.onTapSubmit,
                            child: Text(
                              '反映',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: deviceWidth / 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                    ],
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
