import 'user_entity.dart';

abstract class IUserRepository {
  Future<UserEntity> create(UserEntity user);

  Future<UserEntity> getByUID(String uid);
}
