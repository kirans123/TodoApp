import 'package:package_info_plus/package_info_plus.dart';

class AppInfo {
  final String appName;
  final String packageName;
  final String currentAppVersion;
  final int versionCode;

  const AppInfo({
    this.appName = '',
    this.packageName = '',
    this.currentAppVersion = '0',
    this.versionCode = 0,
  });

  factory AppInfo.fromPackageInfo(PackageInfo packageInfo) {
    return AppInfo(
      appName: packageInfo.appName,
      packageName: packageInfo.packageName,
      currentAppVersion: packageInfo.version,
      versionCode: int.parse(packageInfo.buildNumber),
    );
  }
}
