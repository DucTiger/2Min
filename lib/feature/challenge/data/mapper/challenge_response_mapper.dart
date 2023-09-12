import 'package:two_min/feature/challenge/data/model/challenge_response.dart';
import 'package:two_min/feature/challenge/domain/entity/challenge_entity.dart';

extension ChallengeResponseExt on ChallengeResponse {
  ChallengeEntity get entity => ChallengeEntity(
        id: id,
        name: name,
        description: description,
        fundId: fundId,
      );
}
