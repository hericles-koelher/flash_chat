import '../auth.dart';

abstract class IGetCurrentUserUseCase {
  String? call();

  Stream<String?> stream();
}

class GetCurrentUserUseCase implements IGetCurrentUserUseCase {
  final IAuthService authService;

  GetCurrentUserUseCase(this.authService);

  @override
  String? call() => authService.userUID;

  @override
  Stream<String?> stream() => authService.userUIDStream();
}
