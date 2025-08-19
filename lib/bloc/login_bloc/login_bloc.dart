import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
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

    on<LoginWithGooglePressed>((event, emit) async {
      emit(state.copyWith(isLoading: true, isSuccess: false, errorMessage: null));

      try {
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

        if (googleUser == null) {
          emit(state.copyWith(isLoading: false));
          return;
        }

        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        await FirebaseAuth.instance.signInWithCredential(credential);

        emit(state.copyWith(isLoading: false, isSuccess: true));
      } catch (e) {
        emit(state.copyWith(
          isLoading: false,
          isSuccess: false,
          errorMessage: 'Google login failed. Try again.',
        ));
      }
    });
    on<LogoutRequested>((event, emit) async {
      await FirebaseAuth.instance.signOut();
      emit(state.copyWith(isLoggedOut: true));
    });


  }
}
