import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/src/modules/auth/domain/sign_in_use_case.dart';
import 'package:flash_chat/src/modules/auth/domain/sign_out_use_case.dart';
import 'package:flash_chat/src/modules/auth/domain/sign_up_use_case.dart';
import 'package:flash_chat/src/modules/auth/domain/user_credentials.dart';
import 'package:flash_chat/src/modules/auth/external/firebase_auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class FirebaseAuthMock extends Mock implements FirebaseAuth {}

class UserCredentialMock extends Mock implements UserCredential {}

class UserMock extends Mock implements User {}

void main() async {
  var firebaseAuth = FirebaseAuthMock();
  var userCredentialMock = UserCredentialMock();
  var userMock = UserMock();

  debugPrint("Happy Ending Tests");
  test("Sign-Up Test", () async {
    var authService = FirebaseAuthService(firebaseAuth);

    var signUpUseCase = SignUpWithEmailUseCase(authService);

    when(firebaseAuth)
        .calls(const Symbol("createUserWithEmailAndPassword"))
        .thenReturn(Future.value(userCredentialMock));

    when(firebaseAuth).calls(const Symbol("currentUser")).thenReturn(userMock);

    when(userMock).calls(const Symbol("uid")).thenReturn("testUID");

    var uidString = await signUpUseCase(
      CredentialForEmailSignUp(
        displayName: "Bruno",
        email: "brunokoelher@hotmail.com",
        password: "digimon2499@",
      ),
    );

    expect(uidString, isA<String>());
  });

  test("Sign-In Test", () async {
    var authService = FirebaseAuthService(firebaseAuth);

    var signInUseCase = SignInWithEmailUseCase(authService);

    when(firebaseAuth)
        .calls(const Symbol("signInWithEmailAndPassword"))
        .thenReturn(Future.value(userCredentialMock));

    when(firebaseAuth).calls(const Symbol("currentUser")).thenReturn(userMock);

    when(userMock).calls(const Symbol("uid")).thenReturn("testUID");

    var uidString = await signInUseCase(
      CredentialForEmailSignIn(
        email: "brunokoelher@hotmail.com",
        password: "digimon2499@",
      ),
    );

    expect(uidString, isA<String>());
  });

  test("Sign-Out Test", () async {
    var authService = FirebaseAuthService(firebaseAuth);

    var signOutUseCase = SignOutUseCase(authService);

    when(firebaseAuth)
        .calls(const Symbol("signOut"))
        .thenReturn(Future.value());

    expect(signOutUseCase.call, returnsNormally);
  });

  debugPrint("Bad Ending Tests Coming Soon...");
}
