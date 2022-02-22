import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:money_calc_app/admob/admob_service.dart';
import 'package:money_calc_app/constants/app_color.dart';

class LicenseScreen extends StatefulWidget {
  const LicenseScreen({
    Key? key,
  }) : super(key: key);

  @override
  _LicenseScreenState createState() => _LicenseScreenState();
}

class _LicenseScreenState extends State<LicenseScreen> {
  List<List<String>> licenses = [];

  @override
  void initState() {
    super.initState();
    LicenseRegistry.licenses.listen((license) {
      final packages = license.packages.toList();
      final paragraphs = license.paragraphs.toList();
      final packageName = packages.map((e) => e).join('');
      final paragraphText = paragraphs.map((e) => e.text).join('\n');
      licenses.add([packageName, paragraphText]);
      setState(() => licenses = licenses);
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          deviceWidth / 8,
        ),
        child: AppBar(
          backgroundColor: AppColor.red2,
          toolbarHeight: deviceWidth / 8,
          title: Text(
            'ライセンス情報',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: deviceWidth / 16,
            ),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            iconSize: deviceWidth / 11,
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // AdmobBanner(
          //   adUnitId: AdMobService().getBannerAdUnitId(),
          //   adSize: AdmobBannerSize(
          //     width: MediaQuery.of(context).size.width.toInt(),
          //     height: AdMobService().getHeight(context).toInt(),
          //     name: 'SMART_BANNER',
          //   ),
          // ),
          Expanded(
            child: ListView.builder(
              itemCount: licenses.length,
              itemBuilder: (context, index) {
                final license = licenses[index];
                return Padding(
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        license[0],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: deviceWidth / 15,
                          color: Colors.indigo,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        license[1],
                        style: TextStyle(
                          fontSize: deviceWidth / 30,
                          fontWeight: FontWeight.normal,
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
