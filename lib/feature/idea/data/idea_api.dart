import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import 'package:two_min/config/api_constant.dart';
import 'package:two_min/feature/idea/data/model/idea_response.dart';

part 'idea_api.g.dart';

@RestApi()
abstract class IdeaApi {
  factory IdeaApi(Dio dio, {String baseUrl}) = _IdeaApi;

  @GET(ApiConstant.ideas)
  Future<List<IdeaResponse>> getListIdea(@Query("filter") String challengeId);
}