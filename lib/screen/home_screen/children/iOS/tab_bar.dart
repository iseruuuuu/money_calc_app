import 'package:flutter/material.dart';
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
        // Remove padding
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              widget.userName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            accountEmail: Text(''),
            currentAccountPicture: CircleAvatar(
              backgroundColor: AppColor.red2,
              child: ClipOval(
                child: Image.asset(
                  isSex ? 'assets/images/1.png' : 'assets/images/2.png',
                  fit: BoxFit.cover,
                  width: 90,
                  height: 90,
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
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          const Divider(
            thickness: 2,
          ),
          ListTile(
            leading: const Icon(
              Icons.notifications_active,
            ),
            title: const Text('Notification'),
            onTap: widget.onTapNotification,
          ),
          const Divider(
            thickness: 2,
          ),
          ListTile(
            leading: const Icon(Icons.star),
            title: const Text('App Review'),
            onTap: widget.onTapStar,
          ),
          const Divider(
            thickness: 2,
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: widget.onTapSetting,
          ),
          const Divider(
            thickness: 2,
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Change Icon'),
            onTap: onTapChangeSex,
          ),
          const Divider(
            thickness: 2,
          ),
          ListTile(
            title: const Text('Change Name'),
            leading: const Icon(Icons.adb),
            onTap: widget.onTapChangeName,
          ),
        ],
      ),
    );
  }
}
