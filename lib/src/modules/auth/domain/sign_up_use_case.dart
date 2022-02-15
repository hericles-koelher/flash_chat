import '../auth.dart';

abstract class ISignUpUseCase {
  Future<String> call(UserCredential credential);
}

class SignUpWithEmailUseCase implements ISignUpUseCase {
  final IAuthService authService;

  SignUpWithEmailUseCase(this.authService);

  @override
  Future<String> call(covariant EmailCredential credential) async {
    credential.validate();

    var userUID = await authService.signUpWithEmail(
      credential.email,
      credential.password,
    );

    return userUID;
  }
}
