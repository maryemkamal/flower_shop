import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Map<String, String>> allProducts;
  final Set<int> favoriteIndices;
  final Function(int) onFavoriteToggle;
  final Function(int) onRemoveFavorite;
  final Function(Map<String, String>) onAddToCart;

  const FavoritesScreen({
    super.key,
    required this.allProducts,
    required this.favoriteIndices,
    required this.onFavoriteToggle,
    required this.onRemoveFavorite,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    final favoriteProducts = favoriteIndices.map((i) => allProducts[i]).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        backgroundColor: const Color(0xFF23C16B),
      ),
      body: favoriteProducts.isEmpty
          ? const Center(child: Text('No favorites yet.'))
          : ListView.builder(
        itemCount: favoriteProducts.length,
        itemBuilder: (context, index) {
          final product = favoriteProducts[index];
          final productIndex = allProducts.indexOf(product);

          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              leading: Image.asset(
                product['image'] ?? '',
                width: 60,
                fit: BoxFit.cover,
              ),
              title: Text(product['name'] ?? ''),
              subtitle: Text(product['price'] ?? ''),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                textDirection: TextDirection.rtl,
                children: [
                  // 🗑️ أيقونة الحذف
                  IconButton(
                    icon: const Icon(Iconsax.trash),
                    onPressed: () {
                      onRemoveFavorite(productIndex);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("${product['name']} removed from favorites"),
                        ),
                      );
                    },
                  ),


                  IconButton(
                    icon: const Icon(Iconsax.heart5, color: Colors.red),
                    onPressed: () {
                      onFavoriteToggle(productIndex);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
