import 'package:two_min/feature/challenge/data/model/challenge_response.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import 'package:two_min/config/api_constant.dart';

import 'package:two_min/feature/challenge/data/model/fund_response.dart';

part 'challenge_api.g.dart';

@RestApi()
abstract class ChallengeApi {
  factory ChallengeApi(Dio dio, {String baseUrl}) = _ChallengeApi;

  @GET(ApiConstant.funds)
  Future<List<FundResponse>> getListFund();

  @GET(ApiConstant.challenges)
  Future<List<ChallengeResponse>> getListChallenge(
      @Query("filter") String fundId);
}
