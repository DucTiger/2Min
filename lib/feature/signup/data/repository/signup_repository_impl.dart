import 'package:dio/dio.dart';
import 'package:two_min/common/data/entity/user_entity.dart';

import 'package:two_min/feature/signup/data/model/signup_request.dart';
import 'package:two_min/feature/signup/data/signup_api.dart';
import 'package:two_min/feature/signup/data/mapper/user_response_mapper.dart';
import 'package:two_min/networking/exceptions/api_exception.dart';
import 'package:two_min/networking/exceptions/app_exception.dart';
import 'package:two_min/feature/signup/domain/repository/signup_repository.dart';

class SignupRepositoryImpl implements SignupRepository {
  final SignupApi signupApi;

  SignupRepositoryImpl({required this.signupApi});

  @override
  Future<UserEntity> signup(SignupRequest? signupRequest) async {
    try {
      final userResponse = await signupApi.signup(signupRequest!);
      return userResponse.entity;
    } on DioError catch (dioError) {
      throw ApiException(exception: dioError);
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }
}
