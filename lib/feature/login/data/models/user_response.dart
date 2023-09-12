import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_response.g.dart';

@JsonSerializable()
class UserResponse extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final String? email;
  final String? username;
  final String? accessToken;
  final String? refreshToken;

  const UserResponse({
    this.id,
    this.email,
    this.username,
    this.accessToken,
    this.refreshToken,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseToJson(this);

  @override
  List<Object?> get props => [
        id,
        email,
        username,
        accessToken,
        refreshToken,
      ];
}
