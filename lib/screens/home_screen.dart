import 'package:flutter/material.dart';
import 'package:flowerly_app/resources/app_colors.dart' as AppTheme;
import 'package:flowerly_app/screens/product_details_screen.dart';
import '../models/product_card.dart';

class HomeScreen extends StatefulWidget {
  final Function(Map<String, String>) onAddToCart;
  final List<Map<String, String>> allProducts;
  final Set<int> favoriteIndices;
  final Function(int) onFavoriteToggle;

  const HomeScreen({
    super.key,
    required this.onAddToCart,
    required this.allProducts,
    required this.favoriteIndices,
    required this.onFavoriteToggle,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String searchText = '';

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> filteredFlowers = widget.allProducts
        .where((flower) => flower['name']!
        .toLowerCase()
        .contains(searchText.toLowerCase()))
        .toList();

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppTheme.AppColors.bgLightGreen,
      body: SafeArea(
        child: ListView(
          children: [
            _buildHeader(),
            const SizedBox(height: 16),
            _buildCategorySection(),
            const SizedBox(height: 16),
            _buildPopularTitle(),
            const SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: filteredFlowers.length,
              itemBuilder: (context, index) {
                final flower = filteredFlowers[index];
                final originalIndex = widget.allProducts.indexOf(flower);
                final isFav = widget.favoriteIndices.contains(originalIndex);

                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ProductDetailsScreen(
                            product: flower,
                            onAddToCart: () {
                              widget.onAddToCart(flower);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("${flower['name']} added to cart!"),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                    child: ProductCard(
                      imagePath: flower['image']!,
                      name: flower['name']!,
                      price: flower['price']!,
                      isFavorite: isFav,
                      onFavoriteToggle: () {
                        widget.onFavoriteToggle(originalIndex);
                      },
                      onAddToCart: () {
                        widget.onAddToCart(flower);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("${flower['name']} added to cart!"),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: AppTheme.AppColors.primaryGreen,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Hello, Flower Lover 🌸',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            "What are you looking for today?",
            style: TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: 16),
          TextField(
            onChanged: (value) {
              setState(() {
                searchText = value;
              });
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: "Search flowers...",
              prefixIcon: Icon(Icons.search, color: AppTheme.AppColors.primaryGreen),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategorySection() {
    final categories = ['Roses', 'Tulips', 'Orchids', 'Lily', 'Sunflower'];

    return SizedBox(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(right: 12),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppTheme.AppColors.primaryGreen),
            ),
            child: Center(
              child: Text(
                categories[index],
                style: const TextStyle(color: AppTheme.AppColors.primaryGreen),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPopularTitle() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        "Popular Flowers",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppTheme.AppColors.darkGreen,
        ),
      ),
    );
  }
}
