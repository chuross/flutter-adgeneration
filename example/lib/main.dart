import 'package:chr_adgeneration/adg_banner.dart';
import 'package:chr_adgeneration/adg_banner_type.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('sp'),
              AdgBanner(
                locationId: '48547',
                type: AdgBannerType.SP,
              ),
              Divider(),
              Text('large'),
              AdgBanner(
                locationId: '48548',
                type: AdgBannerType.LARGE,
              ),
              Divider(),
              Text('rect'),
              AdgBanner(
                locationId: '48549',
                type: AdgBannerType.RECT,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
