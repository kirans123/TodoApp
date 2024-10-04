import 'package:login_and_registration/data/services/app_info/app_info.dart';

abstract class AppInfoService {
  AppInfo get appInfo;
  Future<void> initPackageInfo();
}
