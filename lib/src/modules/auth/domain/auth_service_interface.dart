abstract class IAuthService {
  String? get currentUserUID;

  Future<String> signInWithEmail(
    String email,
    String password,
  );

  Future<String> signUpWithEmail(
    String email,
    String password,
  );

  Future<void> signOut();
}
