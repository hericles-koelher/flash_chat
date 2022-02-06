import 'package:flash_chat/src/modules/auth/domain/user_credentials.dart';
import 'package:flash_chat/src/modules/auth/domain/auth_service_interface.dart';

import '../../core/domain/flash_chat_auth_exception.dart';

abstract class ISignInUseCase {
  Future<String> call(UserCredentials credentials);
}

class SignInWithEmailUseCase implements ISignInUseCase {
  final IAuthService authService;

  SignInWithEmailUseCase(this.authService);

  @override
  Future<String> call(covariant CredentialForEmailSignIn credentials) async {
    if (credentials.validate()) {
      var userUID = await authService.signInWithEmail(
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
