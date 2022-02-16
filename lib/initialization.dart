import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flash_chat/src/modules/auth/auth.dart';
import 'package:get_it/get_it.dart';

import 'firebase_options.dart';

Future<void> initializeApp() async {
  var getIt = GetIt.I;

  var firebaseApp = await Firebase.initializeApp(
    name: "Flash Chat",
    options: DefaultFirebaseOptions.android,
  );

  getIt.registerSingleton(firebaseApp);

  getIt.registerSingleton<IAuthService>(
    FirebaseAuthService(
      FirebaseAuth.instanceFor(app: getIt()),
    ),
  );

  getIt.registerSingleton<IGetCurrentUserUseCase>(
    GetCurrentUserUseCase(getIt()),
  );

  getIt.registerSingleton<ISignUpUseCase>(
    SignUpWithEmailUseCase(getIt()),
  );

  getIt.registerSingleton<ISignInUseCase>(
    SignInWithEmailUseCase(getIt()),
  );

  getIt.registerSingleton<ISignOutUseCase>(
    SignOutUseCase(getIt()),
  );

  getIt.registerSingleton(
    UserAuthCubit(
      emailSignInUseCase: getIt(),
      emailSignUpUseCase: getIt(),
      getCurrentUserUseCase: getIt(),
      signOutUseCase: getIt(),
    ),
  );
}
