import 'package:flash_chat/src/modules/auth/domain/user_entity.dart';

abstract class IGetSignedInUserUseCase {
  Future<UserEntity> call();
}
