import '../auth.dart';

abstract class ISignOutUseCase {
  Future<void> call();
}

class SignOutUseCase implements ISignOutUseCase {
  final IAuthService authService;

  SignOutUseCase(this.authService);

  @override
  Future<void> call() async {
    await authService.signOut();
  }
}
