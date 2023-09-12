import 'package:two_min/feature/challenge/data/model/fund_response.dart';
import 'package:two_min/feature/challenge/domain/entity/fund_entity.dart';

extension FundResponseExt on FundResponse {
  FundEntity get entity => FundEntity(
    id: id,
    name: name,
    description: description,
  );
}