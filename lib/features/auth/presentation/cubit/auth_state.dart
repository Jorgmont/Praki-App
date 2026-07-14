import 'package:flutter/foundation.dart';

@immutable
abstract class AuthState {
  const AuthState();
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthAuthenticated extends AuthState {
  final String email;
  const AuthAuthenticated(this.email);
}

class AuthError extends AuthState {
  final String message;
  const AuthError(this.message);
}
