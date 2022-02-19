import 'package:admob_flutter/admob_flutter.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:money_calc_app/admob/admob_service.dart';
import 'package:money_calc_app/model/color.dart';
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
      appBar: AppBar(
        backgroundColor: AppColor.red2,
        title: const Text(
          '設定画面',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /* SizedBox(
              height: 50,
              child: AdItem,
            ),*/

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
                  Obx(
                    () => CircleAvatar(
                      backgroundColor: Colors.white,
                      //radius: 100,
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
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 70,
                width: MediaQuery.of(context).size.width,
                color: Colors.black,
                child: Row(
                  children: [
                    const SizedBox(width: 30),
                    const Text(
                      'バージョン',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                    const Spacer(),
                    Obx(
                      () => Text(
                        controller.version.value,
                        // controller.packageInfo.version,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                    ),
                    const SizedBox(width: 30),
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
