import 'dart:io';

import 'package:flutter/foundation.dart';

// This is used to check if the app is running on web or mobile device

class CheckPlatform {
  static bool get isWeb => kIsWeb;

  static bool get isIOS {
    if (isWeb) return false;

    return Platform.isIOS;
  }

  static bool get isAndroid {
    if (isWeb) return false;

    return Platform.isAndroid;
  }

  static bool get isNotWeb => !isWeb;

  static bool get isNotIOS => !isIOS;

  static bool get isNotAndroid => !isAndroid;

  static final bool isWebMobile = kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.iOS ||
          defaultTargetPlatform == TargetPlatform.android);
  static bool get isNotWebMobile => !isWebMobile;

  static String get getCurrentPlatform => isWeb
      ? 'Web'
      : isIOS
          ? 'iOS'
          : 'Android';

  static String get getCurrentOS => defaultTargetPlatform == TargetPlatform.iOS
      ? 'iOS'
      : defaultTargetPlatform == TargetPlatform.android
          ? 'Android'
          : 'Web';

  static String operatingSystem() {
    return isNotWeb ? Platform.operatingSystem : 'Web';
  }

  static String operatingSystemVersion() {
    return isNotWeb ? Platform.operatingSystemVersion : 'Web';
  }
}
