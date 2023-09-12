import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:two_min/feature/signup/domain/repository/signup_repository.dart';
import 'package:two_min/feature/signup/presentation/bloc/signup_event.dart';
import 'package:two_min/feature/signup/presentation/bloc/signup_state.dart';

import 'package:two_min/networking/exceptions/api_exception.dart';
import 'package:two_min/networking/exceptions/app_exception.dart';
import 'package:two_min/utils/sessions_utils.dart';
import 'package:two_min/utils/string_ext.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final SignupRepository signupRepository;
  var _isShowHidePassword = true;

  SignupBloc({
    required this.signupRepository,
  }) : super(SignupInitState()) {
    on<SubmitSignupEvent>(_signup);
    on<ShowHidePasswordEvent>(_showHidePassword);
    on<EnableSignupButtonEvent>(_enableSignupButton);
  }

  Future<void> _signup(
    SubmitSignupEvent event,
    Emitter<SignupState> emitter,
  ) async {
    try {
      emitter(SignupLoadingState());
      final response = await signupRepository.signup(event.signupRequest);

      SessionUtils.saveSession(
        accessToken: '',
        refreshToken: '',
        userName: response.username,
        userEmail: response.email,
        userId: response.id,
      );

      emitter(SignupSuccessState(userEntity: response));
    } on ApiException catch (apiError) {
      emitter(SignupFailedState(errorMessage: apiError.errorMessage));
    } on AppException catch (appError) {
      emitter(SignupFailedState(errorMessage: appError.message));
    }
  }

  void _showHidePassword(
      ShowHidePasswordEvent event, Emitter<SignupState> emit) {
    _isShowHidePassword = !_isShowHidePassword;
    emit(ShowHidePasswordState(showHidePassword: _isShowHidePassword));
  }

  void _enableSignupButton(
      EnableSignupButtonEvent event, Emitter<SignupState> emit) {
    final userName = event.userName;
    final email = event.email;
    final password = event.password;
    final confirmPassword = event.confirmPassword;

    if (userName == null ||
        userName.isEmpty ||
        email == null ||
        email.isEmpty ||
        password == null ||
        password.isEmpty ||
        confirmPassword == null ||
        confirmPassword.isEmpty ||
        !email.isEmail()) {
      emit(EnableSignupButtonState(isEnableSignupButton: false));
      return;
    }

    if (userName.isNotEmpty &&
        email.isNotEmpty &&
        password.isNotEmpty &&
        confirmPassword.isNotEmpty) {
      emit(EnableSignupButtonState(isEnableSignupButton: true));
    }
  }
}
