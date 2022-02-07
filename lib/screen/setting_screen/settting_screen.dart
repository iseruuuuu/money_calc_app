import 'package:flutter/material.dart';
import 'package:money_calc_app/preference/preference.dart';
import 'package:money_calc_app/screen/setting_screen/children/license_screen.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({
    Key? key,
  }) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool isSex = false;
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
  );

  @override
  void initState() {
    super.initState();
    preference(preference: false);
    // _getAppVersion();
    // checkVersion();
    //_initPackageInfo();
    _initPackageInfo();
  }

  void onTapChangeSex() {
    setState(() {
      isSex = !isSex;
    });
    preference(preference: true);
  }

  Future<void> preference({required bool preference}) async {
    if (preference) {
      Preference().setBool(PreferenceKey.isSex, isSex);
    } else {
      isSex = await Preference().getBool(PreferenceKey.isSex);
    }
  }

  Future<String> _getAppVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  void checkVersion() async {}

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });

    print(_packageInfo.version);
  }

  Future _showLicense() async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LicenseScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        title: const Text('設定画面'),
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
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 100,
                    child: isSex
                        ? Image.asset('assets/images/icon_man.png')
                        : Image.asset('assets/images/icon_woman.png'),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    isSex ? "Hello, Man!" : "Hello, Woman!",
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                tileColor: Colors.black,
                onTap: () {},
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
                textColor: Colors.white,
                dense: true,
                // padding: EdgeInsets.zero,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                tileColor: Colors.black,
                onTap: () {},
                leading: const Icon(
                  Icons.settings,
                  size: 35.0,
                  color: Colors.white,
                ),
                title: const Text(
                  "Settings",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
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
                onTap: onTapChangeSex,
                leading: const Icon(
                  Icons.person,
                  size: 35.0,
                  color: Colors.white,
                ),
                title: const Text(
                  "Change",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
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
                onTap: _showLicense,
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
                    Text(
                      //version,
                      _packageInfo.version,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
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
