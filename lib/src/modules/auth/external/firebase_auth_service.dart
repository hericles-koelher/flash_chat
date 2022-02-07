import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/src/modules/auth/domain/auth_service_interface.dart';
import 'package:flash_chat/src/modules/core/domain/flash_chat_auth_exception.dart';

class FirebaseAuthService implements IAuthService {
  final FirebaseAuth _firebaseAuth;

  FirebaseAuthService(FirebaseAuth firebaseAuth) : _firebaseAuth = firebaseAuth;

  @override
  String? get currentUserUID => _firebaseAuth.currentUser?.uid;

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<String> signInWithEmail(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return _firebaseAuth.currentUser!.uid;
    } on FirebaseAuthException catch (e) {
      // TODO: use better messages.
      throw InvalidCredentialsException(
        e.message ?? "Something wrong happened",
      );
    }
  }

  @override
  Future<String> signUpWithEmail(String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return _firebaseAuth.currentUser!.uid;
    } on FirebaseAuthException catch (e) {
      // TODO: use better messages.
      throw InvalidCredentialsException(
        e.message ?? "Something wrong happened",
      );
    }
  }
}
