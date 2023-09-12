import 'package:two_min/common/data/entity/user_entity.dart';

import '../../data/model/signup_request.dart';

abstract class SignupRepository {
  Future<UserEntity> signup(SignupRequest? signupRequest);
}