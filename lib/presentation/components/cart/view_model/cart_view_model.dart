import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/product/product.dart';
import 'cart_model.dart';

final cartViewModelProvider = StateNotifierProvider.autoDispose<CartViewModel, CartModel>((ref) => CartViewModel());

class CartViewModel extends StateNotifier<CartModel> {
  CartViewModel() : super(const CartModel(products: []));

  void addProduct(Product product) {
    state = state.copyWith(products: [...state.products, product]);
  }

  void removeProduct(Product product) {
    state = state.copyWith(products: state.products.where((p) => p.id != product.id).toList());
  }

  void clear() {
    state = const CartModel(products: []);
  }
}
