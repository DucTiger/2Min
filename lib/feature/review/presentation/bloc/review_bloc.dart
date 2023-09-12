import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:two_min/config/constant.dart';
import 'package:two_min/feature/review/domain/repository/review_repository.dart';
import 'package:two_min/feature/review/presentation/bloc/review_event.dart';
import 'package:two_min/feature/review/presentation/bloc/review_state.dart';

import 'package:two_min/networking/exceptions/api_exception.dart';
import 'package:two_min/networking/exceptions/app_exception.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  final ReviewRepository reviewRepository;

  ReviewBloc({
    required this.reviewRepository,
  }) : super(ReviewInitState()) {
    on<AddReviewEvent>(_addReview);
    on<HandleNextButtonStatusReviewEvent>(_handleNextButtonStatus);
  }

  Future<void> _addReview(
    AddReviewEvent event,
    Emitter<ReviewState> emitter,
  ) async {
    try {
      emitter(ShowReviewLoadingState());
      final _ = await reviewRepository.review(event.reviewRequest);
      emitter(ReviewSuccessState());
    } on ApiException catch (apiError) {
      emitter(ReviewFailedState(errorMessage: apiError.errorMessage));
    } on AppException catch (appError) {
      emitter(ReviewFailedState(errorMessage: appError.message));
    }
  }

  Future<void> _handleNextButtonStatus(
    HandleNextButtonStatusReviewEvent event,
    Emitter<ReviewState> emitter,
  ) async {
    final activeCurrentStep = event.activeCurrentStep ?? 0;
    final impactScore = event.impactScore;
    final impactReview = event.impactReview;
    final feasibilityScore = event.feasibilityScore;
    final feasibilityReview = event.feasibilityReview;
    final auditabilityScore = event.auditabilityScore;
    final auditabilityReview = event.auditabilityReview;

    bool isEnable = false;

    if (activeCurrentStep <= impactStep &&
        impactScore != null &&
        impactReview!.isNotEmpty) {
      isEnable = true;
    } else if (activeCurrentStep >= feasibilityStep &&
        feasibilityScore != null &&
        feasibilityReview!.isNotEmpty) {
      isEnable = true;
    } else if (activeCurrentStep >= auditabilityStep &&
        auditabilityScore != null &&
        auditabilityReview!.isNotEmpty) {
      isEnable = true;
    }

    emitter(NextButtonStatusReviewState(
      isEnable: isEnable,
      currentStep: activeCurrentStep,
    ));
  }
}
