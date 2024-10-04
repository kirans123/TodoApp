import 'dart:io';

import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class RegisterUserEvent extends AuthEvent {
  final String email;
  final String password;
  final String userName;
  final String mobile;
  final File? image;

  RegisterUserEvent(
      {required this.email,
      required this.password,
      required this.userName,
      required this.mobile,
      this.image});

  @override
  List<Object> get props => [
        email,
        password,
        userName,
        mobile,
      ];
}

class LoginUserEvent extends AuthEvent {
  final String email;
  final String password;

  LoginUserEvent({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}
