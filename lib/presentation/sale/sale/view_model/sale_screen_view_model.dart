import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../infrastructure/providers/usecase_provider.dart';
import '../../../../usecase/registration/queries/get_all_categories.dart';
import '../../../../usecase/registration/queries/get_all_products.dart';
import 'sale_screen_model.dart';

final saleScreenViewModelProvider = StateNotifierProvider<SaleScreenViewModel, SaleScreenModel>(
    (ref) => SaleScreenViewModel(ref.read(getCategoryUsecaseProvider), ref.read(getAllProductsUsecaseProvider)));

class SaleScreenViewModel extends StateNotifier<SaleScreenModel> {
  final GetAllCategories _getAllCategories;
  final GetAllProducts _getAllProducts;

  SaleScreenViewModel(this._getAllCategories, this._getAllProducts) : super(SaleScreenModel());

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
}
