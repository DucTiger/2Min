import 'package:equatable/equatable.dart';
import 'package:two_min/common/data/entity/user_entity.dart';

abstract class SignupState extends Equatable {}

class SignupInitState extends SignupState {
  @override
  List<Object?> get props => [];
}

class SignupSuccessState extends SignupState {
  final UserEntity? userEntity;

  SignupSuccessState({
    this.userEntity,
  });

  @override
  List<Object?> get props => [
        userEntity,
      ];
}

class SignupFailedState extends SignupState {
  final String? errorMessage;

  SignupFailedState({
    this.errorMessage,
  });

  @override
  List<Object?> get props => [
        errorMessage,
      ];
}

class SignupLoadingState extends SignupState {
  @override
  List<Object?> get props => [];
}

class ShowHidePasswordState extends SignupState {
  final bool showHidePassword;

  ShowHidePasswordState({
    required this.showHidePassword,
  });

  @override
  List<Object?> get props => [
        showHidePassword,
      ];
}

class EnableSignupButtonState extends SignupState {
  final bool isEnableSignupButton;

  EnableSignupButtonState({
    required this.isEnableSignupButton,
  });

  @override
  List<Object?> get props => [
        isEnableSignupButton,
      ];
}
