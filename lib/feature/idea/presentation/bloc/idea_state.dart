import 'package:equatable/equatable.dart';
import 'package:two_min/feature/idea/domain/entity/idea_entity.dart';

abstract class IdeaState extends Equatable {}

class IdeaInitState extends IdeaState {
  @override
  List<Object?> get props => [];
}

class ShowListIdeaState extends IdeaState {
  final List<IdeaEntity>? ideas;

  ShowListIdeaState({
    required this.ideas,
  });

  @override
  List<Object?> get props => [ideas];
}

class ListIdeaFailedState extends IdeaState {
  final String? errorMessage;

  ListIdeaFailedState({
    this.errorMessage,
  });

  @override
  List<Object?> get props => [
        errorMessage,
      ];
}

class ShowLoadingListIdeaState extends IdeaState {
  @override
  List<Object?> get props => [];
}
