import 'package:equatable/equatable.dart';

abstract class ReviewState extends Equatable {}

class ReviewInitState extends ReviewState {
  @override
  List<Object?> get props => [];
}

class ShowReviewLoadingState extends ReviewState {
  @override
  List<Object?> get props => [];
}

class ReviewSuccessState extends ReviewState {
  @override
  List<Object?> get props => [];
}

class ReviewFailedState extends ReviewState {
  final String? errorMessage;

  ReviewFailedState({
    this.errorMessage,
  });

  @override
  List<Object?> get props => [
        errorMessage,
      ];
}

class NextButtonStatusReviewState extends ReviewState {
  final bool? isEnable;
  final int? currentStep;

  NextButtonStatusReviewState({
    this.isEnable,
    this.currentStep,
  });

  @override
  List<Object?> get props => [
        isEnable,
        currentStep,
      ];
}
