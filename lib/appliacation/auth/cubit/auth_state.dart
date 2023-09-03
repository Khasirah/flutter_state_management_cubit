part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthError extends AuthState {
  final LoginErrorResponse errorMessage;
  AuthError(this.errorMessage);
}

final class AuthLoginSuccess extends AuthState {
  final LoginResponse dataLogin;
  AuthLoginSuccess(this.dataLogin);
}
