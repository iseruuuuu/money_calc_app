import 'package:get/get.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:money_calc_app/preference/preference.dart';
import 'package:money_calc_app/screen/push_notificaiton_screen/push_notification_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'children/contact_screen.dart';
import 'children/license_screen.dart';

class SettingScreenController extends GetxController {
  var isSex = false.obs;
  // PackageInfo _packageInfo = PackageInfo(
  //   appName: 'Unknown',
  //   packageName: 'Unknown',
  //   version: 'Unknown',
  //   buildNumber: 'Unknown',
  //   buildSignature: 'Unknown',
  // );
  final version = ''.obs;
  final InAppReview inAppReview = InAppReview.instance;

  @override
  void onInit() {
    super.onInit();
    preference(preference: false);
    //TODO 後で戻したい！
    // initPackageInfo();
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

  // //TODO 後で戻したい！
  // Future<void> initPackageInfo() async {
  //   final info = await PackageInfo.fromPlatform();
  //   _packageInfo = info;
  //   version.value = info.version;
  // }

  Future showLicense() async {
    Get.to(() => const LicenseScreen());
  }

  void onTapNotification() {
    Get.to(() => const PushNotificationScreen());
  }

  void onTapTwitter() async {
    const url = 'twitter://user?screen_name=23_student___';
    const secondUrl = 'https://twitter.com/23_student___';

    if (await canLaunch(url)) {
      await launch(url);
    } else if (await canLaunch(secondUrl)) {
      // 最初のURLが開けなかった場合かつセカンドURLが有って開けた場合
      await launch(secondUrl);
    } else {
      // 任意のエラー処理
    }
  }

  Future<void> onTapContact() async {
    // Get.to(() => const ContactScreen());
    const url = 'https://forms.gle/dcJyKYPFPN8wNTdN7';
    if (await canLaunch(url)) {
      await launch(url);
    } else if (await canLaunch(url)) {
      // 最初のURLが開けなかった場合かつセカンドURLが有って開けた場合
      await launch(url);
    } else {
      // 任意のエラー処理
    }

  }

  void onTapReview() async {
    if (await inAppReview.isAvailable()) {
      inAppReview.requestReview();
    }
  }
}
