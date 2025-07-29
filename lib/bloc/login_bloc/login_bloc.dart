import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    on<LoginEmailChanged>((event, emit) {
      emit(state.copyWith(email: event.email));
    });

    on<LoginPasswordChanged>((event, emit) {
      emit(state.copyWith(password: event.password));
    });

   on<LoginSubmitted>((event, emit) async {
  emit(state.copyWith(isLoading: true, isSuccess: false, errorMessage: null));

  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: state.email.trim(),
      password: state.password.trim(),
    );

    emit(state.copyWith(isLoading: false, isSuccess: true));
  } on FirebaseAuthException catch (e) {
    emit(state.copyWith(
      isLoading: false,
      isSuccess: false,
      errorMessage: e.message ?? 'Login failed. Please try again.',
    ));
  }
});

    
  }
}
