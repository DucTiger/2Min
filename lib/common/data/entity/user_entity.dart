import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? username;
  final String? email;
  final String? password;
  final String? id;

  const UserEntity({
    this.username,
    this.email,
    this.password,
    this.id,
  });

  @override
  List<Object?> get props => [
        username,
        email,
        password,
        id,
      ];
}
