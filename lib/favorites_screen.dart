import 'package:flutter/material.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Map<String, dynamic>> allProducts;
  final Set<int> favoriteIndices;
  final Function(int) onFavoriteToggle;
  final Function(int) onRemoveFavorite;
  final Function(Map<String, dynamic>) onAddToCart;

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
    final favoriteProducts = favoriteIndices
        .map((i) => allProducts[i])
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorites", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF23C16B),
      ),
      body: favoriteProducts.isEmpty
          ? const Center(child: Text("No favorites yet!"))
          : GridView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: favoriteProducts.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                final product = favoriteProducts[index];
                final actualIndex = allProducts.indexOf(
                  product,
                ); // عشان نعرف مكانه الأصلي

                return Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(15),
                          ),
                          child: Image.asset(
                            product['image'],
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              product['name'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text(product['price']),
                            const SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () =>
                                      onRemoveFavorite(actualIndex),
                                ),
                                Expanded(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF23C16B),
                                    ),
                                    onPressed: () => onAddToCart(product),
                                    child: const Text(
                                      "Add to Cart",
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
