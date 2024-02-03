import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/category/category.dart';
import '../../../../domain/product/product.dart';
import '../../../../infrastructure/providers/usecase_provider.dart';
import '../../../../usecase/registration/commands/delete_product.dart';
import '../../../../usecase/registration/commands/register_product.dart';
import '../../../../usecase/registration/commands/update_product.dart';
import '../../../../usecase/registration/queries/get_all_categories.dart';
import '../../../../usecase/registration/queries/get_all_products.dart';
import 'product_screen_model.dart';

final productScreenViewModelProvider = StateNotifierProvider<ProductScreenViewModel, ProductScreenModel>((ref) => ProductScreenViewModel(
    ref.read(getCategoryUsecaseProvider),
    ref.read(registerProductUsecaseProvider),
    ref.read(getAllProductsUsecaseProvider),
    ref.read(updateProductUsecaseProvider),
    ref.read(deleteProductUsecaseProvider)));

class ProductScreenViewModel extends StateNotifier<ProductScreenModel> {
  final GetAllCategories _getAllCategories;

  final RegisterProduct _registerProduct;
  final GetAllProducts _getAllProducts;
  final UpdateProduct _updateProduct;
  final DeleteProduct _deleteProduct;

  ProductScreenViewModel(this._getAllCategories, this._registerProduct, this._getAllProducts, this._updateProduct, this._deleteProduct)
      : super(ProductScreenModel());

  Future<bool> registerProduct(Category category, String productName, String price) async {
    try {
      final product = Product.generate(category.id, productName, int.parse(price));
      await _registerProduct.execute(product);
      final products = await _getAllProducts.execute();
      state = state.copyWith(products: products);
      return true;
    } catch (e) {
      return false;
    }
  }

  // TODO 商品にカテゴリーを持たせてカテゴリーを取得するようにする
  Future<bool> getAllCategory() async {
    try {
      final categories = await _getAllCategories.execute();
      state = state.copyWith(categories: categories);
      return true;
    } catch (e) {
      return false;
    }
  }

  // TODO カテゴリーごとに取得する
  Future<bool> getAllProducts() async {
    try {
      final products = await _getAllProducts.execute();
      state = state.copyWith(products: products);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateProduct(Product product, String productName, String price) async {
    try {
      final local = product.copyWith(name: productName, price: int.parse(price));
      await _updateProduct.execute(local);
      final products = await _getAllProducts.execute();
      state = state.copyWith(products: products);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteProduct(Product product) async {
    try {
      await _deleteProduct.execute(product);
      final products = await _getAllProducts.execute();
      state = state.copyWith(products: products);
      return true;
    } catch (e) {
      return false;
    }
  }
}
