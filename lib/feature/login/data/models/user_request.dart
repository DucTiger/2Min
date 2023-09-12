import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_request.g.dart';

@JsonSerializable()
class UserRequest extends Equatable {
  final String? email;
  final String? password;

  const UserRequest({
    required this.email,
    required this.password,
  });

  factory UserRequest.fromJson(Map<String, dynamic> json) => _$UserRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UserRequestToJson(this);

  @override
  List<Object?> get props => [
        email,
        password,
      ];
}
