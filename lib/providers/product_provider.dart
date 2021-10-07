import 'package:flutter/material.dart';
import 'package:test/models/product_model.dart';
import 'package:test/services/product_service.dart';

enum ResultState { loading, noData, hasData, error }

class ProductProvider with ChangeNotifier {
  List<ProductModel> _products = [];

  List<ProductModel> get products => _products;
  late ResultState _state;
  String _message = '';
  String get message => _message;
  ResultState get state => _state;
  set products(List<ProductModel> products) {
    _products = products;
    notifyListeners();
  }

  Future<dynamic> getProducts() async {
    try {
      _state = ResultState.loading;
      final product = await ProductService().getProducts();
      if (product.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _products = product;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Check Your Internet Connection';
    }
  }
}
