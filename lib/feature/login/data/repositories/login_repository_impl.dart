import 'package:two_min/feature/login/data/mappers/user_response_mapper.dart';
import 'package:two_min/feature/login/data/models/user_request.dart';
import 'package:two_min/feature/login/domain/entities/user_entity.dart';
import 'package:two_min/feature/login/domain/repositories/login_repository.dart';

import 'package:two_min/feature/login/data/login_api.dart';
import 'package:two_min/networking/exceptions/api_exception.dart';
import 'package:two_min/networking/exceptions/app_exception.dart';
import 'package:dio/dio.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginApi? loginApi;

  LoginRepositoryImpl({
    required this.loginApi,
  });

  @override
  Future<UserEntity> login(String email, String password) async {
    try {
      final userResponse = await loginApi?.login(UserRequest(
        email: email,
        password: password,
      ));
      return userResponse!.entity;
    } on DioError catch (dioError) {
      throw ApiException(exception: dioError);
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }
}
