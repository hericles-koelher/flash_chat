import 'package:flash_chat/src/modules/auth/domain/user_credentials.dart';
import 'package:flash_chat/src/modules/auth/domain/user_entity.dart';
import 'package:flash_chat/src/modules/auth/domain/auth_service.dart';

import 'flash_chat_auth_exception.dart';

abstract class ISignInUseCase {
  Future<UserEntity> call(UserCredentials credentials);
}

class SignInWithPhoneUseCase implements ISignInUseCase {
  final AuthService authService;

  SignInWithPhoneUseCase(this.authService);

  @override
  Future<UserEntity> call(covariant PhoneCredentials credentials) async {
    if (credentials.validate()) {
      return await authService.signInWithPhone(credentials.phone);
    } else {
      throw InvalidCredentialsException(
        "The phone number '${credentials.phone}' is invalid.",
      );
    }
  }
}
