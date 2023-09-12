import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_response.g.dart';

@JsonSerializable()
class UserResponse extends Equatable {
  final String? realm;
  final String? username;
  final String? email;
  final String? password;
  final bool? emailVerified;
  final String? id;

  const UserResponse({
    this.realm,
    this.username,
    this.email,
    this.password,
    this.emailVerified,
    this.id,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseToJson(this);

  @override
  List<Object?> get props => [
    realm,
    username,
    email,
    password,
    emailVerified,
    this.id,
  ];
}