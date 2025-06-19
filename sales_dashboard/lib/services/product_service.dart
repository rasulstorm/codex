import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ProductService {
  static Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse('https://dummyjson.com/products'));
    if (response.statusCode != 200) {
      throw Exception('Failed to load products');
    }
    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final products = (data['products'] as List)
        .map((e) => Product.fromJson(e as Map<String, dynamic>))
        .toList();
    return products;
  }
}
