import 'package:flash_chat/src/modules/auth/domain/auth_service_interface.dart';
import 'package:flash_chat/src/modules/auth/domain/user_credential.dart';

import '../../core/domain/flash_chat_exception.dart';

abstract class ISignUpUseCase {
  Future<String> call(UserCredential credential);
}

class SignUpWithEmailUseCase implements ISignUpUseCase {
  final IAuthService authService;

  SignUpWithEmailUseCase(this.authService);

  @override
  Future<String> call(covariant EmailCredential credential) async {
    if (credential.validate()) {
      var userUID = await authService.signUpWithEmail(
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
