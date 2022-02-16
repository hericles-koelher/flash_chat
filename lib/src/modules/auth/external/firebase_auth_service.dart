import 'package:firebase_auth/firebase_auth.dart';

import '../../core/core.dart';
import '../auth.dart';

class FirebaseAuthService implements IAuthService {
  final FirebaseAuth _firebaseAuth;

  FirebaseAuthService(FirebaseAuth firebaseAuth) : _firebaseAuth = firebaseAuth;

  @override
  String? get userUID => _firebaseAuth.currentUser?.uid;

  @override
  Stream<String?> userUIDStream() =>
      _firebaseAuth.idTokenChanges().map((User? user) => user?.uid);

  @override
  Future<String> signUpWithEmail(String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return _firebaseAuth.currentUser!.uid;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "email-already-in-use":
          throw InvalidCredentialException(
            message: "Another account with the given email address was found.",
            emailMessage: "Try again after change the email address.",
          );
        case "invalid-email":
          throw InvalidCredentialException(
            message: "Invalid email address.",
            emailMessage: "Try again after change the email address.",
          );
        case "weak-password":
          throw InvalidCredentialException(
            message: "Informed password is weak.",
            passwordMessage: "Please, try again with a better password.",
          );
        default: // code = operation-not-allowed
          throw InvalidCredentialException(
            message:
                "Internal error occurred, please contact the developer and try again later.",
          );
      }
    }
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
      switch (e.code) {
        case "invalid-email":
          throw InvalidCredentialException(
            message: "Invalid email address.",
            emailMessage: "Try again after change the email address.",
          );
        case "user-disabled":
          throw InvalidCredentialException(
            message: "This email address was disabled.",
            emailMessage: "Try again after change the email address.",
          );
        default: // codes = [user-not-found, wrong-password]
          throw InvalidCredentialException(
            message: "Wrong email and/or password.",
          );
      }
    }
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
