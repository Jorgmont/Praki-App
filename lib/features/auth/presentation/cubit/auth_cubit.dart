import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthInitial());

  Future<void> login(String email, String password) async {
    emit(const AuthLoading());

    // Simulate network delay for a smooth premium UX loading effect
    await Future.delayed(const Duration(milliseconds: 1500));

    // Basic credential validation
    if (email.trim() == 'admin@example.com' && password == 'password123') {
      emit(AuthAuthenticated(email.trim()));
    } else {
      emit(const AuthError('Correo electrónico o contraseña incorrectos.'));
    }
  }

  void logout() {
    emit(const AuthInitial());
  }
}
