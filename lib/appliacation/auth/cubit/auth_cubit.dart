import 'package:bloc/bloc.dart';
import 'package:cubit/domain/auth/model/login_error_response.dart';
import 'package:cubit/domain/auth/model/login_request.dart';
import 'package:cubit/domain/auth/model/login_response.dart';
import 'package:cubit/infrastructure/auth/auth_repository.dart';
import 'package:flutter/material.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final AuthRepository _authRepository = AuthRepository();

  void signInUser(LoginRequest loginRequest) async {
    emit(AuthLoading());

    try {
      final data = await _authRepository.signInUserWithEmailandPassword(
          loginRequest: loginRequest);

      data.fold(
        (l) => emit(AuthError(l)),
        (r) => emit(AuthLoginSuccess(r)),
      );
    } catch (e) {
      emit(AuthError(LoginErrorResponse.fromJson({"error": e.toString()})));
    }
  }
}
