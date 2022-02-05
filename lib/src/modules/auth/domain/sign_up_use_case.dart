import 'package:flash_chat/src/modules/auth/domain/flash_chat_auth_exception.dart';
import 'package:flash_chat/src/modules/auth/domain/user_credentials.dart';
import 'package:flash_chat/src/modules/auth/domain/user_entity.dart';
import 'package:flash_chat/src/modules/auth/domain/auth_service.dart';

abstract class ISignUpUseCase {
  Future<UserEntity> call(UserCredentials credentials);
}

class SignUpWithPhoneUseCase implements ISignUpUseCase {
  final AuthService authService;

  SignUpWithPhoneUseCase(this.authService);

  @override
  Future<UserEntity> call(covariant PhoneCredentials credentials) async {
    if (credentials.validate()) {
      return await authService.signUpWithPhone(credentials.phone);
    } else {
      throw InvalidCredentialsException(
        "The phone number '${credentials.phone}' is invalid.",
      );
    }
  }
}
