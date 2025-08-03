import 'package:flutter/material.dart';
import 'package:flower_shop/theme/app_colors.dart';
import 'package:flower_shop/login_content.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flower_shop/bloc/login_bloc/login_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/flowerbackdrop.png',
                fit: BoxFit.cover,
              ),
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: BlocProvider(
                create: (_) => LoginBloc(),
                child: Container(
                  height: 400,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, -4),
                      ),
                    ],
                  ),
                  child: const LoginContent(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
