import 'package:flutter/material.dart';
import 'package:flower_shop/cart_screen.dart';
import 'package:flower_shop/favorites_screen.dart';
import 'package:flower_shop/home.dart';
import 'package:flower_shop/profile_screen.dart';
import 'package:iconsax/iconsax.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int _selectedIndex = 0;

  List<Map<String, dynamic>> _allProducts = [];
  final List<Map<String, dynamic>> _cart = [];
  Set<int> _favoriteIndices = {};
  String _selectedLanguage = 'English';

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    final snapshot = await FirebaseFirestore.instance.collection('products').get();
    setState(() {
      _allProducts = snapshot.docs.map((doc) => doc.data()).toList();
    });
  }

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

  void _addToCart(Map<String, dynamic> product) {
    setState(() {
      _cart.add(product);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("${product['name']} added to cart!")),
    );
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
        onFavoriteToggle: _toggleFavorite,
        favoriteIndices: _favoriteIndices,
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
        selectedLanguage: _selectedLanguage,
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
          BottomNavigationBarItem(icon: Icon(Iconsax.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Iconsax.user), label: 'Profile'),
        ],
      ),
    );
  }
}
