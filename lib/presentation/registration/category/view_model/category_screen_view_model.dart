import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/category/category.dart';
import '../../../../infrastructure/providers/usecase_provider.dart';
import '../../../../usecase/registration/commands/delete_category.dart';
import '../../../../usecase/registration/commands/register_category.dart';
import '../../../../usecase/registration/commands/update_category.dart';
import '../../../../usecase/registration/queries/get_all_categories.dart';
import 'category_screen_model.dart';

final categoryScreenViewModelProvider = StateNotifierProvider<CategoryScreenViewModel, CategoryScreenModel>((ref) => CategoryScreenViewModel(
    ref.read(registerCategoryUsecaseProvider),
    ref.read(getCategoryUsecaseProvider),
    ref.read(updateCategoryUsecaseProvider),
    ref.read(deleteCategoryUsecaseProvider)));

class CategoryScreenViewModel extends StateNotifier<CategoryScreenModel> {
  final RegisterCategory _registerCategory;
  final GetAllCategories _getAllCategory;
  final UpdateCategory _updateCategory;
  final DeleteCategory _deleteCategory;

  CategoryScreenViewModel(this._registerCategory, this._getAllCategory, this._updateCategory, this._deleteCategory) : super(CategoryScreenModel());

  Future<bool> registerCategory(String categoryName) async {
    final category = Category.generate(categoryName);
    try {
      await _registerCategory.execute(category);
      final categories = await _getAllCategory.execute();
      state = state.copyWith(categories: categories);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> getAllCategory() async {
    try {
      final categories = await _getAllCategory.execute();
      state = state.copyWith(categories: categories);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateCategory(Category category, String categoryName) async {
    try {
      final local = category.copyWith(name: categoryName);
      await _updateCategory.execute(local);
      final categories = await _getAllCategory.execute();
      state = state.copyWith(categories: categories);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteCategory(Category category) async {
    try {
      await _deleteCategory.execute(category);
      final categories = await _getAllCategory.execute();
      state = state.copyWith(categories: categories);
      return true;
    } catch (e) {
      return false;
    }
  }
}
