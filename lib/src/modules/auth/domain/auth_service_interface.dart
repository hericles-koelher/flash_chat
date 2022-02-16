abstract class IAuthService {
  String? get userUID;

  Stream<String?> userUIDStream();

  Future<String> signInWithEmail(
    String email,
    String password,
  );

  Future<String> signUpWithEmail(
    String email,
    String password,
  );

  Future<void> signOut();

  Future<void> deleteAccount();
}
