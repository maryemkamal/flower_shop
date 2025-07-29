import 'package:flower_shop/signUp_content.dart';
import 'package:flutter/material.dart';
import 'package:flower_shop/theme/app_colors.dart';
import 'package:flower_shop/login_content.dart';

class SingupScreen extends StatelessWidget {
  const SingupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Stack(
          children: [
            // Background image
            Positioned.fill(
              child: Image.asset(
                'assets/flowerbackdrop.png',
                fit: BoxFit.cover,
              ),
            ),

            // Login container at bottom
            Align(
              alignment: Alignment.bottomCenter,
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
                child: const SignUpConente(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
