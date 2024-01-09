// ignore_for_file: avoid_print

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthLoginRequested>(_onAuthLoginRequested);
    on<AuthLogoutRequested>(_onAuthLogoutRequested);
  }

  // now these 2 is observed by BlocObserver
  // @override
  // void onChange(Change<AuthState> change) {
  //   super.onChange(change);
  //   print('AuthBloc - Change - $change');
  // }

  // @override
  // void onError(Object error, StackTrace stackTrace) {
  //   super.onError(error, stackTrace);
  // }

  @override
  void onTransition(Transition<AuthEvent, AuthState> transition) {
    super.onTransition(transition);
    print("Auth Bloc - Transition - $transition");
  }

  void _onAuthLoginRequested(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(AuthLoading());
      final email = event.email;
      final password = event.password;

      bool isEmailValid =
          RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
              .hasMatch(email);

      if (!isEmailValid) {
        emit(AuthFailure("Email must be valid"));
        return;
      }

      if (password.length < 6) {
        emit(AuthFailure('Password cannot be less than 6 characters'));
        return;
      }

      await Future.delayed(const Duration(seconds: 1), () {
        return emit(
          AuthSuccess(uid: "$email-$password"),
        );
      });
    } catch (e) {
      emit(AuthFailure(
        e.toString(),
      ));
    }
  }

  void _onAuthLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await Future.delayed(const Duration(seconds: 1), () {
        return emit(
          AuthInitial(),
        );
      });
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}
