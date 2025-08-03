import 'package:flutter/material.dart';
import '../../resources/app_colors.dart';

class ProductCard extends StatelessWidget {
  final String imagePath;
  final String name;
  final String price;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;
  final VoidCallback onAddToCart;

  const ProductCard({
    super.key,
    required this.imagePath,
    required this.name,
    required this.price,
    required this.isFavorite,
    required this.onFavoriteToggle,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(imagePath, width: 80, height: 80, fit: BoxFit.cover),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: AppColors.darkGreen)),
                const SizedBox(height: 4),
                Text(price,
                    style: const TextStyle(
                        color: AppColors.primaryGreen, fontWeight: FontWeight.w600)),
                const SizedBox(height: 6),
                ElevatedButton(
                  onPressed: onAddToCart,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryGreen,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                  child: const Text("Add to Cart"),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : Colors.grey,
            ),
            onPressed: onFavoriteToggle,
          ),
        ],
      ),
    );
  }
}
