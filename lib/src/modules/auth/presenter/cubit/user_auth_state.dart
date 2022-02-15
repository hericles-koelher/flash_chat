part of 'user_auth_cubit.dart';

@immutable
abstract class UserAuthState {}

class UserAuthLoading extends UserAuthState {}

class UserUnauthenticated extends UserAuthState {}

class UserUnauthenticatedError extends UserUnauthenticated {
  final InvalidCredentialException exception;

  UserUnauthenticatedError(this.exception);
}

class UserAuthenticated extends UserAuthState {
  final String userUID;

  UserAuthenticated(this.userUID);
}
