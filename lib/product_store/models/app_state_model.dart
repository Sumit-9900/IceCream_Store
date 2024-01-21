import 'package:flutter/material.dart';
import 'package:store_pro/product_store/data/product_repo.dart';
import 'package:store_pro/product_store/models/icecream.dart';

double _salesTaxRate = 0.18;
double _shippingCostPerItem = 10;

// enum ThemeModeType { light, dark }

class AppStateModel extends ChangeNotifier {
  // ThemeModeType _themeMode = ThemeModeType.light;

  // ThemeModeType get themeMode => _themeMode;

  List<Icecreams> _availableProducts = [];

  final _productsInCart = <int, int>{};

  Map<int, int> get productsInCart => Map.from(_productsInCart);

  // List<Product> get availableProducts => List.from(_availableProducts);

  // void _toggleMode() {
  //   _themeMode = _themeMode == ThemeModeType.light
  //       ? ThemeModeType.dark
  //       : ThemeModeType.light;
  //   notifyListeners();
  // }

  List<Icecreams> getProducts() {
    return _availableProducts;
  }

  Icecreams getProductById(int id) {
    return _availableProducts.firstWhere((element) => element.productId == id);
  }

  // int get totalCartQuantity =>
  //     _productsInCart.values.fold(0, (sum, value) => sum + value);

  double get subtotalCost {
    return _productsInCart.keys
        .map((id) => _availableProducts[id].price! * _productsInCart[id]!)
        .fold(0, (sum, val) => sum + val);
  }

  double get shippingCost {
    return _shippingCostPerItem =
        _productsInCart.values.fold(0, (sum, val) => sum + val);
  }

  double get tax {
    return subtotalCost * _salesTaxRate;
  }

  double get totalCost {
    return subtotalCost + shippingCost + tax;
  }


  void addProductToCart(int productId) {
    if (!productsInCart.containsKey(productId)) {
      _productsInCart[productId] = 1;
    } else {
      _productsInCart[productId] = _productsInCart[productId]! + 1;
    }
    notifyListeners();
  }

  void removeItemFromCart(int productId) {
    if (_productsInCart.containsKey(productId)) {
      if (_productsInCart[productId] == 1) {
        _productsInCart.remove(productId);
      } else {
        _productsInCart[productId] = _productsInCart[productId]! - 1;
      }
    }
    notifyListeners();
  }

  void clearCart() {
    _productsInCart.clear();
    notifyListeners();
  }

  List<Icecreams> search(String query) {
    return _availableProducts
        .where(
          (product) =>
              product.name!.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
  }

  Future<void> loadProducts() async {
    _availableProducts = await ProductRepo.loadAllIceCreams();
    notifyListeners();
  }
}
