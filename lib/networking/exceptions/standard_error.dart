import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'standard_error.g.dart';

@JsonSerializable()
class StandardError extends Equatable {
  final String? message;
  final int? statusCode;
  final int? errorCode;

  const StandardError(
    this.message,
    this.statusCode,
    this.errorCode,
  );

  factory StandardError.fromJson(Map<String, dynamic> json) =>
      _$StandardErrorFromJson(json);

  Map<String, dynamic> toJson() => _$StandardErrorToJson(this);

  @override
  List<Object?> get props => [
        message,
        statusCode,
        errorCode,
      ];
}
