import 'package:firebase_core/firebase_core.dart';
import 'package:flower_shop/splash_screen.dart';
import 'package:flower_shop/theme/app_themes.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flower_Shop',
      theme: AppTheme.lightTheme,

      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
