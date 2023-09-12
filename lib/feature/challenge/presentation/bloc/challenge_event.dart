import 'package:equatable/equatable.dart';

abstract class ChallengeEvent extends Equatable {}

class ShowListFundEvent extends ChallengeEvent {
  @override
  List<Object?> get props => [];
}

class ShowListChallengeEvent extends ChallengeEvent {
  final String? fundId;

  ShowListChallengeEvent({this.fundId});

  @override
  List<Object?> get props => [fundId];
}
