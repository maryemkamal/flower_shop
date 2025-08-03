import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flower_shop/bloc/signup_bloc/bloc/signup_bloc.dart';
import 'package:flower_shop/home.dart';
import 'package:flower_shop/theme/app_string.dart';
import 'package:flower_shop/validators/form_valide.dart';
import 'media_row.dart';
import 'row_of_text.dart';

class SignUpConente extends StatefulWidget {
  const SignUpConente({super.key});

  @override
  State<SignUpConente> createState() => _SignUpConenteState();
}

class _SignUpConenteState extends State<SignUpConente> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupBloc, SignupState>(
      listener: (context, state) {
        if (state.isSuccess) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        } else if (state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage!)),
          );
        }
      },
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppString.signUpScreen,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: AppString.loginScreenEmailTextFiled,
                  prefixIcon: const Icon(Icons.email_outlined),
                ),
                validator: validationEmailMethod(context: context),
                onChanged: (value) {
                  context.read<SignupBloc>().add(SignupEmailChanged(value));
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: AppString.loginScreenPasswordTextFiled,
                  prefixIcon: const Icon(Icons.lock_outline),
                ),
                validator: validationPasswordMethod(context: context),
                onChanged: (value) {
                  context.read<SignupBloc>().add(SignupPasswordChanged(value));
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: AppString.confirmPasswordTextFiled,
                  prefixIcon: const Icon(Icons.lock_outline),
                ),
                validator: confirmPasswordValidator(
                  context: context,
                  passwordController: _passwordController,
                ),
                onChanged: (value) {
                  context.read<SignupBloc>().add(SignupConfirmPasswordChanged(value));
                },
              ),
              const SizedBox(height: 20),
              BlocBuilder<SignupBloc, SignupState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return const CircularProgressIndicator();
                  }
                  return ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<SignupBloc>().add(SignupSubmitted());
                      }
                    },
                    child: const Text('Sign Up'),
                  );
                },
              ),
              const SizedBox(height: 20),
              Text(
                'or',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 10),
              SocialLoginRow(
                onGoogleTap: () {
                  context.read<SignupBloc>().add(SignUpWithGooglePressed());
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}
