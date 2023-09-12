import 'package:two_min/feature/challenge/domain/entity/challenge_entity.dart';
import 'package:two_min/feature/challenge/domain/entity/fund_entity.dart';


abstract class ChallengeRepository {
  Future<List<FundEntity>?> getListFund();
  Future<List<ChallengeEntity>?> getListChallenge(String? fundId);
}