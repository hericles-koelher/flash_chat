import 'package:flash_chat/src/modules/auth/domain/user_credentials.dart';
import 'package:flash_chat/src/modules/auth/domain/user_entity.dart';

abstract class ISignUpUseCase {
  Future<UserEntity> call(UserCredentials credentials);
}
