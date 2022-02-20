import 'package:flutter/material.dart';
import 'package:money_calc_app/preference/preference.dart';
import 'package:money_calc_app/screen/home_screen/children/menu_text.dart';

class MenuItem extends StatefulWidget {
  const MenuItem({
    Key? key,
    required this.onTapHome,
    required this.onTapNotification,
    required this.onTapStar,
    required this.onTapSetting,
    //required this.AdItem,
    required this.onTapChangePhoto,
    required this.image,
    required this.onTapChangeName,
    required this.userName,
  }) : super(key: key);

  final Function() onTapHome;
  final Function() onTapNotification;
  final Function() onTapStar;
  final Function() onTapSetting;

  //final Widget? AdItem;
  final Function() onTapChangePhoto;
  final String image;
  final Function() onTapChangeName;
  final String userName;

  @override
  _MenuItemState createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {
  bool isSex = false;

  @override
  void initState() {
    super.initState();
    preference(preference: false);
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

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: onTapChangeSex,
          child: Container(
            width: deviceWidth / 4,
            height: deviceWidth / 4,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(
                  isSex
                      ? 'assets/images/icon_man.png'
                      : 'assets/images/icon_woman.png',
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16.0),
        Text(
          widget.userName,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            // fontSize: 25,
            fontSize: deviceWidth / 15,
          ),
        ),
        const SizedBox(height: 20.0),
        MenuText(
          onTap: widget.onTapHome,
          icon: Icons.home,
          text: "Home",
        ),
        SizedBox(height: deviceWidth / 30),
        MenuText(
          onTap: widget.onTapNotification,
          icon: Icons.notifications_active,
          text: "Notification",
        ),
        SizedBox(height: deviceWidth / 30),
        MenuText(
          onTap: widget.onTapStar,
          icon: Icons.star,
          text: "App Review",
        ),
        SizedBox(height: deviceWidth / 30),
        MenuText(
          onTap: widget.onTapSetting,
          icon: Icons.settings,
          text: "Settings",
        ),
        SizedBox(height: deviceWidth / 30),
        MenuText(
          onTap: onTapChangeSex,
          icon: Icons.person,
          text: "Change Icon",
        ),
        SizedBox(height: deviceWidth / 30),
        MenuText(
          onTap: widget.onTapChangeName,
          icon: Icons.adb,
          text: "Change Name",
        ),
        SizedBox(height: deviceWidth / 30),
        const SizedBox(height: 20),
        // SizedBox(
        //   height: 50,
        //   child: widget.AdItem,
        // ),
      ],
    );
  }
}
