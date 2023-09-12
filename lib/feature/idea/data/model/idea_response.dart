import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'idea_response.g.dart';

@JsonSerializable()
class IdeaResponse extends Equatable {
  final String? id;
  final String? name;
  final String? problem;
  final String? solution;
  final String? web;
  final String? youtube;
  final String? requestedFunds;
  final String? impact;
  final String? auditability;
  final String? challengeId;

  const IdeaResponse({
    this.id,
    this.name,
    this.problem,
    this.solution,
    this.web,
    this.youtube,
    this.requestedFunds,
    this.impact,
    this.auditability,
    this.challengeId,
  });

  factory IdeaResponse.fromJson(Map<String, dynamic> json) =>
      _$IdeaResponseFromJson(json);

  Map<String, dynamic> toJson() => _$IdeaResponseToJson(this);

  @override
  List<Object?> get props => [
    id,
    name,
    problem,
    solution,
    web,
    youtube,
    requestedFunds,
    impact,
    auditability,
    challengeId,
  ];
}