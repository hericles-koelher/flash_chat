import 'package:flash_chat/src/modules/auth/domain/user_credentials.dart';
import 'package:flash_chat/src/modules/auth/domain/user_entity.dart';

abstract class UserRepository {
  UserEntity? get currentUser;

  Future<UserEntity> signInWithPhone(UserCredentials phone);

  Future<UserEntity> signUpWithPhone(UserCredentials phone);

  Future<void> signOut();
}
