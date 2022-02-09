import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flash_chat/firebase_options.dart';
import 'package:flash_chat/src/modules/auth/domain/auth_service_interface.dart';
import 'package:flash_chat/src/modules/auth/domain/get_signed_in_user_use_case.dart';
import 'package:flash_chat/src/modules/auth/domain/sign_in_use_case.dart';
import 'package:flash_chat/src/modules/auth/domain/sign_out_use_case.dart';
import 'package:flash_chat/src/modules/auth/domain/sign_up_use_case.dart';
import 'package:flash_chat/src/modules/auth/external/firebase_auth_service.dart';
import 'package:flash_chat/src/modules/auth/presenter/bloc/cubit/user_auth_cubit.dart';
import 'package:flash_chat/src/modules/auth/presenter/pages/user_creation_page.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await inject();

  runApp(const FlashChat());
}

Future<void> inject() async {
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

class FlashChat extends StatelessWidget {
  const FlashChat({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: UserCreationPage(),
    );
  }
}
