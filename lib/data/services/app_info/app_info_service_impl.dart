import 'package:login_and_registration/data/services/app_info/app_info.dart';
import 'package:login_and_registration/data/services/app_info/app_info_service.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppInfoServiceImpl extends AppInfoService {
  AppInfo _appInfo = const AppInfo();
  @override
  AppInfo get appInfo => _appInfo;

  @override
  Future<void> initPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    _appInfo = AppInfo.fromPackageInfo(packageInfo);
  }
}
