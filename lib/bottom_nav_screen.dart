import 'package:flutter/material.dart';
import 'package:flowerly_app/screens/cart_screen.dart';
import 'package:flowerly_app/screens/favorites_screen.dart';
import 'package:flowerly_app/screens/home_screen.dart';
import 'package:flowerly_app/screens/profile_screen.dart';
import 'package:iconsax/iconsax.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int _selectedIndex = 0;

  final List<Map<String, String>> _allProducts = [
    {'image': 'assets/images/pink.jpg', 'name': 'Pink Rose', 'price': '\$12'},
    {'image': 'assets/images/red.jpg', 'name': 'Red Tulip', 'price': '\$15'},
    {'image': 'assets/images/1.jpg', 'name': 'White Lily', 'price': '\$10'},
    {'image': 'assets/images/2.jpg', 'name': 'Blue Orchid', 'price': '\$18'},
    {'image': 'assets/images/3.jpg', 'name': 'Pink Tulip', 'price': '\$14'},
    {'image': 'assets/images/4.jpg', 'name': 'Violet Rose', 'price': '\$16'},
    {'image': 'assets/images/5.jpg', 'name': 'Yellow Sunflower', 'price': '\$9'},
    {'image': 'assets/images/6.jpg', 'name': 'Mix Bouquet', 'price': '\$20'},
  ];

  final List<Map<String, String>> _cart = [];
  Set<int> _favoriteIndices = {};
  bool _isDarkMode = false;
  String _selectedLanguage = 'English';

  void _toggleFavorite(int index) {
    setState(() {
      if (_favoriteIndices.contains(index)) {
        _favoriteIndices.remove(index);
      } else {
        _favoriteIndices.add(index);
      }
    });
  }

  void _removeFromFavorites(int index) {
    setState(() {
      _favoriteIndices.remove(index);
    });
  }

  void _addToCart(Map<String, String> product) {
    setState(() {
      _cart.add(product);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("${product['name']} added to cart!")),
    );
  }

  void _onDarkModeChanged(bool value) {
    setState(() {
      _isDarkMode = value;
    });
  }

  void _onLanguageChanged(String value) {
    setState(() {
      _selectedLanguage = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _screens = [
      HomeScreen(
        allProducts: _allProducts,
        onAddToCart: _addToCart,
        favoriteIndices: _favoriteIndices,
        onFavoriteToggle: _toggleFavorite,
      ),
      FavoritesScreen(
        allProducts: _allProducts,
        favoriteIndices: _favoriteIndices,
        onFavoriteToggle: _toggleFavorite,
        onRemoveFavorite: _removeFromFavorites,
        onAddToCart: _addToCart,
      ),
      CartScreen(cart: _cart),
      ProfileScreen(
        cartCount: _cart.length,
        favoritesCount: _favoriteIndices.length,
        isDarkMode: _isDarkMode,
        selectedLanguage: _selectedLanguage,
        onDarkModeChanged: _onDarkModeChanged,
        onLanguageChanged: _onLanguageChanged,
      ),
    ];

    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        selectedItemColor: const Color(0xFF23C16B),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Iconsax.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Iconsax.heart), label: 'Favorites'),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(icon: Icon(Iconsax.user), label: 'Profile'),
        ],
      ),
    );
  }
}