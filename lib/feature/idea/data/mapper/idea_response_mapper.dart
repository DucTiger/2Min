import 'package:two_min/feature/idea/data/model/idea_response.dart';
import 'package:two_min/feature/idea/domain/entity/idea_entity.dart';

extension IdeaResponseExt on IdeaResponse {
  IdeaEntity get entity => IdeaEntity(
        id: id,
        name: name,
        problem: problem,
        solution: solution,
        web: web,
        youtube: youtube,
        requestedFunds: requestedFunds,
        impact: impact,
        auditability: auditability,
        challengeId: challengeId,
      );
}
