import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'challenge_response.g.dart';

@JsonSerializable()
class ChallengeResponse extends Equatable {
  final String? id;
  final String? name;
  final String? description;
  final String? fundId;

  const ChallengeResponse({
    this.id,
    this.name,
    this.description,
    this.fundId,
  });

  factory ChallengeResponse.fromJson(Map<String, dynamic> json) =>
      _$ChallengeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ChallengeResponseToJson(this);

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        fundId,
      ];
}
