import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flower_shop/bloc/login_bloc/login_state.dart';
import 'package:flower_shop/bloc/login_bloc/login_event.dart';
import 'package:flower_shop/bloc/login_bloc/login_bloc.dart';
import 'package:flower_shop/theme/app_string.dart';
import 'package:flower_shop/row_of_text.dart';
import 'home.dart';
import 'media_row.dart';
import 'package:flower_shop/validators/form_valide.dart';
class LoginContent extends StatelessWidget {
  const LoginContent({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.isSuccess) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Text(
                        AppString.loginScreen,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: AppString.loginScreenEmailTextFiled,
                          prefixIcon: const Icon(Icons.email_outlined),
                        ),
                        validator: validationEmailMethod(context: context),
                        onChanged: (value) {
                          context
                              .read<LoginBloc>()
                              .add(LoginEmailChanged(value));
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: AppString.loginScreenPasswordTextFiled,
                          prefixIcon: const Icon(Icons.lock_outline),
                        ),
                        validator: validationPasswordMethod(context: context),
                        onChanged: (value) {
                          context
                              .read<LoginBloc>()
                              .add(LoginPasswordChanged(value));
                        },
                      ),
                      const SizedBox(height: 20),
                      if (state.errorMessage != null) ...[
                        Text(
                          state.errorMessage!,
                          style: const TextStyle(color: Colors.red),
                        ),
                        const SizedBox(height: 8),
                      ],
                      state.isLoading
                          ? const CircularProgressIndicator()
                          : ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context
                                .read<LoginBloc>()
                                .add(LoginSubmitted());
                          }
                        },
                        child: const Text('Login'),
                      ),
                      const SizedBox(height: 10),
                      Text('or',
                          style: Theme.of(context).textTheme.bodyMedium),
                      const SizedBox(height: 10),
                      SocialLoginRow(
                        onGoogleTap: () {
                          print('Google Login');
                        },
                        onFacebookTap: () {
                          print('Facebook Login');
                        },
                      ),
                      const SizedBox(height: 10),
                      ForgetPasswordRow(
                        firstWhiteText: "Don't have account ?",
                        secoednBlcakText: 'Sign up!',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
