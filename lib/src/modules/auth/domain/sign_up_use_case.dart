import 'package:flash_chat/src/modules/auth/domain/auth_service_interface.dart';
import 'package:flash_chat/src/modules/auth/domain/user_credentials.dart';

import '../../core/domain/flash_chat_auth_exception.dart';

abstract class ISignUpUseCase {
  Future<String> call(UserCredentials credentials);
}

class SignUpWithEmailUseCase implements ISignUpUseCase {
  final IAuthService authService;

  SignUpWithEmailUseCase(this.authService);

  @override
  Future<String> call(covariant CredentialForEmailSignUp credentials) async {
    if (credentials.validate()) {
      var userUID = await authService.signUpWithEmail(
        credentials.email,
        credentials.password,
      );

      return userUID;
    } else {
      throw InvalidCredentialsException(
        "Invalid email and/or password.",
      );
    }
  }
}
