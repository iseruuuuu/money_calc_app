import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:money_calc_app/component/add_screen/number_calc_button.dart';
import 'package:money_calc_app/model/color.dart';
import 'package:money_calc_app/screen/add_screen/add_screen_controller.dart';
import 'package:holding_gesture/holding_gesture.dart';
import 'package:get/get.dart';

class AddScreen extends StatelessWidget {
  const AddScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddScreenController(), tag: '');
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0.0),
        child: AppBar(
          backgroundColor: AppColor.white,
          elevation: 0,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          //TODO 次のアプデにする。
          // AdmobBanner(
          //   adUnitId: AdMob().getBannerAdUnitId(),
          //   adSize: AdmobBannerSize(
          //     width: MediaQuery.of(context).size.width.toInt(),
          //     height: AdMob().getHeight(context).toInt(),
          //     name: 'SMART_BANNER',
          //   ),
          // ),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            padding: const EdgeInsets.all(0.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '￥',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width / 10,
                  ),
                ),
                Obx(
                  () => Text(
                    controller.expression.value,
                    style: TextStyle(
                      color: Colors.black,
                      // fontSize: 40,
                      fontSize: MediaQuery.of(context).size.width / 10,
                    ),
                  ),
                ),
                const Spacer(),
                Container(
                  margin: const EdgeInsets.only(bottom: 1),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.height / 10,
                    height: MediaQuery.of(context).size.height / 10,
                    child: HoldDetector(
                      onHold: () {
                        controller.delete();
                        HapticFeedback.mediumImpact();
                      },
                      child: Theme(
                        data: ThemeData(splashColor: Colors.white),
                        child: Material(
                          elevation: 0,
                          clipBehavior: Clip.hardEdge,
                          color: Colors.transparent,
                          child: FlatButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            onPressed: () {
                              controller.delete();
                              HapticFeedback.selectionClick();
                            },
                            child: Text(
                              '⌫',
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width / 10,
                                // fontSize: 50,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              NumberCalcButton(
                number: 7,
                text: '7',
                // textSize: 40,
                textSize: MediaQuery.of(context).size.width / 8,
                fillColor: AppColor.grey3,
                textColor: Colors.black,
                //callback: numClick,
                callback: () {},
                onTap: () {
                  controller.numClick('7');
                  HapticFeedback.selectionClick();
                },
              ),
              NumberCalcButton(
                number: 8,
                text: '8',
                //textSize: 40,
                textSize: MediaQuery.of(context).size.width / 8,
                fillColor: AppColor.grey3,
                textColor: Colors.black,
                // callback: numClick,
                callback: () {},
                onTap: () {
                  controller.numClick('8');
                  HapticFeedback.selectionClick();
                },
              ),
              NumberCalcButton(
                number: 9,
                text: '9',
                //textSize: 40,
                textSize: MediaQuery.of(context).size.width / 8,
                fillColor: AppColor.grey3,
                textColor: Colors.black,
                // callback: numClick,
                callback: () {},
                onTap: () {
                  controller.numClick('9');
                  HapticFeedback.selectionClick();
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              NumberCalcButton(
                number: 4,
                text: '4',
                //textSize: 40,
                textSize: MediaQuery.of(context).size.width / 8,
                fillColor: AppColor.grey3,
                textColor: Colors.black,
                // callback: numClick,
                callback: () {},
                onTap: () {
                  controller.numClick('4');
                  HapticFeedback.selectionClick();
                },
              ),
              NumberCalcButton(
                number: 5,
                text: '5',
                //textSize: 40,
                textSize: MediaQuery.of(context).size.width / 8,
                fillColor: AppColor.grey3,
                textColor: Colors.black,
                // callback: numClick,
                callback: () {},
                onTap: () {
                  controller.numClick('5');
                  HapticFeedback.selectionClick();
                },
              ),
              NumberCalcButton(
                number: 6,
                text: '6',
                //textSize: 40,
                textSize: MediaQuery.of(context).size.width / 8,
                fillColor: AppColor.grey3,
                textColor: Colors.black,
                // callback: numClick,
                callback: () {},
                onTap: () {
                  controller.numClick('6');
                  HapticFeedback.selectionClick();
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              NumberCalcButton(
                number: 1,
                text: '1',
                //textSize: 40,
                textSize: MediaQuery.of(context).size.width / 8,
                fillColor: AppColor.grey3,
                textColor: Colors.black,
                // callback: numClick,
                callback: () {},
                onTap: () {
                  controller.numClick('1');
                  HapticFeedback.selectionClick();
                },
              ),
              NumberCalcButton(
                number: 2,
                text: '2',
                //textSize: 40,
                textSize: MediaQuery.of(context).size.width / 8,
                fillColor: AppColor.grey3,
                textColor: Colors.black,
                // callback: numClick,
                callback: () {},
                onTap: () {
                  controller.numClick('2');
                  HapticFeedback.selectionClick();
                },
              ),
              NumberCalcButton(
                number: 3,
                text: '3',
                //textSize: 40,
                textSize: MediaQuery.of(context).size.width / 8,
                fillColor: AppColor.grey3,
                textColor: Colors.black,
                // callback: numClick,
                callback: () {},
                onTap: () {
                  controller.numClick('3');
                  HapticFeedback.selectionClick();
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              NumberCalcButton(
                number: 0,
                text: '0',
                // textSize: 40,
                textSize: MediaQuery.of(context).size.width / 8,
                fillColor: AppColor.grey3,
                textColor: Colors.black,
                // callback: numClick,
                callback: () {},
                onTap: () {
                  controller.numClick('0');
                  HapticFeedback.selectionClick();
                },
              ),
              NumberCalcButton(
                number: 0,
                text: '00',
                //textSize: 35,
                textSize: MediaQuery.of(context).size.width / 11,
                fillColor: AppColor.grey3,
                textColor: Colors.black,
                // callback: numClick,
                callback: () {},
                onTap: () {
                  controller.numClick('00');
                  HapticFeedback.selectionClick();
                },
              ),
              NumberCalcButton(
                onTap: () {
                  controller.allDelete();
                },
                number: 0,
                text: 'AC',
                //textSize: 30,
                textSize: MediaQuery.of(context).size.width / 11,
                fillColor: AppColor.grey3,
                textColor: Colors.black,
                callback: controller.allDelete,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 70),
            child: SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.width / 8,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: AppColor.red2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: controller.onTap,
                child: Text(
                  'リスト追加',
                  style: TextStyle(
                    color: Colors.white,
                    // fontSize: 25,
                    fontSize: MediaQuery.of(context).size.width / 20,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 70),
            child: SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: controller.onTapBack,
                child: Text(
                  'キャンセル',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width / 20,
                    color: AppColor.red2,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
