import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flower_shop/theme/app_string.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/flowerbackdrop.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Text(
            AppString.nameOf_shop,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
      ),
      nextScreen: const LoginScreen(),
      splashTransition: SplashTransition.fadeTransition,
      backgroundColor: Colors.white,
      duration: 2500,
    );
  }
}
