import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<UserCredential> registerUser(
    String email,
    String password,
    String userName,
    String mobile,
  );

  Future<UserCredential> loginUser(String email, String password);
}
