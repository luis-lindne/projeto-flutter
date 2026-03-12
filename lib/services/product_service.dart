import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ProductService {
  static const _baseUrl = 'https://dummyjson.com';

  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse('$_baseUrl/products?limit=50'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final list = data['products'] as List;
      return list.map((json) => Product.fromJson(json)).toList();
    }

    throw Exception('Erro ao carregar produtos');
  }
}
