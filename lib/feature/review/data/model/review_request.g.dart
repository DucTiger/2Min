// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewRequest _$ReviewRequestFromJson(Map<String, dynamic> json) =>
    ReviewRequest(
      name: json['name'] as String?,
      impact: json['impact'] as String?,
      impactScore: json['impactScore'] as String?,
      feasibility: json['feasibility'] as String?,
      feasibilityScore: json['feasibilityScore'] as String?,
      auditability: json['auditability'] as String?,
      auditabilityScore: json['auditabilityScore'] as String?,
      userId: json['userId'] as String?,
      ideaId: json['ideaId'] as String?,
    );

Map<String, dynamic> _$ReviewRequestToJson(ReviewRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'impact': instance.impact,
      'impactScore': instance.impactScore,
      'feasibility': instance.feasibility,
      'feasibilityScore': instance.feasibilityScore,
      'auditability': instance.auditability,
      'auditabilityScore': instance.auditabilityScore,
      'userId': instance.userId,
      'ideaId': instance.ideaId,
    };
