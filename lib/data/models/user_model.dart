import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
final class LoggedInUser {
  final String name;
  final String email;
  final String? token;

  bool get isAuthenticated => token != null;

  LoggedInUser({
    required this.name,
    required this.email,
    this.token,
  });
  factory LoggedInUser.fromJson(Map<String, dynamic> json) =>
      _$LoggedInUserFromJson(json);
}
