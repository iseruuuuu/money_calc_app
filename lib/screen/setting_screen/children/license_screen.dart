import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:money_calc_app/model/color.dart';

class LicenseScreen extends StatefulWidget {
  const LicenseScreen();

  @override
  _LicenseScreenState createState() => _LicenseScreenState();
}

class _LicenseScreenState extends State<LicenseScreen> {
  List<List<String>> licenses = [];

  @override
  void initState() {
    super.initState();
    LicenseRegistry.licenses.listen((license) {
      // license.packagesとlicense.paragraphsの返り値がIterableなのでtoList()してる
      final packages = license.packages.toList();
      final paragraphs = license.paragraphs.toList();
      final packageName = packages.map((e) => e).join('');
      final paragraphText = paragraphs.map((e) => e.text).join('\n');
      // この辺の状態更新とかは環境に合わせてお好みで
      licenses.add([packageName, paragraphText]);
      setState(() => licenses = licenses);
    });
  }

  void onSearch() {
    //TODO パッケージ内容を検索できるようにする？
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        backgroundColor: AppColor.red2,
        title: const Text(
          'ライセンス情報',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      ),
      body: ListView.builder(
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
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.indigo,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  license[1],
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.normal,
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
