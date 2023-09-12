import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'fund_response.g.dart';

@JsonSerializable()
class FundResponse extends Equatable {
  final String? id;
  final String? name;
  final String? description;

  const FundResponse({
    this.id,
    this.name,
    this.description,
  });

  factory FundResponse.fromJson(Map<String, dynamic> json) =>
      _$FundResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FundResponseToJson(this);

  @override
  List<Object?> get props => [
    id,
    name,
    description,
  ];
}
