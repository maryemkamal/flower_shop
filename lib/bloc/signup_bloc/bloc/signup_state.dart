part of 'signup_bloc.dart';

class SignupState extends Equatable {
  final String email;
  final String password;
  final String confirmPassword;
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;

  const SignupState({
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.isLoading,
    required this.isSuccess,
    this.errorMessage,
  });

  factory SignupState.initial() {
    return const SignupState(
      email: '',
      password: '',
      confirmPassword: '',
      isLoading: false,
      isSuccess: false,
      errorMessage: null,
    );
  }

  SignupState copyWith({
    String? email,
    String? password,
    String? confirmPassword,
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
  }) {
    return SignupState(
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        email,
        password,
        confirmPassword,
        isLoading,
        isSuccess,
        errorMessage,
      ];
}
