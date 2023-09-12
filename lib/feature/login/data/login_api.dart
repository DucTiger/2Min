import 'package:two_min/config/api_constant.dart';
import 'package:two_min/feature/login/data/models/user_response.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import 'models/user_request.dart';

part 'login_api.g.dart';

@RestApi()
abstract class LoginApi {
  factory LoginApi(Dio dio, {String baseUrl}) = _LoginApi;

  @POST(ApiConstant.signIn)
  Future<UserResponse> login(@Body() UserRequest request);
}
