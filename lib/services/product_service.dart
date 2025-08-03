import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product_model.dart';

class ProductService {
  final _productRef = FirebaseFirestore.instance.collection('products');

  Future<List<ProductModel>> getAllProducts() async {
    final snapshot = await _productRef.get();
    return snapshot.docs
        .map((doc) => ProductModel.fromMap(doc.id, doc.data()))
        .toList();
  }
}
