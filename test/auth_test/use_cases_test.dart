import 'package:flash_chat/src/modules/auth/domain/sign_in_use_case.dart';
import 'package:flash_chat/src/modules/auth/domain/sign_out_use_case.dart';
import 'package:flash_chat/src/modules/auth/domain/sign_up_use_case.dart';
import 'package:flash_chat/src/modules/auth/domain/user_credential.dart';
import 'package:flash_chat/src/modules/auth/external/firebase_auth_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class FirebaseAuthServiceMock extends Mock implements FirebaseAuthService {}

void main() async {
  var firebaseAuthServiceMock = FirebaseAuthServiceMock();
  var testUID = "efb88c05-478a-4cce-8e51-4a27208f0232";

  test("Success - Sign-Up Test", () async {
    var signUpUseCase = SignUpWithEmailUseCase(firebaseAuthServiceMock);

    when(firebaseAuthServiceMock)
        .calls(const Symbol("signUpWithEmail"))
        .thenReturn(Future.value(testUID));

    var uidString = await signUpUseCase(
      EmailCredential(
        email: "pericles@contato.com.br",
        password: "digimon2499@",
      ),
    );

    expect(uidString, testUID);
  });

  test("Success - Sign-In Test", () async {
    var signInUseCase = SignInWithEmailUseCase(firebaseAuthServiceMock);

    when(firebaseAuthServiceMock)
        .calls(const Symbol("signInWithEmail"))
        .thenReturn(Future.value(testUID));

    var uidString = await signInUseCase(
      EmailCredential(
        email: "pericles@contato.com.br",
        password: "digimon2499@",
      ),
    );

    expect(uidString, testUID);
  });

  test("Success - Sign-Out Test", () async {
    var signOutUseCase = SignOutUseCase(firebaseAuthServiceMock);

    when(firebaseAuthServiceMock)
        .calls(const Symbol("signOut"))
        .thenReturn(Future.value());

    expect(signOutUseCase.call, returnsNormally);
  });
}
