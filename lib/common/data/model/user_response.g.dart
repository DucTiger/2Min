// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserResponse _$UserResponseFromJson(Map<String, dynamic> json) => UserResponse(
      realm: json['realm'] as String?,
      username: json['username'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      emailVerified: json['emailVerified'] as bool?,
      id: json['id'] as String?,
    );

Map<String, dynamic> _$UserResponseToJson(UserResponse instance) =>
    <String, dynamic>{
      'realm': instance.realm,
      'username': instance.username,
      'email': instance.email,
      'password': instance.password,
      'emailVerified': instance.emailVerified,
      'id': instance.id,
    };
