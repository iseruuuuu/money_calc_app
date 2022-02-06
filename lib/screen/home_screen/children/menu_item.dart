import 'package:flutter/material.dart';
import 'package:money_calc_app/preference/preference.dart';

class MenuItem extends StatefulWidget {
  const MenuItem({
    Key? key,
    required this.onTapNotification,
    required this.onTapStar,
  }) : super(key: key);

  final Function() onTapNotification;
  final Function() onTapStar;

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
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 50.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 50,
                  child: isSex
                      ? Image.asset('assets/images/icon_man.png')
                      : Image.asset('assets/images/icon_woman.png'),
                ),
                const SizedBox(height: 16.0),
                Text(
                  isSex ? "Hello, Man!" : "Hello, Woman!",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                const SizedBox(height: 20.0),
              ],
            ),
          ),
          ListTile(
            onTap: widget.onTapNotification,
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
          ListTile(
            onTap: widget.onTapStar,
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
          ListTile(
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
          ListTile(
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
        ],
      ),
    );
  }
}
