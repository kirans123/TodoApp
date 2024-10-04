import 'package:login_and_registration/data/models/user_model.dart';

abstract class AuthService {
  LoggedInUser? get user;

  Future<bool> checkAndInitUser();
  Future<void> setUser(LoggedInUser user);
  Future<void> clear();
}
