// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoggedInUser _$LoggedInUserFromJson(Map<String, dynamic> json) => LoggedInUser(
      name: json['name'] as String,
      email: json['email'] as String,
      token: json['token'] as String?,
    );

Map<String, dynamic> _$LoggedInUserToJson(LoggedInUser instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'token': instance.token,
    };
