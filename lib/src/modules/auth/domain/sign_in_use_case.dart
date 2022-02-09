import 'package:flash_chat/src/modules/auth/domain/user_credential.dart';
import 'package:flash_chat/src/modules/auth/domain/auth_service_interface.dart';

import '../../core/domain/flash_chat_exception.dart';

abstract class ISignInUseCase {
  Future<String> call(UserCredential credential);
}

class SignInWithEmailUseCase implements ISignInUseCase {
  final IAuthService authService;

  SignInWithEmailUseCase(this.authService);

  @override
  Future<String> call(covariant EmailCredential credential) async {
    if (credential.validate()) {
      var userUID = await authService.signInWithEmail(
        credential.email,
        credential.password,
      );

      return userUID;
    } else {
      throw InvalidCredentialException(
        "Invalid email and/or password.",
      );
    }
  }
}
