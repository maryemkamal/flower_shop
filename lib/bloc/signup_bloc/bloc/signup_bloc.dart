import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';


part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  SignupBloc() : super(SignupState.initial()) {
    on<SignupEmailChanged>((event, emit) {
      emit(state.copyWith(email: event.email));
    });

    on<SignupPasswordChanged>((event, emit) {
      emit(state.copyWith(password: event.password));
    });

    on<SignupConfirmPasswordChanged>((event, emit) {
      emit(state.copyWith(confirmPassword: event.confirmPassword));
    });

    on<SignupSubmitted>((event, emit) async {
      emit(state.copyWith(isLoading: true, errorMessage: null, isSuccess: false));

      if (state.password != state.confirmPassword) {
        emit(state.copyWith(
          isLoading: false,
          errorMessage: "Passwords do not match",
        ));
        return;
      }

      try {
        await _firebaseAuth.createUserWithEmailAndPassword(
          email: state.email,
          password: state.password,
        );
        emit(state.copyWith(isLoading: false, isSuccess: true));
      } on FirebaseAuthException catch (e) {
        emit(state.copyWith(isLoading: false, errorMessage: e.message));
      } catch (_) {
        emit(state.copyWith(isLoading: false, errorMessage: "Signup failed"));
      }
    });

    on<SignUpWithGooglePressed>((event, emit) async {
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
  }
}
