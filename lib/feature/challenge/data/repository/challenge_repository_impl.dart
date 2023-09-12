import 'package:dio/dio.dart';
import 'package:two_min/feature/challenge/data/mapper/challenge_response_mapper.dart';
import 'package:two_min/feature/challenge/domain/entity/challenge_entity.dart';
import 'package:two_min/feature/challenge/data/mapper/fund_response_mapper.dart';
import 'package:two_min/feature/challenge/domain/repository/challenge_repository.dart';
import 'package:two_min/feature/challenge/data/challenge_api.dart';

import 'package:two_min/networking/exceptions/app_exception.dart';

import 'package:two_min/networking/exceptions/api_exception.dart';

import 'package:two_min/feature/challenge/domain/entity/fund_entity.dart';


class ChallengeRepositoryImpl implements ChallengeRepository {
  final ChallengeApi challengeApi;

  ChallengeRepositoryImpl({
    required this.challengeApi,
  });

  @override
  Future<List<FundEntity>?> getListFund() async {
    try {
      final fundResponse = await challengeApi.getListFund();
      return fundResponse.map((e) => e.entity).toList();
    } on DioError catch (dioError) {
      throw ApiException(exception: dioError);
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  @override
  Future<List<ChallengeEntity>?> getListChallenge(String? fundId) async {
    try {
      final queryByFundId = '{"where":{"fundId":"$fundId"}}';
      final challengeResponse =
          await challengeApi.getListChallenge(queryByFundId);
      return challengeResponse.map((e) => e.entity).toList();
    } on DioError catch (dioError) {
      throw ApiException(exception: dioError);
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }
}
