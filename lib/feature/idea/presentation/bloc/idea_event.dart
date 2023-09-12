import 'package:equatable/equatable.dart';

abstract class IdeaEvent extends Equatable {}

class ListIdeaEvent extends IdeaEvent {
  final String? challengeId;

  ListIdeaEvent({this.challengeId});

  @override
  List<Object?> get props => [challengeId];
}
