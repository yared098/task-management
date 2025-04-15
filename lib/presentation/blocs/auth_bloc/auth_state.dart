abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthAuthenticated extends AuthState {
  final String username;
  final String role;

  AuthAuthenticated({required this.username, required this.role});
}

class AuthUnauthenticated extends AuthState {}
