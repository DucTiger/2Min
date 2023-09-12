import 'package:equatable/equatable.dart';

class ChallengeEntity extends Equatable {
  final String? id;
  final String? name;
  final String? description;
  final String? fundId;

  const ChallengeEntity({
    this.id,
    this.name,
    this.description,
    this.fundId,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        fundId,
      ];
}
