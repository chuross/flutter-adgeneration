import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AdgBanner extends StatefulWidget {
  static final String _name = 'com.github.chuross.widget/adgbanner';
  final double width;
  final double height;
  final void Function(AdgBannerController) onPlatformViewCreated;

  AdgBanner({
    @required this.width,
    @required this.height,
    this.onPlatformViewCreated,
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
      width: widget.width,
      height: widget.height,
      child: AndroidView(
        viewType: AdgBanner._name,
        onPlatformViewCreated: (id) {
          if (widget.onPlatformViewCreated != null) widget.onPlatformViewCreated(AdgBannerController._(id: id));
        },
      ),
    );
  }
}

class AdgBannerController {
  final int id;
  final MethodChannel _channel;

  AdgBannerController._({@required this.id}) : _channel = MethodChannel('${AdgBanner._name}_$id');

  ///
  /// type: [sp, large, rect]
  ///
  Future<void> load({@required String locationId, String type = 'sp'}) async {
    final params = {
      'locationId': locationId,
      'type': type,
    };
    return _channel.invokeMethod('load', params);
  }
}
