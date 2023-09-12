import 'package:two_min/feature/review/data/model/review_request.dart';

abstract class ReviewRepository {
  Future<void> review(ReviewRequest? reviewRequest);
}