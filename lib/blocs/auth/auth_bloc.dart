import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';
import 'package:assessment_app/repositories/auth_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc(this.authRepository) : super(AuthInitial()) {
    on<LoginEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        if (event.password.length < 4 || event.password.isEmpty) {
          throw ('Password too short');
        }else{
          await authRepository.signIn(event.email, event.password);
          emit(AuthSuccess());
        }

      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });

    on<SignUpEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        if (event.password.length < 4) {
          throw ('Password too short');
        } else {
          await authRepository.signUp(
              event.email, event.password); // Implement this in your repository
          emit(AuthSuccess());
        }
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });
  }
}
