import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:money_calc_app/model/color.dart';
import 'package:get/get.dart';
import 'package:money_calc_app/screen/setting_screen/setting_screen_controller.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SettingScreenController(), tag: '');
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
        padding: const EdgeInsets.symmetric(vertical: 50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  //TODO 画像だと、GetXの状態管理ができない。
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 100,
                    child: controller.isSex
                        ? Image.asset('assets/images/icon_man.png')
                        : Image.asset('assets/images/icon_woman.png'),
                  ),

                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        controller.isSex ? "Hello, Man!  " : "Hello, Woman!",
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                      IconButton(
                        onPressed: controller.onTapChangeSex,
                        icon: Icon(
                          Icons.change_circle,
                          color: AppColor.red2,
                          size: 35,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                tileColor: Colors.black,
                onTap: controller.onTapNotification,
                leading: const Icon(
                  Icons.notifications_active,
                  size: 35.0,
                  color: Colors.white,
                ),
                title: const Text(
                  "Notification",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_sharp,
                  color: AppColor.white,
                  size: 30,
                ),
                textColor: Colors.white,
                dense: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                tileColor: Colors.black,
                onTap: () {},
                leading: const Icon(
                  Icons.star,
                  size: 35.0,
                  color: Colors.white,
                ),
                title: const Text(
                  "App Review",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_sharp,
                  color: AppColor.white,
                  size: 30,
                ),
                textColor: Colors.white,
                dense: true,
                // padding: EdgeInsets.zero,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                tileColor: Colors.black,
                onTap: controller.onTapContact,
                leading: const Icon(
                  Icons.mail_outline,
                  size: 35.0,
                  color: Colors.white,
                ),
                title: const Text(
                  "Contact",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_sharp,
                  color: AppColor.white,
                  size: 30,
                ),
                textColor: Colors.white,
                dense: true,
                // padding: EdgeInsets.zero,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                tileColor: Colors.black,
                onTap: controller.onTapTwitter,
                leading: const Icon(
                  //Icons.developer_mode,
                  EvaIcons.twitter,
                  size: 35.0,
                  color: Colors.white,
                ),
                title: const Text(
                  "Developer",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_sharp,
                  color: AppColor.white,
                  size: 30,
                ),
                textColor: Colors.white,
                dense: true,
                // padding: EdgeInsets.zero,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                tileColor: Colors.black,
                onTap: controller.showLicense,
                leading: const Icon(
                  Icons.local_police,
                  size: 35.0,
                  color: Colors.white,
                ),
                title: const Text(
                  "Licence",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_sharp,
                  color: AppColor.white,
                  size: 30,
                ),
                textColor: Colors.white,
                dense: true,
                // padding: EdgeInsets.zero,
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
          ],
        ),
      ),
    );
  }
}
