part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthLoading extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthLoadingEmail extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthSignedIn extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthResetPassword extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthSignedOut extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthError extends AuthState {
  @override
  List<Object> get props => [];
}
