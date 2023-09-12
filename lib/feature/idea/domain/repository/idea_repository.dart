import 'package:two_min/feature/idea/domain/entity/idea_entity.dart';

abstract class IdeaRepository {
  Future<List<IdeaEntity>?> getListIdea(String? challengeId);
}