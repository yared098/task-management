abstract class AuthEvent {}

class AuthLoggedIn extends AuthEvent {
  final String username;
  final String role;

  AuthLoggedIn(this.username, this.role);
}

class AuthLoggedOut extends AuthEvent {}
