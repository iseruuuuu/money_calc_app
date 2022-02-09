import 'package:flutter/material.dart';
import 'package:money_calc_app/preference/preference.dart';

class MenuItem extends StatefulWidget {
  const MenuItem({
    Key? key,
    required this.onTapHome,
    required this.onTapNotification,
    required this.onTapStar,
    required this.onTapSetting,
    required this.AdItem,
    required this.onTapChangePhoto,
    required this.image,
    required this.onTapChangeName,
    required this.userName,
  }) : super(key: key);

  final Function() onTapHome;
  final Function() onTapNotification;
  final Function() onTapStar;
  final Function() onTapSetting;
  final Widget? AdItem;
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
                GestureDetector(
                  //onTap: widget.onTapChangePhoto,
                  onTap: onTapChangeSex,
                  child: Container(
                    width: MediaQuery.of(context).size.width / 3.5,
                    height: MediaQuery.of(context).size.width / 3.5,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage(
                            // widget.image == ''
                            isSex
                                ? 'assets/images/icon_man.png'
                                //: widget.image,
                                : 'assets/images/icon_woman.png'),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                Text(
                  widget.userName,
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
            onTap: widget.onTapHome,
            leading: const Icon(
              Icons.home,
              size: 35.0,
              color: Colors.white,
            ),
            title: const Text(
              "Home",
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
            onTap: widget.onTapSetting,
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
            //onTap: widget.onTapChangePhoto,
            onTap: onTapChangeSex,
            leading: const Icon(
              Icons.person,
              size: 35.0,
              color: Colors.white,
            ),
            title: const Text(
              "Change Icon",
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
            onTap: widget.onTapChangeName,
            leading: const Icon(
              Icons.adb,
              size: 35.0,
              color: Colors.white,
            ),
            title: const Text(
              "Change Name",
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
          const SizedBox(height: 20),
          SizedBox(
            height: 50,
            child: widget.AdItem,
          ),
        ],
      ),
    );
  }
}
