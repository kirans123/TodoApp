import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
final class User {
  final String name;
  final String email;
  final String? token;

  bool get isAuthenticated => token != null;

  User({
    required this.name,
    required this.email,
    this.token,
  });
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
