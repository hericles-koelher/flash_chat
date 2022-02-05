import 'package:flash_chat/src/modules/auth/domain/user_credentials.dart';
import 'package:flash_chat/src/modules/auth/domain/user_entity.dart';

abstract class AuthService {
  UserEntity? get currentUser;

  Future<UserEntity> signInWithPhone(String phone);

  Future<UserEntity> signUpWithPhone(String phone);

  Future<void> signOut();
}
