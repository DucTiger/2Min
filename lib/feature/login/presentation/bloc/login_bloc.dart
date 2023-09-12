import 'package:two_min/feature/login/presentation/bloc/login_event.dart';
import 'package:two_min/feature/login/presentation/bloc/login_state.dart';
import 'package:two_min/networking/exceptions/api_exception.dart';
import 'package:two_min/networking/exceptions/app_exception.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repositories/login_repository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository loginRepository;
  var _isShowHidePassword = true;

  LoginBloc({
    required this.loginRepository,
  }) : super(LoginInitState()) {
    on<LoginPressedEvent>(_login);
    on<ShowHidePasswordEvent>(_showHidePassword);
  }

  Future<void> _login(LoginPressedEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoadingState());
    try {
      // final response = await loginRepository.login(event.email, event.password);
      // emit(LoginSuccessState(userEntity: response));
      emit(LoginSuccessState(userEntity: null));
    } on ApiException catch (apiError) {
      emit(LoginFailedState(errorMessage: apiError.errorMessage));
    } on AppException catch (appError) {
      emit(LoginFailedState(errorMessage: appError.message));
    }
  }

  void _showHidePassword(ShowHidePasswordEvent event, Emitter<LoginState> emit) {
    _isShowHidePassword = !_isShowHidePassword;
    emit(ShowHidePasswordState(showHidePassword: _isShowHidePassword));
  }
}
