import 'package:equatable/equatable.dart';

class IdeaEntity extends Equatable {
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

  const IdeaEntity({
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
