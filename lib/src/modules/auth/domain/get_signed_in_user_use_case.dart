import '../auth.dart';

abstract class IGetSignedInUserUseCase {
  String? call();
}

class GetSignedInUserUseCase implements IGetSignedInUserUseCase {
  final IAuthService authService;

  GetSignedInUserUseCase(this.authService);

  @override
  String? call() => authService.currentUserUID;
}
