import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/product_service.dart';

class ProductProvider extends ChangeNotifier {
  final _productService = ProductService();

  List<Product> _products = [];
  bool _loading = false;
  String? _error;

  List<Product> get products => _products;
  bool get loading => _loading;
  String? get error => _error;

  Future<void> fetchProducts() async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      _products = await _productService.fetchProducts();
    } on Exception catch (e) {
      _error = e.toString().replaceFirst('Exception: ', '');
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> addProduct({
    required String title,
    required double price,
    required String description,
  }) async {
    final product = await _productService.addProduct(
      title: title,
      price: price,
      description: description,
    );
    _products.insert(0, product);
    notifyListeners();
  }

  Future<void> updateProduct(
    int id, {
    required String title,
    required double price,
    required String description,
  }) async {
    final updated = await _productService.updateProduct(
      id,
      title: title,
      price: price,
      description: description,
    );
    final index = _products.indexWhere((p) => p.id == id);
    if (index != -1) {
      _products[index] = updated;
      notifyListeners();
    }
  }

  Future<void> deleteProduct(int id) async {
    await _productService.deleteProduct(id);
    _products.removeWhere((p) => p.id == id);
    notifyListeners();
  }
}
