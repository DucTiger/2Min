import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:two_min/feature/challenge/domain/repository/challenge_repository.dart';
import 'package:two_min/feature/challenge/presentation/bloc/challenge_event.dart';
import 'package:two_min/feature/challenge/presentation/bloc/challenge_state.dart';

import 'package:two_min/networking/exceptions/api_exception.dart';
import 'package:two_min/networking/exceptions/app_exception.dart';

class ChallengeBloc extends Bloc<ChallengeEvent, ChallengeState> {
  final ChallengeRepository challengeRepository;

  ChallengeBloc({
    required this.challengeRepository,
  }) : super(ChallengeInitState()) {
    on<ShowListFundEvent>(_getListFund);
    on<ShowListChallengeEvent>(_getListChallenge);
  }

  Future<void> _getListFund(
      ShowListFundEvent event,
      Emitter<ChallengeState> emitter,
      ) async {
    try {
      emitter(ShowLoadingListFundState());
      final response = await challengeRepository.getListFund();
      emitter(ShowListFundState(funds: response));
      add(ShowListChallengeEvent(fundId: response?[0].id));
    } on ApiException catch (apiError) {
      emitter(ListFundFailedState(errorMessage: apiError.errorMessage));
    } on AppException catch (appError) {
      emitter(ListFundFailedState(errorMessage: appError.message));
    }
  }

  Future<void> _getListChallenge(
    ShowListChallengeEvent event,
    Emitter<ChallengeState> emitter,
  ) async {
    try {
      emitter(ShowLoadingListChallengeState());
      final response = await challengeRepository.getListChallenge(event.fundId);
      emitter(ShowListChallengeState(challenges: response));
    } on ApiException catch (apiError) {
      emitter(ListChallengeFailedState(errorMessage: apiError.errorMessage));
    } on AppException catch (appError) {
      emitter(ListChallengeFailedState(errorMessage: appError.message));
    }
  }
}
