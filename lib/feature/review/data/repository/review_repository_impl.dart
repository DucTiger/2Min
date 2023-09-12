import 'package:dio/dio.dart';
import 'package:two_min/feature/review/data/model/review_request.dart';
import 'package:two_min/feature/review/domain/repository/review_repository.dart';

import 'package:two_min/feature/review/data/review_api.dart';
import 'package:two_min/networking/exceptions/api_exception.dart';
import 'package:two_min/networking/exceptions/app_exception.dart';

class ReviewRepositoryImpl implements ReviewRepository {
  final ReviewApi? reviewApi;

  ReviewRepositoryImpl({this.reviewApi});

  @override
  Future<void> review(ReviewRequest? reviewRequest) async {
    try {
      final _ = await reviewApi?.review(reviewRequest!);
    } on DioError catch (dioError) {
      throw ApiException(exception: dioError);
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }
}
