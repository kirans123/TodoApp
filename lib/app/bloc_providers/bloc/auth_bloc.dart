import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login_and_registration/data/init/init_service.dart';
import 'package:login_and_registration/data/models/user_model.dart';
import 'package:login_and_registration/data/repo/auth_repo.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc(this.authRepository) : super(AuthInitial()) {
    on<RegisterUserEvent>(_registerUser);
    on<LoginUserEvent>(_loginUser);
  }

  _registerUser(RegisterUserEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await authRepository.registerUser(
        event.email,
        event.password,
        event.userName,
        event.mobile,
      );

      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  _loginUser(LoginUserEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      UserCredential userCredential =
          await authRepository.loginUser(event.email, event.password);
      authService.setUser(LoggedInUser(
        token: userCredential.user!.uid,
        email: event.email,
        name: userCredential.user!.displayName ?? '',
      ));
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}
