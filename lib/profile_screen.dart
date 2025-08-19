import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flower_shop/bloc/login_bloc/login_bloc.dart';
import 'package:flower_shop/bloc/login_bloc/login_event.dart';
import 'package:flower_shop/bloc/login_bloc/login_state.dart';
import 'login_screen.dart';
import 'main.dart';

class ProfileScreen extends StatelessWidget {
  final int cartCount;
  final int favoritesCount;
  final String selectedLanguage;
  final Function(String) onLanguageChanged;

  const ProfileScreen({
    super.key,
    required this.cartCount,
    required this.favoritesCount,
    required this.selectedLanguage,
    required this.onLanguageChanged,
  });

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return BlocProvider(
      create: (_) => LoginBloc(),
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.isLoggedOut) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const LoginScreen()),
                  (route) => false,
            );
          }
        },
        child: Scaffold(
          backgroundColor: theme.scaffoldBackgroundColor,
          appBar: AppBar(
            backgroundColor: theme.appBarTheme.backgroundColor,
            title: Text(
              selectedLanguage == 'English' ? 'Profile' : 'الملف الشخصي',
              style: theme.appBarTheme.titleTextStyle ??
                  const TextStyle(color: Colors.white),
            ),
            centerTitle: true,
          ),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: theme.colorScheme.primary,
                child: const Icon(Iconsax.user, size: 40, color: Colors.white),
              ),
              const SizedBox(height: 10),
              Center(
                child: Text(
                  selectedLanguage == 'English'
                      ? 'Flower Lover'
                      : 'عاشق الزهور',
                  style: theme.textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Center(
                child: Text(
                  user?.email ?? 'No email',
                  style: theme.textTheme.bodyMedium
                      ?.copyWith(color: theme.hintColor),
                ),
              ),
              const Divider(height: 30),
              ListTile(
                leading: const Icon(Iconsax.shopping_bag),
                title: Text(
                  selectedLanguage == 'English' ? 'Cart Items' : 'عناصر السلة',
                  style: theme.textTheme.bodyLarge,
                ),
                trailing: Text(
                  '$cartCount',
                  style: theme.textTheme.bodyLarge,
                ),
              ),
              ListTile(
                leading: const Icon(Iconsax.heart),
                title: Text(
                  selectedLanguage == 'English' ? 'Favorites' : 'المفضلة',
                  style: theme.textTheme.bodyLarge,
                ),
                trailing: Text(
                  '$favoritesCount',
                  style: theme.textTheme.bodyLarge,
                ),
              ),
              const Divider(height: 30),
              SwitchListTile(
                title: Text(
                  selectedLanguage == 'English' ? 'Dark Mode' : 'الوضع الليلي',
                  style: theme.textTheme.bodyLarge,
                ),
                value: themeNotifier.value == ThemeMode.dark,
                onChanged: (value) {
                  themeNotifier.value =
                  value ? ThemeMode.dark : ThemeMode.light;
                },
                secondary: const Icon(Icons.nightlight_round),
              ),
              ListTile(
                leading: const Icon(Iconsax.global),
                title: Text(
                  selectedLanguage == 'English' ? 'Language' : 'اللغة',
                  style: theme.textTheme.bodyLarge,
                ),
                trailing: DropdownButton<String>(
                  dropdownColor: theme.cardColor,
                  value: selectedLanguage,
                  onChanged: (String? newLang) {
                    if (newLang != null) {
                      onLanguageChanged(newLang);
                    }
                  },
                  items: ['English', 'Arabic'].map((lang) {
                    return DropdownMenuItem(
                      value: lang,
                      child: Text(
                        lang,
                        style: theme.textTheme.bodyLarge,
                      ),
                    );
                  }).toList(),
                ),
              ),
              const Divider(height: 30),
              ListTile(
                leading: const Icon(Iconsax.logout),
                title: Text(
                  selectedLanguage == 'English'
                      ? 'Logout'
                      : 'تسجيل الخروج',
                  style: theme.textTheme.bodyLarge,
                ),
                onTap: () {
                  context.read<LoginBloc>().add(LogoutRequested());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
