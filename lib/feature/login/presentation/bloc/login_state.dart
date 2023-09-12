import 'package:two_min/feature/login/domain/entities/user_entity.dart';
import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {}

class LoginInitState extends LoginState {
  @override
  List<Object?> get props => [];
}

class LoginLoadingState extends LoginState {
  @override
  List<Object?> get props => [];
}

class LoginSuccessState extends LoginState {
  final UserEntity? userEntity;

  LoginSuccessState({
    required this.userEntity,
  });

  @override
  List<Object?> get props => [
        userEntity,
      ];
}

class LoginFailedState extends LoginState {
  final String? errorMessage;

  LoginFailedState({
    this.errorMessage,
  });

  @override
  List<Object?> get props => [
        errorMessage,
      ];
}

class ShowHidePasswordState extends LoginState {
  final bool showHidePassword;

  ShowHidePasswordState({
    required this.showHidePassword,
  });

  @override
  List<Object?> get props => [
        showHidePassword,
      ];
}
