import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  const MenuItem({
    Key? key,
    required this.onTapNotification,
    required this.onTapStar,
  }) : super(key: key);

  final Function() onTapNotification;
  final Function() onTapStar;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 50.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 40,
                  child: Image.asset('assets/images/icon_man.png'),
                ),
                const SizedBox(height: 16.0),
                const Text(
                  "Hello, Man!",
                  style: TextStyle(
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
            onTap: onTapNotification,
            leading: const Icon(
              Icons.notifications_active,
              size: 30.0,
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
            onTap: onTapStar,
            leading: const Icon(
              Icons.star,
              size: 30.0,
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
              size: 30.0,
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
        ],
      ),
    );
  }
}
