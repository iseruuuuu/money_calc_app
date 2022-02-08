import 'package:get/get.dart';
import 'package:money_calc_app/preference/preference.dart';
import 'package:money_calc_app/screen/push_notificaiton_screen/push_notification_screen.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'children/contact_screen.dart';
import 'children/license_screen.dart';

class SettingScreenController extends GetxController {
  var isSex = false.obs;
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
  );
  final version = ''.obs;

  @override
  void onInit() {
    super.onInit();
    preference(preference: false);
    initPackageInfo();
  }

  void onTapChangeSex() {
    isSex.value = !isSex.value;
    preference(preference: true);
  }

  Future<void> preference({required bool preference}) async {
    if (preference) {
      Preference().setBool(PreferenceKey.isSex, isSex.value);
    } else {
      isSex.value = await Preference().getBool(PreferenceKey.isSex);
    }
  }

  Future<void> initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    _packageInfo = info;
    version.value = info.version;
  }

  Future showLicense() async {
    Get.to(() => const LicenseScreen());
  }

  void onTapNotification() {
    Get.to(() => const PushNotificationScreen());
  }

  void onTapTwitter() async {
    const url = 'twitter://user?screen_name=isekiryu';
    const secondUrl = 'https://twitter.com/isekiryu';

    if (await canLaunch(url)) {
      await launch(url);
    } else if (await canLaunch(secondUrl)) {
      // 最初のURLが開けなかった場合かつセカンドURLが有って開けた場合
      await launch(secondUrl);
    } else {
      // 任意のエラー処理
    }
  }

  void onTapContact() {
    Get.to(() => const ContactScreen());
  }
}
