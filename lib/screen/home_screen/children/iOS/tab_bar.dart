import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_calc_app/constants/app_color.dart';
import 'package:money_calc_app/preference/preference.dart';

import '../android/menu_text.dart';

class NavBar extends StatefulWidget {
  const NavBar({
    Key? key,
    required this.onTapHome,
    required this.onTapNotification,
    required this.onTapStar,
    required this.onTapSetting,
    //required this.AdItem,
    required this.onTapChangePhoto,
    required this.onTapChangeName,
    required this.userName,
  }) : super(key: key);

  final Function() onTapHome;
  final Function() onTapNotification;
  final Function() onTapStar;
  final Function() onTapSetting;

  //final Widget? AdItem;
  final Function() onTapChangePhoto;
  final Function() onTapChangeName;
  final String userName;

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
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
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text(''),
            accountEmail: Text(
              widget.userName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.w,
              ),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: AppColor.red2,
              child: ClipOval(
                child: Image.asset(
                  isSex ? 'assets/images/1.png' : 'assets/images/2.png',
                  fit: BoxFit.cover,
                  width: 90.w,
                  height: 90.w,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: AppColor.red2,
              image: const DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(
                  'https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg',
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.home,
              size: 25.w,
              color: Colors.black,
            ),
            title: Text(
              'Home',
              style: TextStyle(
                fontSize: 20.w,
                color: Colors.black,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          const Divider(thickness: 2, color: Colors.black),
          ListTile(
            leading: Icon(
              Icons.notifications_active,
              size: 25.w,
              color: Colors.black,
            ),
            title: Text(
              'Notification',
              style: TextStyle(
                fontSize: 20.w,
                color: Colors.black,
              ),
            ),
            onTap: widget.onTapNotification,
          ),
          const Divider(thickness: 2, color: Colors.black),
          ListTile(
            leading: Icon(
              Icons.star,
              size: 25.w,
              color: Colors.black,
            ),
            title: Text(
              'App Review',
              style: TextStyle(
                fontSize: 20.w,
                color: Colors.black,
              ),
            ),
            onTap: widget.onTapStar,
          ),
          const Divider(thickness: 2, color: Colors.black),
          ListTile(
            leading: Icon(
              Icons.settings,
              size: 25.w,
              color: Colors.black,
            ),
            title: Text(
              'Settings',
              style: TextStyle(
                fontSize: 20.w,
                color: Colors.black,
              ),
            ),
            onTap: widget.onTapSetting,
          ),
          const Divider(thickness: 2, color: Colors.black),
          ListTile(
            leading: Icon(
              Icons.person,
              size: 25.w,
              color: Colors.black,
            ),
            title: Text(
              'Change Icon',
              style: TextStyle(
                fontSize: 20.w,
                color: Colors.black,
              ),
            ),
            onTap: onTapChangeSex,
          ),
          const Divider(thickness: 2, color: Colors.black),
          ListTile(
            title: Text(
              'Change Name',
              style: TextStyle(
                fontSize: 20.w,
                color: Colors.black,
              ),
            ),
            leading: Icon(
              Icons.adb,
              size: 25.w,
              color: Colors.black,
            ),
            onTap: widget.onTapChangeName,
          ),
          const Divider(thickness: 2, color: Colors.black),
        ],
      ),
    );
  }
}
