import 'package:bloc/bloc.dart';
import 'package:flash_chat/src/modules/auth/domain/get_signed_in_user_use_case.dart';
import 'package:flash_chat/src/modules/auth/domain/sign_in_use_case.dart';
import 'package:flash_chat/src/modules/auth/domain/sign_out_use_case.dart';
import 'package:flash_chat/src/modules/auth/domain/sign_up_use_case.dart';
import 'package:flash_chat/src/modules/auth/domain/user_credential.dart';
import 'package:flash_chat/src/modules/core/domain/flash_chat_exception.dart';
import 'package:meta/meta.dart';

part 'user_auth_state.dart';

class UserAuthCubit extends Cubit<UserAuthState> {
  final ISignUpUseCase _emailSignUpUseCase;
  final ISignInUseCase _emailSignInUseCase;
  final ISignOutUseCase _signOutUseCase;

  UserAuthCubit({
    required IGetSignedInUserUseCase getSignedInUserUseCase,
    required ISignUpUseCase emailSignUpUseCase,
    required ISignInUseCase emailSignInUseCase,
    required ISignOutUseCase signOutUseCase,
  })  : _emailSignUpUseCase = emailSignUpUseCase,
        _emailSignInUseCase = emailSignInUseCase,
        _signOutUseCase = signOutUseCase,
        super(
          getSignedInUserUseCase() != null
              ? UserAuthenticated(getSignedInUserUseCase()!)
              : UserUnauthenticated(),
        );

  Future<void> signUpWitEmail(String email, String password) async {
    if (state is UserUnauthenticated) {
      emit(UserAuthLoading());

      try {
        var userUID = await _emailSignUpUseCase(
          EmailCredential(email: email, password: password),
        );

        emit(UserAuthenticated(userUID));
      } on InvalidCredentialException catch (e) {
        emit(UserUnauthenticatedError(e));
      }
    }
  }

  Future<void> signInWitEmail(String email, String password) async {
    if (state is UserUnauthenticated) {
      emit(UserAuthLoading());

      try {
        var userUID = await _emailSignInUseCase(
          EmailCredential(email: email, password: password),
        );

        emit(UserAuthenticated(userUID));
      } on InvalidCredentialException catch (e) {
        emit(UserUnauthenticatedError(e));
      }
    }
  }

  Future<void> signOut() async {
    if (state is UserAuthenticated) {
      emit(UserAuthLoading());
      await _signOutUseCase();
      emit(UserUnauthenticated());
    }
  }
}
