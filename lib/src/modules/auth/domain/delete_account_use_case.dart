import 'package:flash_chat/src/modules/auth/domain/auth_service_interface.dart';

abstract class IDeleteAccountUseCase {
  Future<void> call();
}

class DeleteAccountUseCase implements IDeleteAccountUseCase {
  final IAuthService authService;

  DeleteAccountUseCase(this.authService);

  @override
  Future<void> call() => authService.deleteAccount();
}
