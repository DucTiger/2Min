import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {}

class LoginPressedEvent extends LoginEvent {
  final String email;
  final String password;

  LoginPressedEvent({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [
        email,
        password,
      ];
}

class ShowHidePasswordEvent extends LoginEvent {
  @override
  List<Object?> get props => [];
}
