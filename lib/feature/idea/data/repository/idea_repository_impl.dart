import 'package:dio/dio.dart';
import 'package:two_min/feature/idea/data/idea_api.dart';
import 'package:two_min/feature/idea/domain/entity/idea_entity.dart';
import 'package:two_min/feature/idea/data/mapper/idea_response_mapper.dart';
import 'package:two_min/networking/exceptions/api_exception.dart';
import 'package:two_min/networking/exceptions/app_exception.dart';
import 'package:two_min/feature/idea/domain/repository/idea_repository.dart';

class IdeaRepositoryImpl implements IdeaRepository {
  final IdeaApi ideaApi;

  IdeaRepositoryImpl({required this.ideaApi});

  @override
  Future<List<IdeaEntity>?> getListIdea(String? challengeId) async {
    try {
      final queryByChallengeId = '{"where":{"challengeId":"$challengeId"}}';
      final ideaResponse = await ideaApi.getListIdea(queryByChallengeId);
      return ideaResponse.map((e) => e.entity).toList();
    } on DioError catch (dioError) {
      throw ApiException(exception: dioError);
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }
}
