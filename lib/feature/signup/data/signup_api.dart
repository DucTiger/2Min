import 'package:two_min/common/data/model/user_response.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import 'package:two_min/config/api_constant.dart';
import 'package:two_min/feature/signup/data/model/signup_request.dart';


part 'signup_api.g.dart';

@RestApi()
abstract class SignupApi {
  factory SignupApi(Dio dio, {String baseUrl}) = _SignupApi;

  @POST(ApiConstant.users)
  Future<UserResponse> signup(@Body() SignupRequest body);
}
