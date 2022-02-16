import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/painting.dart';
import 'package:meta/meta.dart';

import '../../../core/core.dart';
import '../../auth.dart';

part 'user_auth_state.dart';

class UserAuthCubit extends Cubit<UserAuthState> {
  final ISignUpUseCase _emailSignUpUseCase;
  final ISignInUseCase _emailSignInUseCase;
  final ISignOutUseCase _signOutUseCase;
  final IDeleteAccountUseCase _deleteAccountUseCase;
  late final StreamSubscription _userUIDSubscription;

  UserAuthCubit({
    required IGetCurrentUserUseCase getCurrentUserUseCase,
    required ISignUpUseCase emailSignUpUseCase,
    required ISignInUseCase emailSignInUseCase,
    required ISignOutUseCase signOutUseCase,
    required IDeleteAccountUseCase deleteAccountUseCase,
  })  : _emailSignUpUseCase = emailSignUpUseCase,
        _emailSignInUseCase = emailSignInUseCase,
        _signOutUseCase = signOutUseCase,
        _deleteAccountUseCase = deleteAccountUseCase,
        super(
          getCurrentUserUseCase() != null
              ? UserAuthenticated(getCurrentUserUseCase()!)
              : UserUnauthenticated(),
        ) {
    _userUIDSubscription = getCurrentUserUseCase.stream().listen(
      (String? userUID) {
        if (userUID != null) {
          emit(UserAuthenticated(userUID));
        } else {
          emit(UserUnauthenticated());
        }
      },
    );
  }

  Future<void> signUpWitEmail(String email, String password) async {
    if (state is UserUnauthenticated) {
      emit(UserAuthLoading());

      try {
        await _emailSignUpUseCase(
          EmailCredential(email: email, password: password),
        );
      } on InvalidCredentialException catch (e) {
        emit(UserUnauthenticatedError(e));
      }
    }
  }

  Future<void> signInWitEmail(String email, String password) async {
    if (state is UserUnauthenticated) {
      emit(UserAuthLoading());

      try {
        await _emailSignInUseCase(
          EmailCredential(email: email, password: password),
        );
      } on InvalidCredentialException catch (e) {
        emit(UserUnauthenticatedError(e));
      }
    }
  }

  Future<void> signOut() async {
    if (state is UserAuthenticated) {
      emit(UserAuthLoading());

      await _signOutUseCase();
    }
  }

  Future<void> deleteAccount({
    required FutureOr<void> Function(String) onError,
  }) async {
    try {
      if (state is UserAuthenticated) {
        await _deleteAccountUseCase();
      }
    } on DeleteAccountException catch (e) {
      await onError(e.message);
    }
  }

  @override
  Future<void> close() {
    _userUIDSubscription.cancel();

    return super.close();
  }
}
