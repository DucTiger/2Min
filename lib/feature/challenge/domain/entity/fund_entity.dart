import 'package:equatable/equatable.dart';

class FundEntity extends Equatable {
  final String? id;
  final String? name;
  final String? description;

  const FundEntity({
    this.id,
    this.name,
    this.description,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
      ];
}
