import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'review_request.g.dart';

@JsonSerializable()
class ReviewRequest extends Equatable {
  final String? name;
  final String? impact;
  final String? impactScore;
  final String? feasibility;
  final String? feasibilityScore;
  final String? auditability;
  final String? auditabilityScore;
  final String? userId;
  final String? ideaId;

  const ReviewRequest({
    this.name,
    this.impact,
    this.impactScore,
    this.feasibility,
    this.feasibilityScore,
    this.auditability,
    this.auditabilityScore,
    this.userId, this.ideaId,
  });

  factory ReviewRequest.fromJson(Map<String, dynamic> json) =>
      _$ReviewRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewRequestToJson(this);

  @override
  List<Object?> get props =>
      [
        name,
        impact,
        impactScore,
        feasibility,
        feasibilityScore,
        auditability,
        auditabilityScore,
        userId,
        ideaId,
      ];
}
