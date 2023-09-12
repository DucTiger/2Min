// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'idea_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IdeaResponse _$IdeaResponseFromJson(Map<String, dynamic> json) => IdeaResponse(
      id: json['id'] as String?,
      name: json['name'] as String?,
      problem: json['problem'] as String?,
      solution: json['solution'] as String?,
      web: json['web'] as String?,
      youtube: json['youtube'] as String?,
      requestedFunds: json['requestedFunds'] as String?,
      impact: json['impact'] as String?,
      auditability: json['auditability'] as String?,
      challengeId: json['challengeId'] as String?,
    );

Map<String, dynamic> _$IdeaResponseToJson(IdeaResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'problem': instance.problem,
      'solution': instance.solution,
      'web': instance.web,
      'youtube': instance.youtube,
      'requestedFunds': instance.requestedFunds,
      'impact': instance.impact,
      'auditability': instance.auditability,
      'challengeId': instance.challengeId,
    };
