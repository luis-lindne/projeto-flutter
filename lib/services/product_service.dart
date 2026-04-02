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

  Future<Product> addProduct({
    required String title,
    required double price,
    required String description,
  }) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/products/add'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'title': title,
        'price': price,
        'description': description,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return Product.fromJson(jsonDecode(response.body));
    }

    throw Exception('Erro ao adicionar produto');
  }

  Future<Product> updateProduct(
    int id, {
    required String title,
    required double price,
    required String description,
  }) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/products/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'title': title,
        'price': price,
        'description': description,
      }),
    );

    if (response.statusCode == 200) {
      return Product.fromJson(jsonDecode(response.body));
    }

    throw Exception('Erro ao atualizar produto');
  }

  Future<void> deleteProduct(int id) async {
    final response = await http.delete(
      Uri.parse('$_baseUrl/products/$id'),
    );

    if (response.statusCode != 200) {
      throw Exception('Erro ao excluir produto');
    }
  }
}
