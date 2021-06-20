import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat_bloc/db/k_shared_preference.dart';
import 'package:chat_bloc/services/firebase.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  HSharedPreference localPreference = GetHSPInstance.hSharedPreference;
  AuthService authService = AuthService();
  AuthBloc() : super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is GoogleSignInEvent) {
      yield AuthLoading();
      final result = await authService.signInWithGoogle();
      if (result) {
        yield AuthSignedIn();
        localPreference.set(HSharedPreference.USER_STATES, result);
      } else {
        yield AuthError();
      }
    }
    if (event is SignOutEvent) {
      yield AuthLoading();
      final result = await authService.signOut();
      if (result) {
        yield AuthSignedOut();
        localPreference.set(HSharedPreference.USER_STATES, false);
        localPreference.set(HSharedPreference.USER_NAME, "");
      } else {
        yield AuthError();
      }
    }
    if (event is SignedInEvent) {
      yield AuthSignedIn();
    }
    if (event is EmailAndPasswordSignUpEvent) {
      yield AuthLoadingEmail();
      final result = await authService.signUpWithEmailAndPassword(
          event.username, event.email, event.password);
      if (result) {
        yield AuthSignedIn();
        localPreference.set(HSharedPreference.USER_STATES, result);
      } else {
        yield AuthError();
      }
    }
    if (event is EmailAndPasswordSignInEvent) {
      yield AuthLoadingEmail();
      final result = await authService.signInWithEmailAndPassword(
          event.email, event.password);
      if (result) {
        yield AuthSignedIn();
        localPreference.set(HSharedPreference.USER_STATES, result);
      } else {
        yield AuthError();
      }
    }
    if (event is ResetPasswordEvent) {
      yield AuthLoadingEmail();
      final result = await authService.resetPassword(event.email) ?? false;
      if (result) {
        yield AuthResetPassword();
      } else {
        yield AuthError();
      }
    }
  }
}
