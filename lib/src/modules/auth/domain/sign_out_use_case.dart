import 'package:flash_chat/src/modules/auth/domain/auth_service.dart';

abstract class ISignOutUseCase {
  Future<void> call();
}

class SignOutUseCase implements ISignOutUseCase {
  final AuthService authService;

  SignOutUseCase(this.authService);

  @override
  Future<void> call() async {
    await authService.signOut();
  }
}
