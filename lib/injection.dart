import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flash_chat/src/modules/auth/auth.dart';
import 'package:get_it/get_it.dart';

import 'firebase_options.dart';

void inject() {
  var getIt = GetIt.I;

  getIt.registerSingletonAsync<FirebaseApp>(
    () => Firebase.initializeApp(
      name: "Flash Chat",
      options: DefaultFirebaseOptions.android,
    ),
  );

  getIt.registerSingletonWithDependencies<IAuthService>(
    () => FirebaseAuthService(
      FirebaseAuth.instanceFor(app: getIt()),
    ),
    dependsOn: [FirebaseApp],
  );

  getIt.registerSingletonWithDependencies<IGetSignedInUserUseCase>(
    () => GetSignedInUserUseCase(getIt()),
    dependsOn: [IAuthService],
  );

  getIt.registerSingletonWithDependencies<ISignUpUseCase>(
    () => SignUpWithEmailUseCase(getIt()),
    dependsOn: [IAuthService],
  );

  getIt.registerSingletonWithDependencies<ISignInUseCase>(
    () => SignInWithEmailUseCase(getIt()),
    dependsOn: [IAuthService],
  );

  getIt.registerSingletonWithDependencies<ISignOutUseCase>(
    () => SignOutUseCase(getIt()),
    dependsOn: [IAuthService],
  );

  getIt.registerSingletonWithDependencies<UserAuthCubit>(
    () => UserAuthCubit(
      emailSignInUseCase: getIt(),
      emailSignUpUseCase: getIt(),
      getSignedInUserUseCase: getIt(),
      signOutUseCase: getIt(),
    ),
    dependsOn: [
      ISignUpUseCase,
      ISignInUseCase,
      ISignOutUseCase,
      IGetSignedInUserUseCase,
    ],
  );
}
