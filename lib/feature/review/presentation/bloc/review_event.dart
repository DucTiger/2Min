import 'package:equatable/equatable.dart';
import 'package:two_min/feature/review/data/model/review_request.dart';

abstract class ReviewEvent extends Equatable {}

class AddReviewEvent extends ReviewEvent {
  final ReviewRequest? reviewRequest;

  AddReviewEvent({
    this.reviewRequest,
  });

  @override
  List<Object?> get props => [
        reviewRequest,
      ];
}

class HandleNextButtonStatusReviewEvent extends ReviewEvent {
  final int? activeCurrentStep;
  final String? impactScore;
  final String? impactReview;
  final String? feasibilityScore;
  final String? feasibilityReview;
  final String? auditabilityScore;
  final String? auditabilityReview;

  HandleNextButtonStatusReviewEvent({
    this.activeCurrentStep,
    this.impactScore,
    this.impactReview,
    this.feasibilityScore,
    this.feasibilityReview,
    this.auditabilityScore,
    this.auditabilityReview,
  });

  @override
  List<Object?> get props => [
        activeCurrentStep,
        impactScore,
        impactReview,
        feasibilityScore,
        feasibilityReview,
        auditabilityScore,
        auditabilityReview,
      ];
}
