// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'challenge_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChallengeResponse _$ChallengeResponseFromJson(Map<String, dynamic> json) =>
    ChallengeResponse(
      id: json['id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      fundId: json['fundId'] as String?,
    );

Map<String, dynamic> _$ChallengeResponseToJson(ChallengeResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'fundId': instance.fundId,
    };
