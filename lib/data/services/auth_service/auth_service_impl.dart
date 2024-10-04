import 'package:login_and_registration/data/init/init_service.dart';
import 'package:login_and_registration/data/models/user_model.dart';
import 'package:login_and_registration/data/services/auth_service/auth_service.dart';
import 'package:login_and_registration/utils/constants/keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthServiceImpl implements AuthService {
  LoggedInUser? _user;

  @override
  LoggedInUser? get user => _user;

  @override
  Future<bool> checkAndInitUser() async {
    _user = await _getUser();

    if (_user?.isAuthenticated ?? false) {
      apiService.setToken(_user?.token ?? '');
      return true;
    }
    return false;
  }

  @override
  Future<void> setUser(LoggedInUser user) async {
    apiService.setToken(user.token ?? '');
    final prefInstance = await SharedPreferences.getInstance();
    await prefInstance.setString(AppKeys.token, user.token ?? '');
    await prefInstance.setString(AppKeys.email, user.email);
    await prefInstance.setString(AppKeys.userName, user.name);
    _user = await _getUser();
  }

  Future<LoggedInUser?> _getUser() async {
    final prefInstance = await SharedPreferences.getInstance();
    String? token = prefInstance.getString(AppKeys.token);
    String? email = prefInstance.getString(AppKeys.email);
    String? userName = prefInstance.getString(AppKeys.userName);
    if (token == null || email == null || userName == null) {
      return null;
    }

    return LoggedInUser(
      token: token,
      email: email,
      name: userName,
    );
  }

  @override
  Future<void> clear() async {
    apiService.setToken('');
    final prefInstance = await SharedPreferences.getInstance();
    await prefInstance.clear();
  }
}
