import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms_admin_instructor/features/auth/domain/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<LoginEvent>(_onLogin);
    on<RegisterEvent>(_onRegister);
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final result = await authRepository.login(event.email, event.password);
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> _onRegister(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final result = await authRepository.register(
        event.name,
        event.email,
        event.password,
      );
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }
}
