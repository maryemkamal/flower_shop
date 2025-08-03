import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flowerly_app/resources/app_colors.dart';

class ProfileScreen extends StatefulWidget {
  final int cartCount;
  final int favoritesCount;
  final bool isDarkMode;
  final String selectedLanguage;
  final Function(bool) onDarkModeChanged;
  final Function(String) onLanguageChanged;

  const ProfileScreen({
    super.key,
    required this.cartCount,
    required this.favoritesCount,
    required this.isDarkMode,
    required this.selectedLanguage,
    required this.onDarkModeChanged,
    required this.onLanguageChanged,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final isDarkMode = widget.isDarkMode;
    final selectedLanguage = widget.selectedLanguage;

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : AppColors.bgLightGreen,
      appBar: AppBar(
        backgroundColor: isDarkMode ? Colors.grey[900] : AppColors.primaryGreen,
        title: Text(
          selectedLanguage == 'English' ? 'Profile' : 'الملف الشخصي',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const CircleAvatar(
            radius: 40,
            backgroundColor: AppColors.primaryGreen,
            child: Icon(Iconsax.user, size: 40, color: Colors.white),
          ),
          const SizedBox(height: 10),
          Center(
            child: Text(
              selectedLanguage == 'English' ? 'Flower Lover' : 'عاشق الزهور',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
          ),
          Center(
            child: Text(
              'user@example.com',
              style: TextStyle(
                color: isDarkMode ? Colors.grey[400] : Colors.black54,
              ),
            ),
          ),
          const Divider(height: 30),
          ListTile(
            leading: const Icon(Iconsax.shopping_bag),
            title: Text(
              selectedLanguage == 'English' ? 'Cart Items' : 'عناصر السلة',
              style: TextStyle(
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            trailing: Text(
              '${widget.cartCount}',
              style: TextStyle(
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Iconsax.heart),
            title: Text(
              selectedLanguage == 'English' ? 'Favorites' : 'المفضلة',
              style: TextStyle(
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            trailing: Text(
              '${widget.favoritesCount}',
              style: TextStyle(
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
          ),
          const Divider(height: 30),
          SwitchListTile(
            title: Text(
              selectedLanguage == 'English' ? 'Dark Mode' : 'الوضع الليلي',
              style: TextStyle(
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            value: isDarkMode,
            onChanged: widget.onDarkModeChanged,
            secondary: const Icon(Iconsax.moon),
          ),
          ListTile(
            leading: const Icon(Iconsax.global),
            title: Text(
              selectedLanguage == 'English' ? 'Language' : 'اللغة',
              style: TextStyle(
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            trailing: DropdownButton<String>(
              value: selectedLanguage,
              onChanged: (String? newLang) {
                if (newLang != null) {
                  widget.onLanguageChanged(newLang);
                }
              },
              items: ['English', 'Arabic'].map((lang) {
                return DropdownMenuItem(
                  value: lang,
                  child: Text(
                    lang,
                    style: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const Divider(height: 30),
          ListTile(
            leading: const Icon(Iconsax.logout),
            title: Text(
              selectedLanguage == 'English' ? 'Logout' : 'تسجيل الخروج',
              style: TextStyle(
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            onTap: () {
              // TODO: Implement logout
              // FirebaseAuth.instance.signOut();
              // Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
    );
  }
}//the end