import 'package:two_min/feature/login/data/models/user_response.dart';
import 'package:two_min/feature/login/domain/entities/user_entity.dart';

extension UserResponseExt on UserResponse {
  UserEntity get entity => UserEntity(
        id: id,
        username: username,
        email: email,
      );
}
