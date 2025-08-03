import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flower_shop/theme/app_string.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/flowerbackdrop.png',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Text(
              AppString.nameOf_shop,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ),
        ],
      ),
      nextScreen: const LoginScreen(),
      splashTransition: SplashTransition.fadeTransition,
      backgroundColor: Colors.white,
      duration: 2500,
    );
  }
}
