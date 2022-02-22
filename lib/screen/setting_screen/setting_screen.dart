import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:money_calc_app/admob/admob_service.dart';
import 'package:money_calc_app/constants/app_color.dart';
import 'package:get/get.dart';
import 'package:money_calc_app/screen/setting_screen/children/setting_item.dart';
import 'package:money_calc_app/screen/setting_screen/setting_screen_controller.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({
    Key? key,
    required this.AdItem,
  }) : super(key: key);

  final Widget? AdItem;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SettingScreenController(), tag: '');
    final deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          deviceWidth / 8,
        ),
        child: AppBar(
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // SizedBox(
            //   height: 50,
            //   child: AdItem,
            // ),

            // AdmobBanner(
            //   adUnitId: AdMobService().getBannerAdUnitId(),
            //   adSize: AdmobBannerSize(
            //     width: MediaQuery.of(context).size.width.toInt(),
            //     height: AdMobService().getHeight(context).toInt(),
            //     name: 'SMART_BANNER',
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: deviceWidth / 20,
                  ),
                  Obx(
                    () => CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: deviceWidth / 4,
                      child: controller.isSex.value
                          ? Image.asset('assets/images/icon_man.png')
                          : Image.asset('assets/images/icon_woman.png'),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx(
                        () => Text(
                          controller.isSex.value
                              ? "Hello, Man!  "
                              : "Hello, Woman!",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            // fontSize: 30,
                            fontSize: deviceWidth / 13,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: controller.onTapChangeSex,
                        child: Icon(
                          Icons.change_circle,
                          color: AppColor.red2,
                          // size: 35,
                          size: deviceWidth / 8,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                ],
              ),
            ),

            GestureDetector(
              onTap: controller.onTapNotification,
              child: const SettingItem(
                icon: Icons.notifications_active,
                title: "Notification",
              ),
            ),

            GestureDetector(
              onTap: controller.onTapContact,
              child: const SettingItem(
                icon: Icons.star,
                title: "App Review",
              ),
            ),

            GestureDetector(
              onTap: controller.onTapContact,
              child: const SettingItem(
                icon: Icons.mail_outline,
                title: "Contact",
              ),
            ),

            GestureDetector(
              onTap: controller.onTapTwitter,
              child: const SettingItem(
                icon: EvaIcons.twitter,
                title: "Developer",
              ),
            ),

            GestureDetector(
              onTap: controller.showLicense,
              child: const SettingItem(
                icon: Icons.local_police,
                title: "Licence",
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: deviceWidth / 60,
                horizontal: deviceWidth / 50,
              ),
              child: Container(
                height: deviceWidth / 8,
                width: MediaQuery.of(context).size.width,
                color: Colors.black,
                child: Row(
                  children: [
                    SizedBox(width: deviceWidth / 20),
                    Text(
                      'バージョン',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: deviceWidth / 20,
                      ),
                    ),
                    const Spacer(),

                    //TODO 後で戻したい！！
                    // Obx(
                    //   () => Text(
                    //     controller.version.value,
                    //     style: TextStyle(
                    //       color: Colors.white,
                    //       fontWeight: FontWeight.bold,
                    //       fontSize: deviceWidth / 20,
                    //     ),
                    //   ),
                    // ),
                    //

                    SizedBox(width: deviceWidth / 20),
                  ],
                ),
              ),
            ),
            // AdmobBanner(
            //   adUnitId: AdMobService().getBannerAdUnitId(),
            //   adSize: AdmobBannerSize(
            //     width: MediaQuery.of(context).size.width.toInt(),
            //     height: AdMobService().getHeight(context).toInt(),
            //     name: 'SMART_BANNER',
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
