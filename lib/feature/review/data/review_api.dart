import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import 'package:two_min/config/api_constant.dart';

import 'package:two_min/feature/review/data/model/review_request.dart';

part 'review_api.g.dart';

@RestApi()
abstract class ReviewApi {
  factory ReviewApi(Dio dio, {String baseUrl}) = _ReviewApi;

  @POST(ApiConstant.reviews)
  Future<void> review(@Body() ReviewRequest reviewRequest);
}
