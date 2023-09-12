import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:two_min/networking/exceptions/api_exception.dart';
import 'package:two_min/networking/exceptions/app_exception.dart';

import 'package:two_min/feature/idea/domain/repository/idea_repository.dart';
import 'idea_event.dart';
import 'idea_state.dart';

class IdeaBloc extends Bloc<IdeaEvent, IdeaState> {
  final IdeaRepository ideaRepository;

  IdeaBloc({
    required this.ideaRepository,
  }) : super(IdeaInitState()) {
    on<ListIdeaEvent>(_getListIdea);
  }

  Future<void> _getListIdea(
    ListIdeaEvent event,
    Emitter<IdeaState> emitter,
  ) async {
    try {
      emitter(ShowLoadingListIdeaState());
      final response = await ideaRepository.getListIdea(event.challengeId);
      emitter(ShowListIdeaState(ideas: response));
    } on ApiException catch (apiError) {
      emitter(ListIdeaFailedState(errorMessage: apiError.errorMessage));
    } on AppException catch (appError) {
      emitter(ListIdeaFailedState(errorMessage: appError.message));
    }
  }
}
