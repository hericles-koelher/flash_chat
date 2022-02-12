import '../../core/core.dart';
import '../auth.dart';

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
