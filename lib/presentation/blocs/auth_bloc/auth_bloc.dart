import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management/config/hive_config.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthLoggedIn>((event, emit) async {
      await HiveConfig.saveUserSession(event.username, event.role);
      emit(AuthAuthenticated(username: event.username, role: event.role));
    });

    on<AuthLoggedOut>((event, emit) async {
      await HiveConfig.clearUserSession();
      emit(AuthUnauthenticated());
    });
  }
}
