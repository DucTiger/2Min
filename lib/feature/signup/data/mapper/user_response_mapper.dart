import 'package:two_min/common/data/entity/user_entity.dart';

import '../../../../common/data/model/user_response.dart';

extension UserResponseExt on UserResponse {
  UserEntity get entity => UserEntity(
        username: username,
        email: email,
        password: password,
        id: id,
      );
}
