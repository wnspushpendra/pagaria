import 'package:flutter/material.dart';

enum DeviceType {
  Mobile,
  Tablet,
  Desktop,
  Unknown,
}

String getDeviceType(BuildContext context) {
  final double deviceWidth = MediaQuery.of(context).size.width;

  if (deviceWidth > 1200) {
    return 'desktop';
  } else if (deviceWidth > 600) {
    return 'tablet';
  } else {
    return 'mobile';
  }
}
