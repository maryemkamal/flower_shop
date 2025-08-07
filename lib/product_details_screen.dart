import 'package:flutter/material.dart';
import 'package:flowerly_app/resources/app_colors.dart' as AppTheme;

class ProductDetailsScreen extends StatelessWidget {
  final Map<String, String> product;
  final VoidCallback onAddToCart;

  const ProductDetailsScreen({
    super.key,
    required this.product,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.AppColors.bgLightGreen,
      appBar: AppBar(
        backgroundColor: AppTheme.AppColors.primaryGreen,
        title: Text(product['name'] ?? ''),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: 320, // العرض المطلوب في المنتصف
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    product['image'] ?? '',
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  product['name'] ?? '',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.AppColors.darkGreen,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  product['price'] ?? '',
                  style: const TextStyle(
                    fontSize: 18,
                    color: AppTheme.AppColors.primaryGreen,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  "This flower is known for its beauty and fragrance. A perfect gift for any occasion!",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black87),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: onAddToCart,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.AppColors.primaryGreen,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text("Add to Cart"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
