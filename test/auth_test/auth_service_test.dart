import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/src/modules/auth/external/firebase_auth_service.dart';
import 'package:flash_chat/src/modules/core/domain/flash_chat_exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class FirebaseAuthMock extends Mock implements FirebaseAuth {}

class UserCredentialMock extends Mock implements UserCredential {}

class UserMock extends Mock implements User {}

void main() async {
  var firebaseAuth = FirebaseAuthMock();
  var userCredentialMock = UserCredentialMock();
  var userMock = UserMock();
  var testUID = "efb88c05-478a-4cce-8e51-4a27208f0232";
  test("Success - Sign Up With Email Test", () async {
    var authService = FirebaseAuthService(firebaseAuth);

    when(firebaseAuth)
        .calls(const Symbol("createUserWithEmailAndPassword"))
        .thenReturn(Future.value(userCredentialMock));

    when(firebaseAuth).calls(const Symbol("currentUser")).thenReturn(userMock);

    when(userMock).calls(const Symbol("uid")).thenReturn(testUID);

    var uid = await authService.signUpWithEmail(
      "pericles@contato.com.br",
      "SeEuLargarOFreio",
    );

    expect(uid, testUID);
  });

  test("Success - Sign In With Email Test", () async {
    var authService = FirebaseAuthService(firebaseAuth);

    when(firebaseAuth)
        .calls(const Symbol("signInWithEmailAndPassword"))
        .thenReturn(Future.value(userCredentialMock));

    when(firebaseAuth).calls(const Symbol("currentUser")).thenReturn(userMock);

    when(userMock).calls(const Symbol("uid")).thenReturn(testUID);

    var uid = await authService.signInWithEmail(
      "pericles@contato.com.br",
      "SeEuLargarOFreio",
    );

    expect(uid, testUID);
  });

  test("Success - Sign Out Test", () async {
    var authService = FirebaseAuthService(firebaseAuth);

    when(firebaseAuth)
        .calls(const Symbol("signOut"))
        .thenReturn(Future.value());

    expect(authService.signOut, returnsNormally);
  });

  test("Error - E-mail Already In Use During Sign Up Test", () async {
    var authService = FirebaseAuthService(firebaseAuth);

    when(firebaseAuth)
        .calls(const Symbol("createUserWithEmailAndPassword"))
        .thenThrow(
          FirebaseAuthException(
              code: "email-already-in-use",
              message:
                  "Already exists an account with the given email address."),
        );

    expect(() async {
      await authService.signUpWithEmail(
        "pericles@contato.com.br",
        "SeEuLargarOFreio",
      );
    }, throwsA(isA<InvalidCredentialException>()));
  });

  test("Error - Wrong Password During Sign In Test", () async {
    var authService = FirebaseAuthService(firebaseAuth);

    when(firebaseAuth)
        .calls(const Symbol("signInWithEmailAndPassword"))
        .thenThrow(
          FirebaseAuthException(
            code: "wrong-password",
            message: '''Password is invalid for the given email,
                or the account corresponding to the email
                does not have a password set.''',
          ),
        );

    expect(() async {
      await authService.signInWithEmail(
        "pericles@contato.com.br",
        "SeEuLargarOFreio",
      );
    }, throwsA(isA<InvalidCredentialException>()));
  });
}
