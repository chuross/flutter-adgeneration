import 'package:chr_adgeneration/adg_banner_type.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AdgBanner extends StatefulWidget {
  static final String _name = 'com.github.chuross.widget/adgbanner';
  final String locationId;
  final AdgBannerType type;

  double get resolvedWidth {
    switch (type) {
      case AdgBannerType.SP:
      case AdgBannerType.LARGE:
        return 320;
      case AdgBannerType.RECT:
        return 300;
      default:
        return 0;
    }
  }

  double get resolvedHeight {
    switch (type) {
      case AdgBannerType.SP:
        return 50;
      case AdgBannerType.LARGE:
        return 100;
      case AdgBannerType.RECT:
        return 250;
      default:
        return 0;
    }
  }

  AdgBanner({
    @required this.locationId,
    @required this.type,
  });

  @override
  State<StatefulWidget> createState() => _AdgBannerState();
}

class _AdgBannerState extends State<AdgBanner> {
  @override
  Widget build(BuildContext context) {
    // Android以外は未対応
    if (defaultTargetPlatform != TargetPlatform.android) {
      return Container();
    }

    return Container(
      width: widget.resolvedWidth,
      height: widget.resolvedHeight,
      child: AndroidView(
        viewType: AdgBanner._name,
        onPlatformViewCreated: (id) {
          AdgBannerController._(
            id: id,
            locationId: widget.locationId,
            type: widget.type,
          ).load();
        },
      ),
    );
  }
}

class AdgBannerController {
  final int id;
  final String locationId;
  final AdgBannerType type;
  final MethodChannel _channel;

  AdgBannerController._({@required this.id, @required this.locationId, @required this.type})
      : _channel = MethodChannel('${AdgBanner._name}_$id');

  Future<void> load() async {
    final typeValue = _typeValueOf(type);

    final params = {
      'locationId': locationId,
      'type': typeValue,
    };
    return _channel.invokeMethod('load', params);
  }

  String _typeValueOf(AdgBannerType type) {
    switch (type) {
      case AdgBannerType.SP:
        return 'sp';
      case AdgBannerType.LARGE:
        return 'large';
      case AdgBannerType.RECT:
        return 'rect';
      default:
        return '';
    }
  }
}