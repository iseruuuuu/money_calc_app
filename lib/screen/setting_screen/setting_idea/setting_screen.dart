import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_calc_app/constants/app_color.dart';
import 'package:money_calc_app/screen/setting_screen/setting_idea/children/setting_parts.dart';
import 'package:money_calc_app/screen/setting_screen/setting_screen_controller.dart';

import 'children/setting_parts2.dart';

class SettingScreens extends StatelessWidget {
  const SettingScreens({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SettingScreenController(), tag: '');
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColor.red2,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          deviceWidth / 8,
        ),
        child: AppBar(
          elevation: 0,
          backgroundColor: AppColor.red2,
          toolbarHeight: deviceWidth / 8,
          title: Text(
            '設定画面',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: deviceWidth / 16,
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
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          const Spacer(),
          Obx(
            () => CircleAvatar(
              backgroundColor: Colors.white,
              radius: deviceHeight / 8,
              child: controller.isSex.value
                  ? Image.asset('assets/images/1.png')
                  : Image.asset('assets/images/2.png'),
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(
                () => Text(
                  controller.isSex.value ? "Hello, Man!  " : "Hello, Woman!",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: deviceWidth / 13,
                  ),
                ),
              ),
              GestureDetector(
                onTap: controller.onTapChangeSex,
                child: Icon(
                  Icons.change_circle,
                  color: Colors.white,
                  size: deviceWidth / 8,
                ),
              ),
            ],
          ),
          const Spacer(),
          Container(
            width: deviceWidth,
            height: deviceHeight / 2.5,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(deviceWidth / 15),
                topRight: Radius.circular(deviceWidth / 15),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SettingParts2(
                      icon: Icons.notifications_active,
                      text: '通知',
                      onTap: controller.onTapNotification,
                      color: Colors.white,
                      backgroundColor: Colors.yellow,
                    ),
                    SettingParts2(
                      icon: Icons.star,
                      text: 'レビュー',
                      onTap: controller.onTapReview,
                      color: Colors.white,
                      backgroundColor: Colors.amber,
                    ),
                    SettingParts2(
                      icon: Icons.mail_outline,
                      text: 'お問い合わせ',
                      onTap: controller.onTapContact,
                      color: Colors.white,
                      backgroundColor: Colors.lightBlue,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SettingParts2(
                      icon: EvaIcons.twitter,
                      text: '開発者',
                      onTap: controller.onTapTwitter,
                      color: Colors.white,
                      backgroundColor: Colors.blue,
                    ),
                    //TODO 色を後で決める！！
                    SettingParts2(
                      icon: Icons.local_police,
                      text: 'ライセンス',
                      onTap: controller.onTapshowLicense,
                      color: Colors.white,
                      backgroundColor: Colors.green,
                    ),
                    SettingParts2(
                      icon: EvaIcons.github,
                      text: 'Github',
                      onTap: controller.onTapGithub,
                      color: Colors.white,
                      backgroundColor: Colors.black,
                    ),
                  ],
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //     SettingParts2(
                //       icon: Icons.toggle_off_outlined,
                //       text: 'モード',
                //       onTap: controller.onTapTwitter,
                //       color: Colors.white,
                //       backgroundColor: Colors.blue,
                //     ),
                //     //TODO 色を後で決める！！
                //     SettingParts2(
                //       icon: Icons.local_police,
                //       text: 'このアプリについて',
                //       onTap: controller.onTapshowLicense,
                //       color: Colors.white,
                //       backgroundColor: Colors.blue,
                //     ),
                //     SettingParts2(
                //       icon: EvaIcons.github,
                //       text: 'Github',
                //       onTap: controller.onTapGithub,
                //       color: Colors.white,
                //       backgroundColor: Colors.black,
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
