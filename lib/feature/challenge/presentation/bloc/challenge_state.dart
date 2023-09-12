import 'package:equatable/equatable.dart';
import '../../domain/entity/fund_entity.dart';
import '../../domain/entity/challenge_entity.dart';

abstract class ChallengeState extends Equatable {}

class ChallengeInitState extends ChallengeState {
  @override
  List<Object?> get props => [];
}

class ShowListFundState extends ChallengeState {
  final List<FundEntity>? funds;

  ShowListFundState({
    required this.funds,
  });

  @override
  List<Object?> get props => [funds];
}

class ListFundFailedState extends ChallengeState {
  final String? errorMessage;

  ListFundFailedState({
    this.errorMessage,
  });

  @override
  List<Object?> get props => [
    errorMessage,
  ];
}

class ShowLoadingListFundState extends ChallengeState {
  @override
  List<Object?> get props => [];
}

class ShowListChallengeState extends ChallengeState {
  final List<ChallengeEntity>? challenges;

  ShowListChallengeState({
    required this.challenges,
  });

  @override
  List<Object?> get props => [challenges];
}

class ListChallengeFailedState extends ChallengeState {
  final String? errorMessage;

  ListChallengeFailedState({
    this.errorMessage,
  });

  @override
  List<Object?> get props => [
    errorMessage,
  ];
}

class ShowLoadingListChallengeState extends ChallengeState {
  @override
  List<Object?> get props => [];
}
