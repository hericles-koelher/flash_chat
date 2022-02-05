import 'package:flash_chat/src/modules/auth/domain/auth_service.dart';
import 'package:flash_chat/src/modules/auth/domain/user_entity.dart';

abstract class IGetSignedInUserUseCase {
  UserEntity? call();
}

class GetSignedInUserUseCase implements IGetSignedInUserUseCase {
  final AuthService authService;

  GetSignedInUserUseCase(this.authService);

  @override
  UserEntity? call() {
    return authService.currentUser;
  }
}
