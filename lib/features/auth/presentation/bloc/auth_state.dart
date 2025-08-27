import 'package:tisser_app/features/auth/domain/entities/user.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final UserEntity user;

  AuthAuthenticated(this.user);
}

class AuthUnAuthenticated extends AuthState {}

class ResetEmailSend extends AuthState {}

class AuthError extends AuthState {
  final String message;

  AuthError(this.message);
}
