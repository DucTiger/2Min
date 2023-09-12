import 'package:equatable/equatable.dart';
import 'package:two_min/feature/signup/data/model/signup_request.dart';

abstract class SignupEvent extends Equatable {}

class SubmitSignupEvent extends SignupEvent {
  final SignupRequest? signupRequest;

  SubmitSignupEvent({this.signupRequest});

  @override
  List<Object?> get props => [signupRequest];
}

class ShowHidePasswordEvent extends SignupEvent {
  @override
  List<Object?> get props => [];
}

class EnableSignupButtonEvent extends SignupEvent {
  final String? userName;
  final String? email;
  final String? password;
  final String? confirmPassword;

  EnableSignupButtonEvent({
    this.userName,
    this.email,
    this.password,
    this.confirmPassword,
  });

  @override
  List<Object?> get props => [
        userName,
        email,
        password,
        confirmPassword,
      ];
}
