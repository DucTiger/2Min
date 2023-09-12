import 'package:equatable/equatable.dart';

import 'package:json_annotation/json_annotation.dart';

part 'signup_request.g.dart';

@JsonSerializable()
class SignupRequest extends Equatable {
  final String? username;
  final String? email;
  final String? password;

  const SignupRequest({
    this.username,
    this.email,
    this.password,
  });

  factory SignupRequest.fromJson(Map<String, dynamic> json) =>
      _$SignupRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SignupRequestToJson(this);

  @override
  List<Object?> get props => [
        username,
        email,
        password,
      ];
}
