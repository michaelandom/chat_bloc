part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class SignOutEvent extends AuthEvent {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class SignedInEvent extends AuthEvent {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class ResetPasswordEvent extends AuthEvent {
  final email;

  ResetPasswordEvent({this.email});

  @override
  // TODO: implement props
  List<Object> get props => [email];
}

abstract class SignInEvent extends AuthEvent {
  const SignInEvent();
}

class GoogleSignInEvent extends SignInEvent {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class EmailAndPasswordSignInEvent extends SignInEvent {
  final email;
  final password;

  EmailAndPasswordSignInEvent({this.email, this.password});

  @override
  // TODO: implement props
  List<Object> get props => [email, password];
}

abstract class SignUpEvent extends AuthEvent {
  const SignUpEvent();
}

class EmailAndPasswordSignUpEvent extends SignUpEvent {
  final email;
  final password;
  final username;
  EmailAndPasswordSignUpEvent({this.email, this.password, this.username});
  @override
  // TODO: implement props
  List<Object> get props => [email, password, username];
}
