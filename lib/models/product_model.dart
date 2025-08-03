class ProductModel {
  final String id;
  final String name;
  final double price;
  final String image;
  final bool isFavorite;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    this.isFavorite = false,
  });

  factory ProductModel.fromMap(String id, Map<String, dynamic> data) {
    return ProductModel(
      id: id,
      image: data['image'] ?? '',
      name: data['name'] ?? '',
      price: (data['price'] ?? 0).toDouble(),
      isFavorite: data['isFavorite'] ?? false,
    );
  }
}
